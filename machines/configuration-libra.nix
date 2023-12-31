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
  hardware.pulseaudio.enable = true;
  hardware.pulseaudio.support32Bit = true;

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
  networking.hostName = "nixos";
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
  fonts.fonts = with pkgs; [ source-code-pro ];

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

  environment.systemPackages = with pkgs; [
    alacritty
    vim
    wl-clipboard
    git
    home-manager
    firefox-bin
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
    exa
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
    zoom-us
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
    (python3.withPackages(ps: with ps; [
                          matplotlib
                          habanero
                          pyperclip
                          unidecode
                          colorama
                          # TODO can probably remove some of these now
    ]))
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
    vlc
    zip
    unzip
    sway
    wine
    swaylock
    #numbat # TODO needs newer channel
    (callPackage ../programs/todo-finder/todo-finder.nix { })
    (callPackage ../programs/spell-check/spell-check.nix { })
    (callPackage ../programs/tex-check/tex-check.nix { })
    (callPackage ../programs/long-lines/long-lines.nix { })
  ];

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
  home-manager.users.will = { pkgs, ... }: {
    imports = [
      ../bash/bash.nix
      ../config/systemd/systemd.nix
      ../config/alacritty/alacritty.nix
      ../config/neovim/neovim.nix
      ../config/starship/starship.nix
      ../latex/latex.nix
      ../config/mime/mime.nix
      ../config/ripgrep/ripgrep.nix
      ../rclone/rclone.nix
      ../sway/sway.nix
      ../config/waybar/waybar.nix
      ../config/neomutt/neomutt.nix
      ../bitwarden/bitwarden.nix
      ../config/mbsync/mbsync.nix
      ../config/zathura/zathura.nix
      ../config/feh/feh.nix
      ../config/rofi/rofi.nix
      ../git/git.nix
      ../config/vivid/vivid.nix
    ];

    home.stateVersion = "23.05";
  };


  # release: do not edit without reading documentation
  system.stateVersion = "23.05";
}
