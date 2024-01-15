{pkgs ? import <nixpkgs> {}}:
pkgs.writeShellApplication {
  name = "rclone-sync";
  runtimeInputs = with pkgs; [rclone];
  text = builtins.readFile ./rclone-sync.sh;
}
