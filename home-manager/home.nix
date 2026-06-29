{ config, pkgs, ... }:

{
  home.username = "ruis2615";  # 変更しない
  home.homeDirectory = "/Users/ruis2615";  # 変更しない
  home.stateVersion = "26.05";  # 変更しない

  home.packages = [
  ];

  home.file = {
  };

  # Gitの設定
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "ruis2615";
        email = "ruis@ruis.app";
      };
    };
  };

  home.sessionVariables = {

  };

  programs.home-manager.enable = true;
}
