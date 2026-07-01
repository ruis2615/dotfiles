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
    # homebrew
    nix-homebrew.url = "github:zhaofengli/nix-homebrew";
    homebrew-core = {
      url = "github:homebrew/homebrew-core";
      flake = false;
    };
    homebrew-cask = {
      url = "github:homebrew/homebrew-cask";
      flake = false;
    };
    homebrew-bundle = {
      url = "github:homebrew/homebrew-bundle";
      flake = false;
    };
  };

  outputs =
    { self, nixpkgs, home-manager, nix-darwin, nix-homebrew, homebrew-core, homebrew-cask, homebrew-bundle, ... }@inputs:
    let
      inherit (nixpkgs) lib;

      # デバイス一覧
      devices = import ./lib/devices.nix;

      # 1デバイス分の darwinConfiguration を生成する
      mkDarwin =
        hostname: device:
        nix-darwin.lib.darwinSystem {
          specialArgs = {
            inherit self hostname device;
          };
          modules = [
            ./nix-darwin/common.nix
            home-manager.darwinModules.home-manager
            ./nix-darwin/home-manager.nix
            nix-homebrew.darwinModules.nix-homebrew
            {
              nix-homebrew = {
                enable = true;
                user = device.username;
                # Apple Silicon のみ Rosetta 用 Intel prefix も導入
                enableRosetta = device.system == "aarch64-darwin";
                taps = {
                  "homebrew/homebrew-core" = homebrew-core;
                  "homebrew/homebrew-cask" = homebrew-cask;
                  "homebrew/homebrew-bundle" = homebrew-bundle;
                };
                mutableTaps = false;
              };
            }
            ({ config, ... }: {
              homebrew.taps = builtins.attrNames config.nix-homebrew.taps;
            })
            ./nix-darwin/homebrew.nix
          ]
          ++ lib.optional (builtins.pathExists (./nix-darwin/devices + "/${hostname}.nix"))
            (./nix-darwin/devices + "/${hostname}.nix");
        };

      # devShell 用のシステム（デバイスに含まれるアーキテクチャ分だけ用意）
      systems = lib.unique (lib.mapAttrsToList (_: device: device.system) devices);
      forAllSystems = lib.genAttrs systems;
    in {
      darwinConfigurations = lib.mapAttrs mkDarwin devices;

      devShells = forAllSystems (
        system:
        let
          pkgs = import nixpkgs { inherit system; };
        in {
          default = pkgs.mkShell {
            buildInputs = [
              pkgs.python312
              pkgs.uv
            ];
            shellHook = ''
              echo "uv version: $(uv --version)"
              echo "python version: $(python --version)"
            '';
          };
        }
      );
    };
}
