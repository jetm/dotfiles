# GPG/SSH agent setup
if command -q gpg-agent
    set -gx GPG_TTY (tty)
    gpg-connect-agent updatestartuptty /bye >/dev/null 2>&1
end
