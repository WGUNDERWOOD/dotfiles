{pkgs ? import <nixpkgs> {}}:
pkgs.writeShellApplication {
  name = "zathura-fuzzy";
  runtimeInputs = with pkgs; [fd fzf coreutils screen zathura];
  text = ''
    file=$(fd -I -t f -e pdf . "$@" | fzf --tac)
    echo "$file"
    [[ -n "$file" ]] && screen -d -m zathura "$file" && sleep 0.1
  '';
}
