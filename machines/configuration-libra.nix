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
    exa
    cava
    killall
    fd
    bottom
    neomutt
    isync
    gnumake
    source-code-pro
    nix-tree
    spotify
    starship
    zathura
    screen
    lame
    file
    rofi-wayland
    procs
    du-dust
    texlive.combined.scheme-full
    jq
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
    julia
    playerctl
    gammastep
    (python3.withPackages(ps: with ps; [
                          matplotlib
                          habanero
                          pyperclip
                          unidecode
                          colorama
    ]))
    imagemagick
    gimp
    lynx
    ocrmypdf
    pandoc
    pdftk
    neofetch
    libreoffice
    feh
    pplatex
    grim
    vivid
    slurp
    ranger
    vlc
    zip
    handlr
    sway
    swaylock
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
      ../systemd/systemd.nix
      ../alacritty/alacritty.nix
      ../neovim/neovim.nix
      ../starship/starship.nix
      ../cava/cava.nix
      ../latex/latex.nix
      ../mime/mime.nix
      ../ripgrep/ripgrep.nix
      ../rclone/rclone.nix
      ../sway/sway.nix
      ../waybar/waybar.nix
      ../neomutt/neomutt.nix
      ../bitwarden/bitwarden.nix
      ../mbsync/mbsync.nix
      ../zathura/zathura.nix
      ../feh/feh.nix
      ../rofi/rofi.nix
      ../git/git.nix
    ];

    home.stateVersion = "23.05";
  };


  # release: do not edit without reading documentation
  system.stateVersion = "23.05";
}
