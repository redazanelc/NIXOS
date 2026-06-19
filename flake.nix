{
  description = "NIX OS CONFIG";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable"; # Or "nixos-unstable"
    
    home-manager = {
      url = "github:nix-community/home-manager";
      # Ensure Home Manager uses the exact same nixpkgs as the system
      inputs.nixpkgs.follows = "nixpkgs";
    };

    noctalia = {
          url = "github:noctalia-dev/noctalia-shell";
          inputs.nixpkgs.follows = "nixpkgs";
    };

    
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs: {

    nixosConfigurations.awesomebox = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs; };
          modules = [
            # ... other modules
            ./noctalia.nix
          ];
        };

  
    nixosConfigurations = {
      # "nixos" is your hostname
      nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        # Pass inputs to modules if you need them later
        specialArgs = { inherit inputs; };
        
        modules = [
          ./hosts/nixos/configuration.nix

          # Add Home Manager as a module
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
			home-manager.extraSpecialArgs = { inherit inputs; };
			home-manager.backupFileExtension = "backup";
            # Link to your user's home.nix
            home-manager.users.user = import ./home/user/home.nix;
          }
        ];
      };
    };
  };
}
