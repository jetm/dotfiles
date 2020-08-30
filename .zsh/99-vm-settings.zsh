#
# VM settings
#
HPE_PROXY=http://web-proxy.rose.hpecorp.net:8080

# All variables in lowercase
export http_proxy="${HPE_PROXY}"
export https_proxy="${HPE_PROXY}"
export ftp_proxy="${HPE_PROXY}"

# All variables in UPPERCASE
export HTTP_PROXY="${HPE_PROXY}"
export HTTPS_PROXY="${HPE_PROXY}"
export FTP_PROXY="${HPE_PROXY}"
export no_proxy="127.0.0.1,localhost,rose.rdlabs.hpecorp.net,in.rdlabs.hpecorp.net,sg.rdlabs.hpecorp.net,stash.arubanetworks.com,jira.arubanetworks.com,confluence.arubanetworks.com,acp-ci.arubanetworks.com,cloudcop.arubathena.com"

export EDITOR="nvim"

alias gerrit-code-nos="ssh -p 29418 javier.tia@code-nos.rose.rdlabs.hpecorp.net"

# Remove duplicates PATH
remove_PATH_duplicates() {
    if [ -n "$PATH" ]; then
        old_PATH=$PATH:; PATH=
        while [ -n "$old_PATH" ]; do
            x=${old_PATH%%:*}      # the first remaining entry
            case $PATH: in
                *:"$x":*) ;;         # already there
                *) PATH=$PATH:$x;;   # not there yet
            esac
            old_PATH=${old_PATH#*:}
        done
        PATH=${PATH#:}
        unset old_PATH x
        export PATH
    fi
}

if [[ $(lsb_release -i) = *Ubuntu* ]]; then
   source /aruba/halon/infra/halon.profile
   remove_PATH_duplicates
   # unalias bb
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

# vim:set ts=2 sw=2 et:
