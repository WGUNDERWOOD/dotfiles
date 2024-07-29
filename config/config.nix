{
  config,
  pkgs,
  ...
}: {
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
  services.dbus.enable = true;
  services.udev.packages = [pkgs.brillo];
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = with pkgs; [xdg-desktop-portal-gtk xdg-desktop-portal-wlr];
  };

  # printing
  services.printing.enable = true;
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  # greeter
  services.getty.autologinUser = "will";
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

  # keymap
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # environment variables
  environment.sessionVariables = {
    # xdg standard
    XDG_CACHE_HOME = "$HOME/.cache";
    XDG_CONFIG_HOME = "$HOME/.config";
    XDG_DATA_HOME = "$HOME/.local/share";
    XDG_STATE_HOME = "$HOME/.local/state";
    # program home directories
    HISTFILE = "$XDG_STATE_HOME/bash/history";
    LESSHISTFILE = "$XDG_CACHE_HOME/less/history";
    BUNDLE_USER_CONFIG = "$XDG_CONFIG_HOME/bundle";
    BUNDLE_USER_CACHE = "$XDG_CACHE_HOME/bundle";
    BUNDLE_USER_PLUGIN = "$XDG_DATA_HOME/bundle";
    CARGO_HOME = "$XDG_DATA_HOME/cargo";
    PYTHONSTARTUP = "$XDG_CONFIG_HOME/python/pythonrc.py";
    JULIA_DEPOT_PATH = "$XDG_DATA_HOME/julia";
    JUPYTER_CONFIG_DIR = "$XDG_CONFIG_HOME/jupyter";
    IPYTHONDIR = "$XDG_CONFIG_HOME/ipython";
    # display settings
    MOZ_ENABLE_WAYLAND = "0";
    GDK_DPI_SCALE =
      if config.networking.hostName == "xanth"
      then "1.3"
      else "1";
  };

  # packages
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = "nix-command flakes";
  environment.systemPackages =
    (import ./packages.nix pkgs)
    ++ (import ../programs/programs.nix pkgs);
  programs.sway.enable = true;
  programs.steam.enable = config.networking.hostName == "libra";
  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };
  security.pam.services.swaylock.text = "auth include login";
  networking.networkmanager.enable = true;
  services.ntp.enable = true;
  fonts.packages = with pkgs; [source-code-pro fira libre-baskerville];
  nix.optimise.automatic = true;

  # user
  users.users.will = {
    isNormalUser = true;
    description = "Will Underwood";
    extraGroups = ["networkmanager" "wheel" "audio" "video"];
  };
}
