# Fish config.fish
# Reef bash compatibility is handled by /usr/share/fish/vendor_conf.d/reef.fish
# (installed with reef). No manual hook needed here.

# Fix reef __reef_setup stdout leak: the `bind -M insert \r 2>/dev/null`
# query in __reef_setup only suppresses stderr, leaking the binding listing
# to stdout on every shell start. Wrap the function to suppress stdout.
if functions -q __reef_setup
    functions -c __reef_setup __reef_setup_orig
    function __reef_setup --on-event fish_prompt
        __reef_setup_orig >/dev/null
    end
end
