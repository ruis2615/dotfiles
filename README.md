# Nix

## 初期セットアップ

1. Nix本体をインストール

```zsh
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install

# 途中、継続していいか訊かれるので、「y」
```

2. インストールできたか確認

```zsh
nix --version
```

3. Gitをクローン

4. 既存環境へ切り替え

```zsh
sudo nix run nix-darwin/master#darwin-rebuild -- switch --flake .
```

## 新しいNix環境を作成する

```zsh
nix run home-manager/master -- init .
```

## Home Managerの導入

```zsh
nix run home-manager -- switch --flake .
```

## Home Managerの設定を反映

```zsh

```

## nix-darwinの導入

1. `configuration.nix`を`./nix-darwin`内に作成
2. 以下の内容を`configuration.nix`に追加

```nix
{
  ...
}:
{
  nixpkgs.hostPlatform = "aarch64-darwin";
  system.stateVersion = 7;
  nix.enable = false;
}
```

```zsh
#
nix flake init -t nix-darwin/master
```
