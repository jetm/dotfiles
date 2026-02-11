# Arch Linux specific abbreviations
if test -f /etc/arch-release; or test -f /etc/manjaro-release
    abbr -a paorph 'sudo pacman -Rs (pacman -Qtdq)'
    abbr -a paremALL 'sudo pacman -Scc'

    if command -q pikaur
        abbr -a parem 'pikaur -Rns'
        abbr -a paud 'pikaur -Syu'
        abbr -a pain 'pikaur -S'
        abbr -a pains 'pikaur -U'
        abbr -a pasp pikaur
    end

    if command -q paccache
        abbr -a paclear 'sudo paccache -rvk3'
    end
end
