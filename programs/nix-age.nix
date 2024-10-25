{pkgs ? import <nixpkgs> {}}:
pkgs.writeShellApplication {
  name = "nix-age";
  runtimeInputs = with pkgs; [python311Packages.colout jq coreutils];
  text = ''
    cat "$@" \
      | jq '.nodes | del(.root) | map_values(.locked.lastModified)' \
      | jq 'to_entries | sort_by(.value)' \
      | jq -r 'map(.key + ": " + (.value | strftime("%Y-%m-%d"))) | .[]' \
      | colout "^([^ ]*) ([0-9-]*)" blue,cyan
  '';
}
