{ lib, device, hostname, ... }:

{
  # https://nix-community.github.io/home-manager/options/nix-darwin/index.html
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.extraSpecialArgs = {
    inherit device hostname;
  };
  home-manager.users.${device.username} = {
    imports = [
      ../home-manager/home.nix
    ]
    ++ lib.optional (builtins.pathExists (../home-manager/devices + "/${hostname}.nix"))
      (../home-manager/devices + "/${hostname}.nix");
  };
}
