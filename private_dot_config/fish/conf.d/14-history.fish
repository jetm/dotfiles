# History + Atuin
# Fish history is managed automatically; atuin takes over history search
if command -q atuin
    atuin init fish | source
end
