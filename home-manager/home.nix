{ config, pkgs, device, ... }:

{
  home.username = device.username;
  home.homeDirectory = device.homeDirectory;
  home.stateVersion = "26.05";  # 変更しない

  home.packages = with pkgs; [
    git
  ];

  home.file = {
    ".gitconfig".source = ./git/.gitconfig;
  };

  home.sessionVariables = {

  };

  programs.home-manager.enable = true;

  # Finder上でサイドプレビューを有効化(なぜかnix-darwin側で有効化できない)
  targets.darwin.defaults = {
    "com.apple.finder" = {
      ShowPreviewPane = true;
    };
  };
}
