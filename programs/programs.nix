{ pkgs, ... }:
    with pkgs; [
        (callPackage ../programs/todo-finder/todo-finder.nix { })
        (callPackage ../programs/spell-check/spell-check.nix { })
        (callPackage ../programs/tex-check/tex-check.nix { })
        (callPackage ../programs/long-lines/long-lines.nix { })
        (callPackage ../programs/cd-fuzzy.nix { })
        (callPackage ../programs/feh-fuzzy.nix { })
        (callPackage ../programs/zathura-fuzzy.nix { })
        (callPackage ../programs/spell-check-word.nix { })
        (callPackage ../programs/compress-pdf/compress-pdf.nix { })
        (callPackage ../programs/bw-get.nix { })
        (callPackage ../programs/repos.nix { })
        (callPackage ../programs/tex-clean.nix { })
        (callPackage ../programs/latexindent-fast.nix { })
        (callPackage ../programs/bib-down/bib-down.nix { })
        (callPackage ../programs/gammatoggle.nix { })
        (callPackage ../programs/sway-empty/sway-empty.nix { })
        (callPackage ../programs/rclone-sync/rclone-sync.nix { })
        (callPackage ../programs/rofi-start/rofi-start.nix { })
        (callPackage ../programs/nixos-update.nix { })
    ]

