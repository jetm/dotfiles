# Yocto/work environment variables
set -gx SSTATE_DIR $HOME/repos/work/cache/sstate
set -gx DL_DIR $HOME/repos/work/cache/downloads
set -gx NPROC (math (nproc) + 1)
set -gx KAS_CONTAINER_ENGINE docker
set -gx KAS_CONTAINER_IMAGE jetm/kas-build-env
