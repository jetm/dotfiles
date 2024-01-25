if ! status is-interactive
    # Commands to run in interactive sessions can go here
end

# fish is not ready yet. Lack of good vi mode
set -U fish_greeting
set -Ux EDITOR nvim
fish_vi_key_bindings insert
