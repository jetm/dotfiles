# PATH configuration
fish_add_path $HOME/.local/bin
fish_add_path $HOME/.local/share/cargo/bin

if test -d $HOME/go
    set -gx GOPATH $HOME/go
    fish_add_path $HOME/go/bin
end

# last to have as preference over other paths
fish_add_path $HOME/bin

if command -q ccache
    fish_add_path /usr/lib/ccache/bin
end
