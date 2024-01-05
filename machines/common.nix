# TODO decide where this file should live in repo
# TODO tidy all of this file

{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration-libra.nix
    <home-manager/nixos>
  ];

  # boot
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # video and sound
  hardware.opengl.driSupport32Bit = true;
  services.pipewire = {
      enable = true;
      alsa.enable = true;
      pulse.enable = true;
  };

  # greeter
  services.greetd = {
    enable = true;
    settings = rec {
      initial_session = {
        command = "${pkgs.sway}/bin/sway";
        user = "will";
      };
      default_session = initial_session;
    };
  };

  # network
  networking.networkmanager.enable = true;

  # locale
  time.timeZone = "America/New_York";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # fonts
  fonts.packages = with pkgs; [
      source-code-pro
      fira
      libre-baskerville
  ];

  # screen sharing
  xdg.portal = {
      enable = true;
      wlr.enable = true;
      extraPortals = [ pkgs.xdg-desktop-portal-gtk pkgs.xdg-desktop-portal-wlr ];
  };


  # keymap
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };

  # environment variables
  environment.sessionVariables = {
    MOZ_ENABLE_WAYLAND = "0";
  };

  # packages
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = "nix-command flakes";

  # TODO pull these out into their own files
  environment.systemPackages =
      let
      commonPackages = with pkgs; [
          alacritty
          vim
          wl-clipboard
          git
          home-manager
          firefox-bin
          ghostscript
          fdupes
          pulseaudio
          wayland
          waybar
          aspell
          aspellDicts.en
          bat
          diff-so-fancy
          ripgrep
          fzf
          bundler
          ruby
          eza
          fd
          bottom
          neomutt
          isync
          gnumake
          source-code-pro
          nix-tree
          tree-sitter
          nodejs-slim
          gcc
          todoist
          lm_sensors
          bundix
          spotify
          rustc
          cargo
          starship
          zathura
          screen
          lame
          file
          rofi-wayland
          procs
          procps
          du-dust
          texlive.combined.scheme-full
          jq
          nix-index
          bitwarden-cli
          inkscape
          rclone
          lutris
          tldr
          hyperfine
          goobook
          steam
          pavucontrol
          diffpdf
          watchexec
          phinger-cursors
          bash-completion
          complete-alias
          julia
          playerctl
          gammastep
          python3
          imagemagick
          gimp
          lynx
          ocrmypdf
          pandoc
          pdftk
          libreoffice
          feh
          pplatex
          grim
          vivid
          slurp
          ranger
          poppler_utils
          pngquant
          vlc
          zip
          unzip
          sway
          wine
          swaylock
          numbat
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
      ];
      libraPackages = with pkgs; [
      # TODO remove if I don't need machine-specific packages
      ];
      xanthPackages = with pkgs; [
      ];
      in commonPackages ++
          (if config.networking.hostName == "libra" then
           libraPackages else xanthPackages);

  programs.sway.enable = true;
  programs.steam.enable = true;
  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };

  security.pam.services.swaylock.text = "auth include login";
  services.dbus.enable = true;

  # user
  users.users.will = {
    isNormalUser = true;
    description = "Will Underwood";
    extraGroups = [ "networkmanager" "wheel" "audio" ];
  };

  services.getty.autologinUser = "will";

  # home
  # TODO put this in a separate file too
  home-manager.users.will = { pkgs, osConfig, ... }: {
    imports = [
      ../config/bash/bash.nix
      ../config/systemd/systemd.nix
      ../config/alacritty/alacritty.nix
      ../config/neovim/neovim.nix
      ../config/starship/starship.nix
      ../config/latex/latex.nix
      ../config/mime/mime.nix
      ../config/ripgrep/ripgrep.nix
      ../config/rclone/rclone.nix
      ../config/sway/sway.nix
      ../config/sway/swaylock.nix
      ../config/waybar/waybar.nix
      ../config/neomutt/neomutt.nix
      ../config/mbsync/mbsync.nix
      ../config/zathura/zathura.nix
      ../config/feh/feh.nix
      ../config/rofi/rofi.nix
      ../config/git/git.nix
      ../config/vivid/vivid.nix
    ];

    # original release: do not edit
    home.stateVersion = "23.05";
  };

  # original release: do not edit
  system.stateVersion = "23.05";
}
