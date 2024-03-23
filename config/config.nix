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
    nssmdns = true;
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
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };

  # environment variables
  environment.sessionVariables = {
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
  programs.steam.enable = true;
  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };
  security.pam.services.swaylock.text = "auth include login";
  networking.networkmanager.enable = true;
  fonts.packages = with pkgs; [source-code-pro fira libre-baskerville];
  nix.optimise.automatic = true;

  # user
  time.timeZone = "America/New_York";
  users.users.will = {
    isNormalUser = true;
    description = "Will Underwood";
    extraGroups = ["networkmanager" "wheel" "audio" "video"];
  };
}
