{ self, ... }:

{
  # Intel系Macの場合は、x86_64-darwin、Apple Siliconの場合は、aarch64-darwinにする
  nixpkgs.hostPlatform = "aarch64-darwin";
  # https://nix-darwin.github.io/nix-darwin/manual/index.html#opt-system.stateVersion
  system.stateVersion = 7;
  nix.enable = false;

  system.primaryUser = "ruis2615";

  # unfree を全て許可する
  # パッケージ指定で制御しているので、コメントアウト(無条件で許可する場合はこっち)
  # nixpkgs.config.allowUnfree = true;

  # パッケージを指定して許可する場合(一旦コメントアウト)
  # nixpkgs.config.allowUnfreePredicate =
  #   pkg:
  #   builtins.elem (pkgs.lib.getName pkg) [
  #   ];

  # ホームディレクトリを指定
  users.users."ruis2615".home = "/Users/ruis2615";

  imports = [
    ./home-manager.nix
  ];

  # 利用するシェルをzshに設定
  programs.zsh.enable = true;

  # macOSの設定
  system.defaults = {
    # Finder
    finder = {
      FXPreferredViewStyle = "Nlsv"; # デフォルトの表示方法をリストビューに設定
      FXDefaultSearchScope = "SCcf"; # 検索範囲をカレントフォルダに設定
      AppleShowAllExtensions = true; # 拡張子を表示
      AppleShowAllFiles = false; # 隠しファイルの非表示
      CreateDesktop = false; # デスクトップアイコンの非表示
      FXEnableExtensionChangeWarning = false; # 拡張子変更時の確認ダイアログを無効化
      ShowPathbar = true; # パスバーを表示
      ShowStatusBar = true; # ステータスバーを表示
      ShowExternalHardDrivesOnDesktop = false;
      ShowHardDrivesOnDesktop = false;
      ShowMountedServersOnDesktop = false;
      ShowRemovableMediaOnDesktop = false;
    };
    # Dock
    dock = {
      autohide = true; # Dockの自動的に隠す
      show-process-indicators = true; # 起動中アプリをインジケーターに表示
      show-recents = false; # 最近使ったアプリを非表示
      tilesize = 50; # アイコンサイズ
      magnification = false; # アイコンホバー時に拡大表示しない
      orientation = "bottom"; # Dockの位置(bottom/left/right)
      mineffect = "scale"; # ウィンドウ最小化のアニメーション
      launchanim = false; # 起動時のアニメーションを無効化
    };
    # 画面キャプチャ
    screencapture = {
      target = "clipboard"; # スクリーンショットの保存先をクリップボードに設定
      disable-shadow = true; # スクリーンショットの影を無効化
    };

    # nix-darwinで用意されていない設定等
    CustomUserPreferences.NSGlobalDomain = {
    };
  };
}