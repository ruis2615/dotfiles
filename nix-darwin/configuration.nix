{ ... }:

{
  # Intel系Macの場合は、x86_64-darwin、Apple Siliconの場合は、aarch64-darwinにする
  nixpkgs.hostPlatform = "aarch64-darwin";
  # https://nix-darwin.github.io/nix-darwin/manual/index.html#opt-system.stateVersion
  system.stateVersion = 7;
  nix.enable = false;
}