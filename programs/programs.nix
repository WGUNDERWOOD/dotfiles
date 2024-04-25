{pkgs, ...}:
with pkgs; [
  (callPackage ./bib-down/bib-down.nix {})
  (callPackage ./blur-wallpaper.nix {})
  (callPackage ./bw-get.nix {})
  (callPackage ./cd-fuzzy.nix {})
  (callPackage ./compress-pdf/compress-pdf.nix {})
  (callPackage ./compress-mp3.nix {})
  (callPackage ./feh-fuzzy.nix {})
  (callPackage ./gammatoggle.nix {})
  (callPackage ./img-diff/img-diff.nix {})
  (callPackage ./long-lines/long-lines.nix {})
  (callPackage ./pdf-insert-blank-pages.nix {})
  (callPackage ./player-art.nix {})
  (callPackage ./rclone-sync/rclone-sync.nix {})
  (callPackage ./rename-pdf/rename-pdf.nix {})
  (callPackage ./repos.nix {})
  (callPackage ./rofi-start/rofi-start.nix {})
  (callPackage ./spell-check/spell-check.nix {})
  (callPackage ./spell-check-word.nix {})
  (callPackage ./spell-check-fix.nix {})
  (callPackage ./sway-empty/sway-empty.nix {})
  (callPackage ./tex-build/tex-build.nix {})
  (callPackage ./tex-check/tex-check.nix {})
  (callPackage ./tex-clean/tex-clean.nix {})
  (callPackage (pkgs.fetchFromGitHub {
    owner = "wgunderwood";
    repo = "tex-fmt";
    rev = "495cf17c6aa28ec9e257389fe62d1f1731169a86";
    sha256 = "sha256-I6qNCvDEkPefkXEoSEOluNJcAqgX1RjB+rMwDfykpHQ=";
  }) {})
  (callPackage ./todo-finder/todo-finder.nix {})
  (callPackage ./zathura-fuzzy.nix {})
]
