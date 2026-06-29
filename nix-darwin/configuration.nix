{ ... }:

{
  # Intel系Macの場合は、x86_64-darwin、Apple Siliconの場合は、aarch64-darwinにする
  nixpkgs.hostPlatform = "aarch64-darwin";
  system.stateVersion = 6;
  nix.enable = false;
}