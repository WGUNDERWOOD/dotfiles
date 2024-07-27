{pkgs ? import <nixpkgs> {}}:
pkgs.writeShellApplication {
  name = "cd-fuzzy";
  runtimeInputs = with pkgs; [findutils fzf coreutils];
  text = ''
    file=$(find "$HOME/github" "$HOME/overleaf" "$HOME/rclone" \
           -type f -print | fzf --tac)
    dir=$(dirname "$file")
    [[ -n "$file" ]] && cd "$dir"
    exec bash
  '';
}
