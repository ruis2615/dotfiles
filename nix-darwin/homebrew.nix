{ ... }:

{
  homebrew = {
    enable = true;

    # darwin-rebuild switch のたびに Brewfile と実体を同期
    onActivation = {
      autoUpdate = true; # brew 自体の自動更新を有効化
      upgrade = true; # 記載パッケージは最新にする
      cleanup = "none"; # 未記載アプリの扱い。
    };

    # 全デバイス共通の CLI（formulae）
    brews = [
      # 例: "wget"
    ];

    # 全デバイス共通の GUI アプリ（casks）
    casks = [
      # 例: "google-chrome"
      "finetune"
      "claude"
      "zen"
      "slack"
      "1password"
      "cursor"
    ];

    # 全デバイス共通の App Store アプリ（要 mas / Apple ID ログイン）
    masApps = {
      # 例: "LINE" = 539883307;
    };
  };
}
