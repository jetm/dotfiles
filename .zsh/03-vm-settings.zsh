#
# VM settings
#
HPE_PROXY=http://web-proxy.rose.hpecorp.net:8088

# All variables in lowercase
export http_proxy="${HPE_PROXY}"
export https_proxy="${HPE_PROXY}"
export ftp_proxy="${HPE_PROXY}"

# All variables in UPPERCASE
export HTTP_PROXY="${HPE_PROXY}"
export HTTPS_PROXY="${HPE_PROXY}"
export FTP_PROXY="${HPE_PROXY}"
export no_proxy='localhost,127.0.0.1,localhost6,::1,.localdomain,hpecorp.net'

export EDITOR="nvim"

alias gerrit-code-nos="ssh -p 29418 javier.tia@code-nos.rose.rdlabs.hpecorp.net"

# COV_PATH=/aruba/halon/infra/coverity/cov-analysis-linux64-8.0.0/bin
# if [ -d ${COV_PATH} ]; then
  # PATH=${COV_PATH}:"${PATH}"
# fi

# add user base to python path
# __PYTHON_PATH=$(python -c "import site, os; print(os.path.join(site.USER_BASE, 'lib', 'python3.4', 'site-packages'))"):$PYTHONPATH
# export PYTHONPATH="${__PYTHON_PATH}"

LOCAL_PATH=/usr/local/bin
if [ -d ${LOCAL_PATH} ]; then
  PATH=${LOCAL_PATH}:"${PATH}"
fi

if [[ $(lsb_release -i) = *Ubuntu* ]]; then
   source /aruba/halon/infra/halon.profile
   remove_PATH_duplicates
   unalias bb
fi

function mvI() {
  if [ "$#" -ne 1 ] || [ ! -f "$1" ]; then
    command mv "$@"
    return
  fi

  newfilename="$1"
  vared newfilename
  command mv -v -- "$1" "$newfilename"
}
