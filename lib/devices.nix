# デバイスレジストリ
# キーは `scutil --get LocalHostName` の値に一致させること。
# `darwin-rebuild switch --flake .` は現在のホスト名で対応する設定を自動選択する。
#
# 新デバイス追加手順:
#   1. `scutil --get LocalHostName` でホスト名を確認
#   2. このファイルにエントリを追加
#   3. nix-darwin/devices/<hostname>.nix と home-manager/devices/<hostname>.nix を作成（空の `{}` でも可）
#   4. 対象 Mac で `sudo darwin-rebuild switch --flake .`
{
  m4-mac-mini = {
    system = "aarch64-darwin";
    username = "ruis2615";
    homeDirectory = "/Users/ruis2615";
  };
  m1-macbook-pro = {
    system = "aarch64-darwin";
    username = "ruis2615";
    homeDirectory = "/Users/ruis2615";
  };
  mac-env = {
    system = "aarch64-darwin";
    username = "ruis2615";
    homeDirectory = "/Users/ruis2615";
  };
}
