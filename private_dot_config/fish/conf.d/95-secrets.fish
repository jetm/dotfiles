# Source shell-agnostic KEY=VALUE secrets file
# Format: KEY=VALUE (no export, no set -gx, comments with #)
set -l secrets_file $HOME/.config/secrets.env
if test -f $secrets_file
    while read -l line
        # Skip empty lines and comments
        if test -z "$line"; or string match -q '#*' -- $line
            continue
        end
        # Split on first = sign
        set -l kv (string split -m 1 '=' -- $line)
        if test (count $kv) -eq 2
            set -gx $kv[1] $kv[2]
        end
    end <$secrets_file
end
