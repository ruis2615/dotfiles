{
  ...
}:
{
  nixpkgs.hostPlatform = "aarch64-darwin";
  # https://nix-darwin.github.io/nix-darwin/manual/index.html#opt-system.stateVersion
  system.stateVersion = 7;
  nix.enable = false;

  users.users."ruis2615".home = "/Users/ruis2615";

  imports = [
    ./home-manager.nix
  ];
}