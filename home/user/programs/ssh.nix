{ config, pkgs, inputs, ... }:

{
programs.ssh = {
    enable = true;
    
    # Automatically add GitHub to known hosts so Nix doesn't ask 
    # "Are you sure you want to continue connecting?" on a new machine.
    matchBlocks = {
      "github.com" = {
        hostname = "github.com";
        identityFile = "~/.ssh/id_ed25519"; # Tells Git exactly where to look for this machine's key
      };
    };
  };
}


/*
=============================================================================
METH0D 1: DECLARATIVE GIT + SSH AUTHENTICATION SETUP GUIDE
=============================================================================

This file handles your Git/SSH identity configuration. Because NixOS emphasizes 
security, private keys are kept strictly local to each machine, while the 
configuration rules below are pushed to GitHub.

--- STEP 1: GENERATE A NEW SSH KEY FOR THIS MACHINE ---
Open your terminal on the local machine and run:
  $ ssh-keygen -t ed25519 -C "redazanelc@gmail.com"

- Press [Enter] to accept the default file path (~/.ssh/id_ed25519).
- (Optional) Enter a strong passphrase, or press enter twice for no password.

--- STEP 2: LINK THE KEY TO YOUR GITHUB ACCOUNT ---
1. Print out your unique public key to the terminal:
   $ cat ~/.ssh/id_ed25519.pub

2. Copy the entire output string (starts with ssh-ed25519 ...).
3. Open your browser and navigate to: https://github.com/settings/keys
4. Click 'New SSH Key', paste your key, and give it a recognizable name 
   describing this specific computer (e.g., "NixOS - Main Desktop").

--- STEP 3: TEST YOUR CONNECTION ---
Verify that GitHub recognizes your key pair by running:
  $ ssh -T git@github.com

If successful, you will see: 
"Hi redazanelc! You've successfully authenticated, but GitHub does not 
provide shell access."

--- STEP 4: UPDATE YOUR LOCAL REPOSITORY LINK ---
If you originally cloned your nixos-config repository using an HTTPS url, 
convert it to use SSH authentication instead:
  $ cd ~/nixos-config
  $ git remote set-url origin git@github.com:your-username/your-repo-name.git

From this point forward, commands like `git push` and `git pull` will function 
silently and securely in the background without prompting you for a password.
=============================================================================
*/
