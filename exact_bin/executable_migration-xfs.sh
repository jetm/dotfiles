#!/bin/bash
# Enhanced Arch Linux migration: ext4 root -> xfs root on new SSD with EFI preservation

set -euo pipefail -o errtrace

# Parse command line arguments
DRY_RUN=false
while [[ $# -gt 0 ]]; do
    case $1 in
    --dry-run)
        DRY_RUN=true
        shift
        ;;
    *)
        echo "Unknown option: $1"
        echo "Usage: $0 [--dry-run]"
        exit 1
        ;;
    esac
done

# === CONFIGURE THESE VARIABLES ===
SRC_EFI_UUID="F123-9868"                             # Source EFI partition UUID
SRC_ROOT_UUID="fb733bb1-dfa2-4cde-9e9b-3e874ba4a2d1" # Source root partition UUID
NEW_DRIVE="/dev/nvme1n1"                              # Change this to your new SSD device
NEW_ROOT="/dev/nvme1n1p2"                             # Target root partition (will be created/formatted)
NEW_EFI="/dev/nvme1n1p1"                              # Target EFI partition (will be created/formatted)
MNT="/mnt/newroot"
EFI_MNT="$MNT/boot/efi"
TEMP_EFI_MNT="/mnt/temp_efi"
# ================================

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Global variables
XFS_AGCOUNT=8
XFS_LOGSIZE=256m
XFS_SU=4k
XFS_SW=1

# Logging function
log() {
    echo -e "${BLUE}[$(date '+%Y-%m-%d %H:%M:%S')]${NC} $1"
}

error() {
    echo -e "${RED}[ERROR]${NC} $1" >&2
}

warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

# Boot mode detection
check_boot_mode() {
    log "Checking boot mode..."
    if [[ -d "/sys/firmware/efi" ]]; then
        success "UEFI boot mode detected"
    else
        error "BIOS boot mode detected. This script only supports UEFI systems."
        exit 1
    fi
}

# Space validation
check_disk_space() {
    local target_drive="$1"

    log "Checking disk space requirements..."

    # Get used space on root filesystem (in bytes)
    local used_space
    used_space=$(df --output=used / | tail -n1)
    used_space=$((used_space * 1024)) # Convert KB to bytes

    # Get target drive size (in bytes)
    local target_size
    target_size=$(blockdev --getsize64 "$target_drive")

    # Calculate required space with 20% safety margin plus XFS metadata overhead (5%)
    local required_space=$((used_space * 125 / 100)) # 25% total overhead

    log "Used space: $(numfmt --to=iec "$used_space")"
    log "Target drive size: $(numfmt --to=iec "$target_size")"
    log "Required space (with safety margin): $(numfmt --to=iec "$required_space")"

    if [[ $target_size -lt $required_space ]]; then
        error "Insufficient space on target drive"
        error "Required: $(numfmt --to=iec "$required_space"), Available: $(numfmt --to=iec "$target_size")"
        exit 1
    fi

    success "Sufficient disk space available"
}

# Dynamic partition detection
wait_for_partition() {
    local partition="$1"
    local timeout=30
    local count=0

    log "Waiting for partition $partition to be available..."

    while [[ $count -lt $timeout ]]; do
        if [[ -b "$partition" ]]; then
            success "Partition $partition is available"
            return 0
        fi
        sleep 1
        ((count++))
    done

    error "Timeout waiting for partition $partition"
    exit 1
}

# Cleanup function for error handling
cleanup() {
    local exit_code=$?

    if [[ $exit_code -ne 0 ]]; then
        error "Script failed with exit code $exit_code"
    fi

    log "Performing cleanup..."

    # Unmount chroot binds if they exist
    for d in /tmp /var/tmp /run /sys /proc /dev/pts /dev; do
        if mountpoint -q "$MNT$d" 2>/dev/null; then
            log "Unmounting $MNT$d"
            umount "$MNT$d" || true
        fi
    done

    # Unmount temporary EFI mount
    if mountpoint -q "$TEMP_EFI_MNT" 2>/dev/null; then
        log "Unmounting temporary EFI mount"
        umount "$TEMP_EFI_MNT" || true
    fi

    # Unmount target partitions
    if mountpoint -q "$EFI_MNT" 2>/dev/null; then
        log "Unmounting EFI partition"
        umount "$EFI_MNT" || true
    fi

    if mountpoint -q "$MNT" 2>/dev/null; then
        log "Unmounting root partition"
        umount "$MNT" || true
    fi

    # Remove temporary directories
    if [ -d "$TEMP_EFI_MNT" ]; then
        rmdir "$TEMP_EFI_MNT" 2>/dev/null || true
    fi

    if [[ $exit_code -ne 0 ]]; then
        error "Migration failed. System state has been restored where possible."
    fi
}

# Set trap for cleanup on exit and error
trap cleanup EXIT ERR

# Validation functions
validate_uuid() {
    local uuid="$1"
    local description="$2"

    if ! [[ "$uuid" =~ ^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$|^[0-9a-fA-F]{4}-[0-9a-fA-F]{4}$ ]]; then
        error "Invalid UUID format for $description: $uuid"
        exit 1
    fi
}

check_partition_exists() {
    local uuid="$1"
    local description="$2"

    if ! blkid -U "$uuid" >/dev/null 2>&1; then
        error "$description partition with UUID $uuid not found"
        exit 1
    fi
}

check_dependencies() {
    local deps=("sgdisk" "mkfs.fat" "mkfs.xfs" "rsync" "arch-chroot" "blkid" "partprobe")

    for dep in "${deps[@]}"; do
        if ! command -v "$dep" >/dev/null 2>&1; then
            error "Required dependency '$dep' not found"
            exit 1
        fi
    done
}

# Pre-migration checks
log "Starting enhanced Arch Linux migration to XFS..."

# Check if running as root
if [[ $EUID -ne 0 ]]; then
    error "This script must be run as root"
    exit 1
fi

# Validate dependencies
log "Checking dependencies..."
check_dependencies
success "All dependencies found"

# Check boot mode
check_boot_mode

# Check disk space requirements
check_disk_space "$NEW_DRIVE"

# Validate UUIDs
log "Validating UUIDs..."
validate_uuid "$SRC_EFI_UUID" "source EFI"
validate_uuid "$SRC_ROOT_UUID" "source root"

# Check if source partitions exist
log "Checking source partitions..."
check_partition_exists "$SRC_EFI_UUID" "Source EFI"
check_partition_exists "$SRC_ROOT_UUID" "Source root"

SRC_EFI_DEV=$(blkid -U "$SRC_EFI_UUID")
SRC_ROOT_DEV=$(blkid -U "$SRC_ROOT_UUID")

success "Source partitions found:"
log "  EFI: $SRC_EFI_DEV (UUID: $SRC_EFI_UUID)"
log "  Root: $SRC_ROOT_DEV (UUID: $SRC_ROOT_UUID)"

# Check target drive
if [[ ! -b "$NEW_DRIVE" ]]; then
    error "Target drive $NEW_DRIVE not found"
    exit 1
fi

# Pre-migration backup warning
warning "IMPORTANT: Before proceeding, ensure you have:"
warning "  1. A complete system backup"
warning "  2. A bootable rescue USB/CD"
warning "  3. Verified that $NEW_DRIVE is the correct target device"
warning ""
warning "This script will:"
warning "  - Completely wipe $NEW_DRIVE"
warning "  - Create new EFI and root partitions"
warning "  - Copy EFI boot files from $SRC_EFI_DEV"
warning "  - Migrate root filesystem from $SRC_ROOT_DEV to XFS"
warning "  - Update fstab and reinstall GRUB"

echo
read -r -p "Are you absolutely sure you want to continue? Type 'yes' to proceed: " confirm
if [[ "$confirm" != "yes" ]]; then
    log "Migration cancelled by user"
    exit 0
fi

# Partitioning with NVMe PCIe Gen5 optimization
log "Partitioning $NEW_DRIVE with NVMe optimization..."

if [[ "$DRY_RUN" == "false" ]]; then
    sgdisk --zap-all "$NEW_DRIVE"
    # Use 1MB alignment (2048 sectors) for optimal NVMe performance
    sgdisk -a 2048 -n 1:0:+256M -t 1:ef00 -c 1:"EFI System Partition" "$NEW_DRIVE"
    sgdisk -a 2048 -n 2:0:0 -t 2:8300 -c 2:"Linux filesystem" "$NEW_DRIVE"
    partprobe "$NEW_DRIVE"

    # Wait for partitions to be available
    wait_for_partition "$NEW_EFI"
    wait_for_partition "$NEW_ROOT"
else
    log "[DRY RUN] Would partition $NEW_DRIVE:"
    log "[DRY RUN]   - EFI partition: 256MB (optimized for GRUB)"
    log "[DRY RUN]   - Root partition: remaining space"
    log "[DRY RUN]   - 1MB alignment for NVMe optimization"
fi

# Verify partitions were created
if [[ ! -b "$NEW_EFI" ]] || [[ ! -b "$NEW_ROOT" ]]; then
    error "Failed to create partitions on $NEW_DRIVE"
    exit 1
fi

success "Partitions created successfully"

# Formatting with NVMe PCIe Gen5 optimization
log "Formatting new partitions with NVMe optimization..."

if [[ "$DRY_RUN" == "false" ]]; then
    mkfs.fat -F32 "$NEW_EFI"

    # XFS optimization for NVMe PCIe Gen5
    log "Creating optimized XFS filesystem..."
    mkfs.xfs -f -K \
        -d agcount=$XFS_AGCOUNT,su=$XFS_SU,sw=$XFS_SW \
        -l size=$XFS_LOGSIZE \
        -n size=64k \
        "$NEW_ROOT"
else
    log "[DRY RUN] Would format partitions:"
    log "[DRY RUN]   - EFI: FAT32"
    log "[DRY RUN]   - Root: XFS with NVMe optimization"
    log "[DRY RUN]     * AG count: $XFS_AGCOUNT"
    log "[DRY RUN]     * Log size: $XFS_LOGSIZE"
    log "[DRY RUN]     * Stripe unit: $XFS_SU"
    log "[DRY RUN]     * Node size: 64k"
fi

success "Partitions formatted successfully"

# Get new UUIDs
NEW_ROOT_UUID=$(blkid -s UUID -o value "$NEW_ROOT")
NEW_EFI_UUID=$(blkid -s UUID -o value "$NEW_EFI")

log "New partition UUIDs:"
log "  EFI: $NEW_EFI_UUID"
log "  Root: $NEW_ROOT_UUID"

# Mount new root
log "Mounting new root partition..."
mkdir -p "$MNT"
mount "$NEW_ROOT" "$MNT"

# Mount new EFI partition
log "Mounting new EFI partition..."
mkdir -p "$EFI_MNT"
mount "$NEW_EFI" "$EFI_MNT"

# Mount source EFI partition temporarily to copy contents
log "Mounting source EFI partition for content preservation..."
mkdir -p "$TEMP_EFI_MNT"
mount "$SRC_EFI_DEV" "$TEMP_EFI_MNT"

# Copy EFI partition contents
log "Preserving EFI boot files from source partition..."
rsync -aAXHv "$TEMP_EFI_MNT/" "$EFI_MNT/"

# Unmount temporary EFI mount
umount "$TEMP_EFI_MNT"
rmdir "$TEMP_EFI_MNT"

success "EFI boot files preserved successfully"

# Migrate root filesystem
log "Migrating root filesystem (this may take several minutes)..."
rsync -aAXHv \
    --exclude={"/dev/*","/proc/*","/sys/*","/tmp/*","/run/*","/mnt/*","/media/*","/lost+found","/boot/efi/*"} \
    / "$MNT/"

success "Root filesystem migration completed"

# Update fstab with new UUIDs and NVMe-optimized mount options
log "Updating /etc/fstab with new UUIDs and NVMe optimization..."

if [[ "$DRY_RUN" == "false" ]]; then
    # Backup original fstab
    backup_file="$MNT/etc/fstab.backup.$(date +%Y%m%d_%H%M%S)"
    cp "$MNT/etc/fstab" "$backup_file"
    log "Created fstab backup: $backup_file"

    # Use awk for more robust fstab editing
    awk -v old_root="$SRC_ROOT_UUID" -v new_root="$NEW_ROOT_UUID" \
        -v old_efi="$SRC_EFI_UUID" -v new_efi="$NEW_EFI_UUID" '
    BEGIN { root_updated = 0; efi_updated = 0 }
    /^UUID=/ {
        if ($1 == "UUID=" old_root && $2 == "/") {
            print "UUID=" new_root "   /   xfs   noatime,nobarrier,largeio,inode64,swalloc   0 1"
            root_updated++
            next
        }
        if ($1 == "UUID=" old_efi && $2 == "/boot/efi") {
            print "UUID=" new_efi "   /boot/efi   vfat   umask=0077   0 2"
            efi_updated++
            next
        }
    }
    { print }
    END {
        if (root_updated != 1) exit 1
        print "# Updated " root_updated " root entry and " efi_updated " EFI entry" > "/dev/stderr"
    }' "$MNT/etc/fstab" >"$MNT/etc/fstab.new"

    if mv "$MNT/etc/fstab.new" "$MNT/etc/fstab"; then
        : # Success, continue
    else
        error "Failed to update fstab correctly"
        exit 1
    fi

    # Verify fstab was updated correctly
    if ! grep -q "UUID=$NEW_ROOT_UUID.*/" "$MNT/etc/fstab"; then
        error "Failed to update root partition in fstab"
        exit 1
    fi

    # Verify NVMe-optimized mount options
    if ! grep -q "noatime,nobarrier,largeio,inode64,swalloc" "$MNT/etc/fstab"; then
        error "Failed to set NVMe-optimized mount options"
        exit 1
    fi
else
    log "[DRY RUN] Would update /etc/fstab:"
    log "[DRY RUN]   - Root UUID: $SRC_ROOT_UUID -> $NEW_ROOT_UUID"
    log "[DRY RUN]   - EFI UUID: $SRC_EFI_UUID -> $NEW_EFI_UUID"
    log "[DRY RUN]   - XFS mount options: noatime,nobarrier,largeio,inode64,swalloc"
fi

success "fstab updated successfully"

# Prepare chroot environment
log "Preparing chroot environment..."

if [[ "$DRY_RUN" == "false" ]]; then
    for d in /dev /dev/pts /proc /sys /run /tmp /var/tmp; do
        log "Binding $d to $MNT$d"
        mount --bind "$d" "$MNT$d"

        # Verify bind mount succeeded
        if ! mountpoint -q "$MNT$d"; then
            error "Failed to bind mount $d"
            exit 1
        fi
    done
else
    log "[DRY RUN] Would bind mount: /dev /dev/pts /proc /sys /run /tmp /var/tmp"
fi

# Install and configure GRUB
log "Installing and configuring GRUB bootloader..."

if [[ "$DRY_RUN" == "false" ]]; then
    if ! arch-chroot "$MNT" /bin/bash <<'EOF'; then
set -e
echo "Inside chroot environment"

# Ensure EFI directory exists and is mounted
if ! mountpoint -q /boot/efi; then
    echo "ERROR: /boot/efi is not mounted in chroot"
    exit 1
fi

# Check EFI partition has sufficient space (256MB should be enough)
efi_space=$(df /boot/efi | awk 'NR==2 {print $4}')
if [[ $efi_space -lt 51200 ]]; then  # 50MB minimum free space
    echo "WARNING: Low space on EFI partition: ${efi_space}KB available"
fi

# Install GRUB for UEFI with removable flag for better compatibility
echo "Installing GRUB..."
grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=GRUB --removable --recheck

# Verify GRUB EFI files were created
if [[ ! -f /boot/efi/EFI/GRUB/grubx64.efi ]] && [[ ! -f /boot/efi/EFI/BOOT/BOOTX64.EFI ]]; then
    echo "ERROR: GRUB EFI files not found"
    exit 1
fi

# Rebuild initramfs to ensure XFS support
echo "Rebuilding initramfs..."
if command -v mkinitcpio >/dev/null 2>&1; then
    mkinitcpio -P
elif command -v dracut >/dev/null 2>&1; then
    dracut --force
else
    echo "WARNING: No supported initramfs generator found"
fi

# Generate GRUB configuration
echo "Generating GRUB configuration..."
grub-mkconfig -o /boot/grub/grub.cfg

# Verify GRUB installation
if [[ ! -f /boot/grub/grub.cfg ]]; then
    echo "ERROR: GRUB configuration not generated"
    exit 1
fi

echo "GRUB installation completed successfully"
EOF
        error "GRUB installation failed"
        exit 1
    fi
else
    log "[DRY RUN] Would install GRUB:"
    log "[DRY RUN]   - Target: x86_64-efi"
    log "[DRY RUN]   - EFI directory: /boot/efi"
    log "[DRY RUN]   - Bootloader ID: GRUB"
    log "[DRY RUN]   - Add --removable flag for compatibility"
    log "[DRY RUN]   - Rebuild initramfs for XFS support"
    log "[DRY RUN]   - Generate GRUB configuration"
fi

success "GRUB bootloader configured successfully"

# Post-migration verification
log "Performing comprehensive post-migration verification..."

# Check if essential files exist
essential_files=("/etc/fstab" "/boot/grub/grub.cfg")
for file in "${essential_files[@]}"; do
    if [[ ! -f "$MNT$file" ]]; then
        error "Essential file missing: $file"
        exit 1
    fi
done

# Verify fstab entries
if ! grep -q "UUID=$NEW_ROOT_UUID" "$MNT/etc/fstab"; then
    error "New root UUID not found in fstab"
    exit 1
fi

# Verify NVMe-optimized mount options in fstab
if ! grep -q "noatime,nobarrier,largeio,inode64,swalloc" "$MNT/etc/fstab"; then
    error "NVMe-optimized mount options not found in fstab"
    exit 1
fi

# Check XFS filesystem with detailed info
if ! xfs_info "$NEW_ROOT" >/dev/null 2>&1; then
    error "XFS filesystem verification failed"
    exit 1
fi

# Verify XFS optimization settings
log "Verifying XFS optimization settings..."
xfs_info "$NEW_ROOT" | while read -r line; do
    if [[ "$line" =~ agcount=([0-9]+) ]]; then
        agcount="${BASH_REMATCH[1]}"
        if [[ $agcount -eq $XFS_AGCOUNT ]]; then
            success "XFS AG count correctly set to $agcount"
        else
            warning "XFS AG count is $agcount, expected $XFS_AGCOUNT"
        fi
    fi
done

# Verify GRUB EFI installation
if [[ -f "$MNT/boot/efi/EFI/GRUB/grubx64.efi" ]] || [[ -f "$MNT/boot/efi/EFI/BOOT/BOOTX64.EFI" ]]; then
    success "GRUB EFI files found"
else
    error "GRUB EFI files missing"
    exit 1
fi

# Final NVMe performance verification
verify_nvme_performance "$NEW_DRIVE"

success "Comprehensive post-migration verification completed"

# Cleanup (handled by trap)
log "Cleaning up..."

if [[ "$DRY_RUN" == "true" ]]; then
    success "Dry run completed successfully!"
    echo
    log "Summary of what would be done:"
    log "  - Validate UEFI boot mode and system health"
    log "  - Create new 256MB EFI partition: $NEW_EFI"
    log "  - Create new XFS root partition: $NEW_ROOT with NVMe optimization"
    log "  - Preserve EFI boot files from source partition"
    log "  - Migrate root filesystem with proper permissions"
    log "  - Update /etc/fstab with new UUIDs and NVMe-optimized mount options"
    log "  - Reinstall GRUB with --removable flag and rebuild initramfs"
    log "  - Perform comprehensive verification including NVMe performance"
    echo
    log "To perform the actual migration, run without --dry-run flag"
else
    success "Migration completed successfully!"
    echo
    log "Summary of changes:"
    log "  - Created new EFI partition: $NEW_EFI (UUID: $NEW_EFI_UUID) - 256MB optimized"
    log "  - Created new XFS root partition: $NEW_ROOT (UUID: $NEW_ROOT_UUID) - NVMe optimized"
    log "  - Preserved EFI boot files from source partition"
    log "  - Migrated root filesystem with proper permissions"
    log "  - Updated /etc/fstab with new UUIDs and NVMe-optimized mount options"
    log "  - Reinstalled and configured GRUB bootloader with enhanced compatibility"
    log "  - Rebuilt initramfs for XFS support"
    echo
    warning "Next steps:"
    warning "  1. Shut down the system"
    warning "  2. Disconnect or disable the old drive"
    warning "  3. Boot from the new drive"
    warning "  4. Verify system functionality"
    warning "  5. Keep the old drive as backup until confirmed working"
fi
