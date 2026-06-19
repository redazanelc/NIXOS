{ config, pkgs, inputs, ... }:

{
  programs.git = {
    enable = true;
    
    # 5. Enable Git Large File Storage (LFS) globally if needed
    # Note: lfs.enable remains a top-level module option, not part of settings.
    lfs.enable = true;

    # 3. Global Gitignore rules (Uncommented just in case you want them, 
    # but still a top-level array option in Home Manager)
    # ignores = [ 
    #   "*~" 
    #   "*.swp" 
    #   ".DS_Store" 
    # ];

    # The new unified settings block replacing extraConfig, userName, userEmail, and aliases
    settings = {
      # 1. Global User Identity
      user = {
        name = "Zane Reda";
        email = "redazanelc@gmail.com";
      };

      # 2. Global Aliases
      alias = {
        st = "status";
        co = "checkout";
        cm = "commit";
        rb = "rebuild";
      };

      # 4. Advanced/Global INI Settings
      init = {
        defaultBranch = "main";
      };
      
      push = {
        autoSetupRemote = true;
      };

      safe = {
        directory = [
          "/home/user/nixos-config"
        ];
      };

      core = {
        editor = "micro"; 
      };
    };
  };
}
