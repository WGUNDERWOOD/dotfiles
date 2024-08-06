{pkgs ? import <nixpkgs> {}}:
pkgs.writeShellApplication {
  name = "zathura-fuzzy";
  runtimeInputs = with pkgs; [findutils fzf coreutils screen zathura];
  text = ''
    file=$(find "$@" -type f -name '*.pdf' -print | fzf --tac)
    echo "$file"
    [[ -n "$file" ]] && screen -d -m zathura "$file" && sleep 0.1
  '';
}
