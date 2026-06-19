{ config, pkgs, ... }:
{
programs.alacritty = {
      enable = true;
      settings = {
        colors = {
          primary = {
            background = "#111111"; # Main terminal background
            foreground = "#f5f5f5"; # Standard terminal text
          };
          
          cursor = {
            text   = "#111111"; # The character sitting underneath the cursor block
            cursor = "#FFD421"; # The cursor block itself
          };
          
          selection = {
            text       = "#ffffff"; # Text color when highlighted/selected
            background = "#333333"; # Highlight background color
          };
  
          normal = {
            black   = "#111111"; # Invisible/hidden text (matches background)
            red     = "#ff5555"; # Standard errors, git deletions, failed tests
            green   = "#FFD421"; # Shell prompt (user@nixos), git additions, success messages
            yellow  = "#FFD421"; # Warnings, specific syntax highlights
            blue    = "#888888"; # Directory names in ls, links
            magenta = "#ff5555"; # Git merge conflicts, specific syntax highlights
            cyan    = "#cccccc"; # Symlinks in ls, specific syntax highlights
            white   = "#f5f5f5"; # Standard explicit white text
          };
  
          bright = {
            black   = "#222222"; # Dark grey text, often used for comments or subtle info
            red     = "#ff5555"; # Bold/highlighted errors
            green   = "#FFD421"; # Bold/highlighted shell prompt (user@nixos)
            yellow  = "#FFD421"; # Bold/highlighted warnings
            blue    = "#888888"; # Bold/highlighted directory names
            magenta = "#ff5555"; # Bold/highlighted magenta
            cyan    = "#cccccc"; # Bold/highlighted symlinks
            white   = "#ffffff"; # Bold/highlighted explicit white text
          };
        };
      };
    };


}
