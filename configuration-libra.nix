{ config, pkgs, ... }:

{
  imports = [ ./hardware-configuration.nix ];

  # boot
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

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

  # keymap
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };

  # user
  users.users.will = {
    isNormalUser = true;
    description = "Will Underwood";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };

  services.getty.autologinUser = "will";

  # packages
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = "nix-command flakes"

  environment.systemPackages = with pkgs; [
    alacritty
    vim 
    git
    firefox
    aspell
    bat
    diff-so-fancy
    ripgrep
    exa # what about eza?
    fd
    bottom
    neomutt
    isync # this is mbsync
    gnumake
    spotify
    starship
    zathura
  ];

  programs.sway.enable = true;
  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };

  # release: do not edit without reading documentation
  system.stateVersion = "23.05";
}
