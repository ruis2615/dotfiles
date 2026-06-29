{ config, pkgs, ... }:

{
  home.username = "ruis2615";  # 変更しない
  home.homeDirectory = "/Users/ruis2615";  # 変更しない
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
}
