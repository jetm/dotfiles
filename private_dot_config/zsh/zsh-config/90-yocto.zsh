# shellcheck disable=2148
#
# Yocto setup
#
export SSTATE_DIR="${HOME}"/repos/work/cache/sstate
export DL_DIR="${HOME}"/repos/work/cache/downloads
export NPROC=$(($(nproc)+1))

# Yocto/Poky/OE
export KAS_CONTAINER_ENGINE=docker
# export KAS_CONTAINER_ENGINE=podman

# export KAS_CONTAINER_IMAGE=ghcr.io/siemens/kas/kas:latest
export KAS_CONTAINER_IMAGE=jetm/kas-build-env

# vim:set ft=zsh ts=2 sw=2 et:
