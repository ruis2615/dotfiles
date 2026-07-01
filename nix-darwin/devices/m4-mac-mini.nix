{ hostname, ... }:

{
  # このデバイス固有のシステム設定をここに記述する
  networking.hostName = hostname;

  # このデバイス固有の Homebrew アプリ（共通リストにマージされる）
  homebrew.casks = [
    # 例: "raycast"
  ];
  homebrew.brews = [
  ];
}
