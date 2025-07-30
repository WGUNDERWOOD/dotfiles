{pkgs ? import <nixpkgs> {}}:
pkgs.writeShellApplication {
  name = "reference-project";
  runtimeInputs = with pkgs; [fd fzf git coreutils zathura];
  text = ''
    QUERY="$1"
    GIT_ROOT=$(git rev-parse --show-toplevel 2>/dev/null)

    if [[ -z "$GIT_ROOT" ]]; then
      echo "Not inside a Git repository!"
      exit 1
    fi

    PROJECT_REFS="$GIT_ROOT/refs.txt"
    SELECTED=$(fzf --filter="$QUERY" < "$PROJECT_REFS" | head -n 1)
    REFS="$HOME/github/references/"
    PATH=$(fd "$SELECTED" "$REFS")
    echo "$PATH"
    ${pkgs.zathura}/bin/zathura "$PATH" &
  '';
}
