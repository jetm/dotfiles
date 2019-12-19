# set -e

REPO_DIR=~/repos/halon/halon-repo/halon-src/hpe-switchd-dune-plugin
BUILD_DIR="${REPO_DIR}"/cmake-build-debug

# OPENSSL_FLAGS="-DOPENSSL_ROOT_DIR=~/var/local/lib \
  # -DOPENSSL_INCLUDE_DIR=~/var/local/include"

cmake_build_clean() {
  # test -n "${CCACHE}" && ccache -C
  cd ${REPO_DIR} && git clean -xdf test/criterion

  if [[ -d ${BUILD_DIR} ]]; then
    echo "Deleting ${BUILD_DIR}..."
    rm -rf ${BUILD_DIR}
  fi

  mkdir ${BUILD_DIR} && cd ${BUILD_DIR}
}

generate_ycm() {
  TEMP_BUILD_DIR=$(mktemp -d)
  cd "${TEMP_BUILD_DIR}" && \
    cmake ${REPO_DIR} && \
    ~/repos/YCM-Generator/config_gen.py --force --preserve-environment \
    --language c --output ${REPO_DIR}/.ycm_extra_conf.py .
  rm -rf "${TEMP_BUILD_DIR}"
}

cmake_build() {
  # set -x
  PARAMS=$*
  cmake_build_clean
  eval "${PARAMS} ${REPO_DIR}"
}

# get number of processors plus one
NUMCPUS=$(( $(getconf _NPROCESSORS_ONLN) + 2 ))

if [[ "$1" == "C" ]]; then
  cmake_build_clean
elif [[ "$1" == "clang" ]]; then
  cmake_build CC=clang cmake
elif [[ "$1" == "sa" ]]; then
  cmake_build CC=/usr/lib/clang/ccc-analyzer cmake
  scan-build make
elif [[ "$1" == "aubsan" ]]; then
  cmake_build CC=clang cmake -DAUBSAN=ON
elif [[ "$1" == "msan" ]]; then
  cmake_build CC=clang cmake -DMSAN=ON
elif [[ "$1" == "tsan" ]]; then
  cmake_build CC=clang cmake -DTSAN=ON
elif [[ "$1" == "ycm" ]]; then
  generate_ycm
elif [[ "$1" == "ubuntu" ]]; then
  ~/repos/github-hpe/dockerfiles/halon/run-docker-halon
elif [[ "$1" == "ld" ]]; then
  # Enable colors and use ld linker
  cmake_build \
    CFLAGS=\'-fdiagnostics-color=always \' \
    cmake && \
    time nice cmake --build ${BUILD_DIR} -- \
      --jobs="${NUMCPUS}" --load-average="${NUMCPUS}"
  ~/repos/github-hpe/dockerfiles/halon/run-docker-halon
else
  # Enable colors and use Gold linker, instead of ld
  # cmake -DCMAKE_LINKER=/usr/bin/ld.lld && \
  cmake_build \
    CFLAGS=\'-fdiagnostics-color=always\' \
    LDFLAGS=\'-Wl,--allow-shlib-undefined\' \
    cmake -DCMAKE_LINKER=/usr/bin/ld.gold && \
    time nice cmake --build ${BUILD_DIR} -- \
      --jobs="${NUMCPUS}" --load-average="${NUMCPUS}"
fi

# vim:set ft=sh ts=2 sw=2 et:
