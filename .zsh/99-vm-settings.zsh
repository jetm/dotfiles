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

if [[ $(lsb_release -i) = *Ubuntu* ]]; then
  source /aruba/halon/infra/halon.profile
  remove_PATH_duplicates
  # unalias bb
fi

# vim:set ts=2 sw=2 et:
