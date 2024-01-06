# TODO decide where this file should live in repo
# TODO tidy all of this file

{ config, pkgs, ... }:

{
  imports = [ <home-manager/nixos> ];

  # boot
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # video and sound
  hardware.opengl.driSupport32Bit = true;
  services.pipewire = {enable = true; alsa.enable = true; pulse.enable = true;};
  services.dbus.enable = true;
  xdg.portal = {
      enable = true;
      wlr.enable = true;
      extraPortals = [ pkgs.xdg-desktop-portal-gtk pkgs.xdg-desktop-portal-wlr ];
  };

  # greeter
  services.getty.autologinUser = "will";
  services.greetd = {
    enable = true;
    settings = rec {
      initial_session = {command = "${pkgs.sway}/bin/sway"; user = "will";};
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

  # keymap
  services.xserver = {layout = "us"; xkbVariant = "";};

  # environment variables
  environment.sessionVariables = {
    MOZ_ENABLE_WAYLAND = "0";
  };

  # packages
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = "nix-command flakes";
  environment.systemPackages =
      ( import ../config/packages.nix pkgs ) ++
      ( import ../programs/programs.nix pkgs );
  programs.sway.enable = true;
  programs.steam.enable = true;
  programs.neovim = {enable = true; defaultEditor = true;};
  security.pam.services.swaylock.text = "auth include login";

  # user
  users.users.will = {
    isNormalUser = true;
    description = "Will Underwood";
    extraGroups = [ "networkmanager" "wheel" "audio" ];
  };

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
