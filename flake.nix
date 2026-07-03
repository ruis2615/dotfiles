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
    { nixpkgs, home-manager, nix-darwin, ... }:
    # let
    #   system = "aarch64-darwin";
    #   pkgs = nixpkgs.legacyPackages.${system};
    # in
    # {
    #   homeConfigurations."ruis2615" = home-manager.lib.homeManagerConfiguration {
    #     inherit pkgs;
    #     modules = [ ./home-manager/home.nix ];
    #   };
    # };

    darwinConfigurations."m4-mac-mini" = nix-darwin.lib.darwinSystem {
      specialArgs = {
          inherit self;
        };
      modules = [
        ./nix-darwin/configuration.nix
        home-manager.darwinModules.home-manager
        ];
      };
}
