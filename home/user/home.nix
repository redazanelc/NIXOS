# Notice we added `inputs` to the arguments here
{ config, pkgs, inputs, ... }:

{
  home.username = "user";
  home.homeDirectory = "/home/user";

  # Import the Noctalia Home Manager module from your flake inputs
  imports = [
    inputs.noctalia.homeModules.default
    ./programs/alacritty.nix
    ./programs/noctalia.nix
    ./programs/niri.nix
    ./programs/git.nix
    ./programs/ssh.nix
  ];

  home.packages = with pkgs; [
  
    # Wayland Tools
    wl-clipboard
    alacritty
    fuzzel
    grim
    slurp
    
    # Browsers & Editors
    firefox
    micro

    # Media viewers
    imv
    mpv

    # PW Management
    keepassxc

    # System Monitor
    btop

    # Core Linux Utilities
    git
    curl
    wget
    unzip
    zip

    # Modern CLI Tools
    eza
    bat
    ripgrep
    fzf
    
    # File Manager (Pick one or both)
    thunar

    # Linux Utilities
    util-linux
    efibootmgr

    # System Stats
    inxi

    # Code
    antigravity
    
    
    
  ];

  programs.home-manager.enable = true;


  # --- System-Wide Dark Theme ---
  
  # 1. Configure GTK (used by most Linux applications)
  gtk = {
    enable = true;
    theme = {
      name = "Adwaita-dark";
      package = pkgs.gnome-themes-extra;
    };
  };
  
  # 2. Tell modern GNOME/Wayland apps to use dark mode via dconf
  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
  };
  
  # 3. Tell Qt apps (like VLC, OBS) to match your GTK theme
  qt = {
    enable = true;
    platformTheme.name = "gtk";
  };



  home.stateVersion = "26.05";
}
