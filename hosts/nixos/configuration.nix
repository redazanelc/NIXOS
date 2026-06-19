{ config, pkgs, ... }:

{
  imports = [ 
    ./hardware-configuration.nix
  ];

  # --- Boot & Bootloader ---
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;

  boot.consoleLogLevel = 0;
  boot.initrd.verbose = false;
  boot.kernelParams = [
    "quiet"
    "splash"
    "boot.shell_on_fail"
    "loglevel=3"
    "rd.systemd.show_status=false"
    "rd.udev.log_level=3"
    "udev.log_priority=3"    
  ];

  boot.plymouth = {
    enable = true;
    themePackages = with pkgs; [ adi1090x-plymouth-themes ];
    theme = "hexagon_dots_alt";
  };

  # --- Hardware & Graphics ---
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    open = true;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
    prime = {
      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:1:0:0";
    };
  };
  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.bluetooth.enable = true;

  # --- Networking & Time ---
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;
  time.timeZone = "America/Matamoros";
  i18n.defaultLocale = "en_US.UTF-8";
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # --- Users ---
  users.users."user" = {
    isNormalUser = true;
    description = "USER";
    extraGroups = [ "networkmanager" "wheel" ];
    # Leave packages empty here; Home Manager handles it now.
    packages = []; 
  };

  # --- System Packages & Features ---
  nix.settings.experimental-features = [ "nix-command" "flakes" ]; # Essential for Flakes
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    lshw
    xwayland-satellite
  ];

  # --- Programs & Services ---
  programs.niri.enable = true;

  programs.kdeconnect.enable = true;

  services.upower.enable = true;
  services.power-profiles-daemon.enable = true;

  services.greetd = {
    enable = true;
    settings = {
    default_session = {
       command = "${pkgs.tuigreet}/bin/tuigreet --time --cmd niri-session --theme 'border=#222222;text=#cccccc;prompt=#FFD421;time=#FFD421;action=#FFD421;button=#FFD421;container=#111111;input=#f5f5f5'";
        user = "user";
      };
    };
  };

  systemd.user.services.niri.enableDefaultPath = false;
  systemd.services.greetd.serviceConfig = {
    Type = "idle";
    StandardInput = "tty";
    StandardOutput = "tty";
    StandardError = "journal";
    TTYReset = true;
    TTYHangup = true;
    TTYVTDisallocate = true;
  };

  system.stateVersion = "26.05";
}
