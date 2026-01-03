{
  description = "My NixOS + Home Manager flake";

  inputs = {
    #nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      #url = "github:nix-community/home-manager/release-25.05";
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs: {

    nixosModules = builtins.listToAttrs (
      map (modulePath: {
        name = builtins.replaceStrings [ ".nix" ] [ "" ] (builtins.baseNameOf modulePath);
        value = modulePath;
      }) (import ./modules/modules-list.nix).imports
    );

    nixosConfigurations = {
      desktop = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/desktop/configuration.nix
          ./hosts/desktop/hardware-configuration.nix
          self.nixosModules.common
          self.nixosModules.devtools
          self.nixosModules.gaming
          self.nixosModules.virtual
          self.nixosModules.plasma

           home-manager.nixosModules.home-manager
           {
             home-manager.useGlobalPkgs = true;
             home-manager.useUserPackages = true;
             home-manager.users.blaz = import ./home/home.nix;
           }
          
        ];
      };

      laptop = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/laptop/configuration.nix
          ./hosts/laptop/hardware-configuration.nix
          self.nixosModules.common
          self.nixosModules.devtools

          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.blaz = import ./home/home.nix;
          }
        
        ];
      };

      server = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/server/configuration.nix
          ./hosts/server/hardware-configuration.nix
        ];
      };


    };
  };
}
