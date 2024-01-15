{pkgs ? import <nixpkgs> {}}:
pkgs.writeShellApplication {
  name = "latexindent-fast";
  runtimeInputs = with pkgs; [coreutils texlive.combined.scheme-full];
  text = ''
    file="$(realpath "$1")"
    sha="$(sha256sum "$file")"
    shafile="$file.sha256"

    indent_and_update_sha () {
        latexindent -wd -s -m "$file"
        new_sha="$(sha256sum "$file")"
        echo "$new_sha" > "$shafile"
    }

    if [ -f "$shafile" ]; then
        oldsha="$(cat "$file.sha256")"
        if [ "$sha" != "$oldsha" ]; then
            # sha has changed
            indent_and_update_sha
        fi
    else
        # sha file does not exist
        indent_and_update_sha
    fi
  '';
}
