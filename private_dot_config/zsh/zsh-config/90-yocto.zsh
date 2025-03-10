#
# Yocto setup
#
export SSTATE_DIR="${HOME}"/repos/work/cache/sstate
export DL_DIR="${HOME}"/repos/work/cache/downloads
export NPROC=$(($(nproc)+1))

# Yocto/Poky/OE
export KAS_CONTAINER_ENGINE=podman
export KAS_CONTAINER_IMAGE=ghcr.io/siemens/kas/kas:next
