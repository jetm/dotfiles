# shellcheck disable=SC2148
# Update the feeds
# ./scripts/feeds update -a
# ./scripts/feeds install -a

# echo CONFIG_ALL=y >> .config
# echo CONFIG_TARGET_MULTI_PROFILE=y >> .config
# echo CONFIG_TARGET_PER_DEVICE_ROOTFS=y >> .config
# echo CONFIG_TARGET_ALL_PROFILES=y >> .config
# echo "CONFIG_TARGET_armsr=y" >> .config
# echo "CONFIG_TARGET_armsr_armv7=y" >> .config
#
# make defconfig
#
# make tools/tar/compile -j$(nproc)
#
# make package/download package/check FIXUP=1 -j$(nproc)
#
# make tools/install -j$(nproc)

rm -f .config

echo CONFIG_ALL=y >> .config
echo CONFIG_TARGET_armsr=y >> .config
# echo CONFIG_TARGET_armsr_armv7=y >> .config
# echo CONFIG_TARGET_DEVICE_armsr_armv7_DEVICE_generic=y >> .config
echo CONFIG_TARGET_armsr_armv8=y >> .config
echo CONFIG_TARGET_DEVICE_armsr_armv8_DEVICE_generic=y >> .config

echo CONFIG_KERNEL_WERROR=y >> .config
echo CONFIG_ALL_KMODS=y >> .config
echo CONFIG_DEVEL=y >> .config
echo CONFIG_CCACHE=y >> .config
echo 'CONFIG_CCACHE_DIR="/home/tiamarin/repos/work/openwrt/.ccache"' >> .config

echo CONFIG_BUILD_NLS=y >> .config
echo CONFIG_AUTOREBUILD=y >> .config
echo CONFIG_BUILD_LOG=y >> .config
echo 'CONFIG_BUILD_LOG_DIR="/tmp/build_logs"' >> .config
echo CONFIG_MOLD=y >> .config

make defconfig

make toolchain/install -j$(nproc)
make target/compile -j$(nproc)