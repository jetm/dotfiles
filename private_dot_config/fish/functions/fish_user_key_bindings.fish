function fish_user_key_bindings
    # Inherit vi key bindings as base
    fish_vi_key_bindings

    # --- CopyQ vi-mode clipboard wrappers ---
    # Visual mode: yank/delete/change sync to CopyQ
    bind -M visual y __vi_yank_to_copyq
    bind -M visual d __vi_delete_to_copyq
    bind -M visual x __vi_x_to_copyq
    bind -M visual c __vi_change_to_copyq

    # Normal mode: operations sync to CopyQ
    bind -M default dd __vi_dd_to_copyq
    bind -M default yy __vi_yy_to_copyq
    bind -M default D __vi_D_to_copyq
    bind -M default Y __vi_Y_to_copyq
    bind -M default x __vi_x_normal_to_copyq
    bind -M default C __vi_C_to_copyq
    bind -M default p __vi_p_to_copyq
    bind -M default P __vi_P_to_copyq

    # --- Atuin keybindings ---
    bind -M insert ctrl-r _atuin_search
    bind -M default / _atuin_search
    bind -M insert alt-up _atuin_search
    bind -M default k _atuin_search
    bind -M insert ctrl-t _atuin_search

    # --- fzf keybindings ---
    bind -M insert ctrl-p _fzf_search_directory
    bind -M default ctrl-p _fzf_search_directory

    # --- Custom keybindings ---
    bind -M insert ctrl-f fzf_ripgrep
    bind -M default ctrl-f fzf_ripgrep
    bind -M insert ctrl-z fancy_ctrl_z
    bind -M insert ctrl-d __fish_exit
    bind -M insert ctrl-n 'clear; commandline -f repaint'

    # --- Vi normal mode extras ---
    bind -M default ctrl-e edit_command_buffer
end
