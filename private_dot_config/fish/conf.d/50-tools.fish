# Tool initialization

# Zoxide (smart directory jumping via 'j' command)
# reef-tools.fish (vendor_conf.d) also inits zoxide with --cmd cd,
# creating cd/cdi/z/zi aliases. Remove those — we only want 'j'.
if command -q zoxide
    # Remove reef's aliases and wrappers (internal funcs are shared)
    functions -e z zi 2>/dev/null
    abbr --erase cd cdi 2>/dev/null
    zoxide init fish --cmd j | source
end
