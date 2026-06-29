{
  # https://nix-community.github.io/home-manager/options/nix-darwin/index.html
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.users."ruis2615" = ../home-manager/home.nix;
}