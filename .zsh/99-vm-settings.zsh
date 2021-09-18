#
# VM settings
#
# houston is quicker than rose. Rose sometimes doesn't work
HPE_PROXY=http://web-proxy.houston.hpecorp.net:8080

# All variables in lowercase
export http_proxy="${HPE_PROXY}"
export https_proxy="${HPE_PROXY}"
export ftp_proxy="${HPE_PROXY}"

# All variables in UPPERCASE
export HTTP_PROXY="${HPE_PROXY}"
export HTTPS_PROXY="${HPE_PROXY}"
export FTP_PROXY="${HPE_PROXY}"

# This could be better if some arubanetworks.com hosts are outside of HPE
# export no_proxy="127.0.0.1,localhost,rose.rdlabs.hpecorp.net,in.rdlabs.hpecorp.net,sg.rdlabs.hpecorp.net,stash.arubanetworks.com,jira.arubanetworks.com,confluence.arubanetworks.com,acp-ci.arubanetworks.com,cloudcop.arubathena.com"
export no_proxy="127.0.0.1,localhost,hpecorp.net,arubanetworks.com,arubathena.com,hpe.com"
export NO_PROXY="${no_proxy}"

if [[ $(lsb_release -i) = *Ubuntu* ]]; then
  source /aruba/halon/infra/halon.profile
  remove_PATH_duplicates
  # unalias bb
fi

# vim:set ts=2 sw=2 et:
