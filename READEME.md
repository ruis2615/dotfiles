# `Nix` 及び `home-manager` のインストール

1. Nixをインストールする

```bash
curl -fsSL https://install.determinate.systems/nix | sh -s -- install

# 途中、以下のように訊かれるので「y」
Proceed? ([Y]es/[n]o/[e]xplain): y
```

2. このリポジトリをクローン後、当該リポジトリのディレクトリ内で以下のコマンドを実行

```bash
nix run home-manager -- switch --flake .
```

# home-manager 関連

## 設定の反映

```bash
home-manager switch --flake .
```

## home-manager自体の更新

`flake.nix` があるディレクトリで実行：

```bash
$ nix flake update home-manager
$ home-manager switch --flake .
```

その後、[リリースノート](https://nix-community.github.io/home-manager/release-notes.xhtml)を確認し、`home.stateVersion`を更新する旨が記載されていた場合は、`home.nix`にて指定された値に更新すること

# nix-darwin関連

# バージョンの確認

```bash
darwin-version
```

# nix-darwin自体の更新

```bash
$ nix flake update nix-darwin
$ sudo darwin-rebuild switch --flake .
```

# 設定の反映

```bash
sudo darwin-rebuild switch --flake .
```

# 世代の確認・ロールバック

```bash
sudo darwin-rebuild --list-generations | tail -n 5
```

```bash
# 1つ前
sudo darwin-rebuild --rollback

# 特定の世代を指定
sudo darwin-rebuild --switch-generation <generation>
```

# パッケージ関連

## パッケージの更新

```bash
nix flake update nixpkgs
```
