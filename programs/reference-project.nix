{pkgs ? import <nixpkgs> {}}:
pkgs.writeShellApplication {
  name = "reference-project";
  runtimeInputs = with pkgs; [fd fzf git coreutils zathura];
  text = ''
    GIT_ROOT=$(git rev-parse --show-toplevel)
    PROJECT_REFS="$GIT_ROOT/refs.txt" && [[ -f "$PROJECT_REFS" ]]
    SELECTED=$(fzf < "$PROJECT_REFS")
    REFS="$HOME/github/references/"
    PATH=$(fd "$SELECTED" "$REFS")
    echo "$PATH"
    ${pkgs.zathura}/bin/zathura "$PATH" &
  '';
}
