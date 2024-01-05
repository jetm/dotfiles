# shellcheck disable=SC2148
# Update the feeds
# ./scripts/feeds update -a
# ./scripts/feeds install -a

rm -rf ./tmp
make clean
rm -f .config

echo CONFIG_TARGET_armsr=y >> .config
# echo CONFIG_TARGET_armsr_armv7=y >> .config
echo CONFIG_TARGET_armsr_armv8=y >> .config

echo CONFIG_DEVEL=y >> .config
echo CONFIG_BUILD_LOG=y >> .config
echo 'CONFIG_BUILD_LOG_DIR="/tmp/build_logs"' >> .config
echo CONFIG_CCACHE=y >> .config
echo 'CONFIG_CCACHE_DIR="/home/tiamarin/repos/work/openwrt/.ccache"' >> .config

# Kernel setting to match CI
# echo CONFIG_ALL_KMODS=y >> .config

make defconfig

# make -j "$(nproc)" download
make -j "$(nproc)" world

# make -j $(nproc) tools/tar/compile
# make -j $(nproc) package/download package/check FIXUP=1
# make -j $(nproc) tools/install
# make -j $(nproc) toolchain/install
# make -j $(nproc) target/compile
