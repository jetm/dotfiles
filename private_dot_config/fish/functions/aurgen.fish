function aurgen --description "Validate, build, and generate .SRCINFO for AUR package"
    command -q updpkgsums; or begin
        echo "error: updpkgsums is not installed" >&2
        return 1
    end
    command -q namcap; or begin
        echo "error: namcap is not installed" >&2
        return 1
    end

    if test -f /etc/arch-release; or test -f /etc/manjaro-release
        namcap PKGBUILD
        and updpkgsums
        and makepkg --cleanbuild --syncdeps --force
        and makepkg --printsrcinfo >.SRCINFO
    end
end
