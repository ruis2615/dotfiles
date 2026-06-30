{
  description = "Home Manager configuration of ruis2615";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
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
      };
      laptopMac = {
        hostPlatform = "aarch64-darwin";
        hostName = "m1-macbook-pro";
      };
    };
    in
    {
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
