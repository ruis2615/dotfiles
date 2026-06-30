{
  description = "Home Manager configuration of ruis2615";

  inputs = {

    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-darwin = {
       url = "github:nix-darwin/nix-darwin";
       inputs.nixpkgs.follows = "nixpkgs";
     };
  };

  outputs =
    { self, nixpkgs, home-manager, nix-darwin, ... }:

    let my_devices = {
      desktopMac = {
        hostPlatform = "aarch64-darwin";
        hostName = "m4-mac-mini";
        user = "ruis2615";
      };
      laptopMac = {
        hostPlatform = "aarch64-darwin";
        hostName = "m1-macbook-pro";
        user = "ruis2615";
      };
    };
    in
    {
      homeConfigurations.ruis2615 = home-manager.lib.homeManagerConfiguration {
        modules = [
          ./home-manager/home.nix
        ];
      };

      darwinConfigurations = {
        "${my_devices.desktopMac.hostName}" = nix-darwin.lib.darwinSystem {
          specialArgs = {
            inherit self;
          };
          modules = [
            ./nix-darwin/configuration.nix
            home-manager.darwinModules.home-manager
          ];
        };
        "${my_devices.laptopMac.hostName}" = nix-darwin.lib.darwinSystem {
          specialArgs = {
            inherit self;
          };
          modules = [
            ./nix-darwin/configuration.nix
            home-manager.darwinModules.home-manager
          ];
        };
      };
    };

    # {
    #   darwinConfigurations."m4-mac-mini" = nix-darwin.lib.darwinSystem {
    #     specialArgs = {
    #       inherit self;
    #     };
    #     modules = [ 
    #       ./nix-darwin/configuration.nix
    #       home-manager.darwinModules.home-manager
    #       ];
    #   };
    # };
}
