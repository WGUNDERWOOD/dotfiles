{ pkgs ? import <nixpkgs> { } }:

pkgs.writeShellApplication {
    name = "nixos-update";
    runtimeInputs = with pkgs; [ coreutils nix nix-info nixos-rebuild ];
    text = ''
        version="$*"
        [[ -z "$version" ]] && echo "specify a version such as 23.05" && exit 1
        [[ "$version" =~ ^[0-9][0-9]\.[0-9][0-9]$ ]] || (echo "version should be formatted as 23.05" && exit 1)
        echo "update nixos and home-manager with"
        echo "    sudo nix-channel --add https://nixos.org/channels/nixos-$version nixos"
        echo "    sudo nix-channel --add https://github.com/nix-community/home-manager/archive/release-$version.tar.gz home-manager"
        echo "    sudo nix-channel --update"
        echo
        echo "then check everything looks ok with"
        echo "    nix-info -m"
        echo
        echo "then upgrade and rebuild the system with:"
        echo "    sudo nixos-rebuild --upgrade boot"
        echo
        echo "finally reboot"
        '';
}

