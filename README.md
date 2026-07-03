# `Nix` 及び `home-manager` のインストール

1. Nixをインストールする

```bash
curl -fsSL https://install.determinate.systems/nix | sh -s -- install

# 途中、以下のように訊かれるので「y」
Proceed? ([Y]es/[n]o/[e]xplain): y
```

2. このリポジトリをクローン後、当該リポジトリのディレクトリ内で以下のコマンドを実行

```bash
sudo nix run nix-darwin/master#darwin-rebuild -- switch --flake .
```

# 複数デバイス対応

このリポジトリは複数の Mac を1つの flake で管理する。デバイスごとの設定は [`lib/devices.nix`](lib/devices.nix) のレジストリで一元管理し、共通設定（[`nix-darwin/common.nix`](nix-darwin/common.nix)・[`home-manager/home.nix`](home-manager/home.nix)）にデバイス別モジュールを重ねる構成になっている。

## ホスト名の自動選択

`darwin-rebuild switch --flake .` は `#` 以降を省略すると現在のホスト名で `darwinConfigurations.<hostname>` を自動選択する。そのため、レジストリのキーは各 Mac の `LocalHostName` に一致させておくこと。

```bash
# 現在のホスト名を確認
scutil --get LocalHostName

# 現在のホスト名の設定を自動選択して適用
sudo darwin-rebuild switch --flake .
```

## 新しいデバイスの追加手順

1. 対象 Mac で `scutil --get LocalHostName` を実行してホスト名を確認する
2. [`lib/devices.nix`](lib/devices.nix) にエントリを追加する（`system`・`username`・`homeDirectory` を指定。Apple Silicon は `aarch64-darwin`、Intel は `x86_64-darwin`）
3. 必要に応じて `nix-darwin/devices/<hostname>.nix`（システム固有設定）と `home-manager/devices/<hostname>.nix`（HM 固有設定）を作成する。デバイス固有設定が無い場合でも、これらのファイルは省略できる
4. 対象 Mac で `sudo darwin-rebuild switch --flake .` を実行する

# Homebrew 関連

Homebrew 本体は [`nix-homebrew`](https://github.com/zhaofengli/nix-homebrew) で宣言的に管理され、初回の `sudo darwin-rebuild switch --flake .` 実行時に自動でインストールされる（手動での Homebrew インストールは不要）。tap は `flake.nix` で固定管理され（`mutableTaps = false`）、`brew tap` による手動追加はできない。

インストールするアプリは nix-darwin の `homebrew` モジュールで管理し、`darwin-rebuild switch` のたびに Brewfile と実体が同期される。手動での `brew install` は使わず、以下のファイルに追記して反映する。

- 全デバイス共通のアプリ: [`nix-darwin/homebrew.nix`](nix-darwin/homebrew.nix)
- デバイス別のアプリ: `nix-darwin/devices/<hostname>.nix`（`homebrew.casks` / `homebrew.brews` に追記。共通リストにマージされる）

アプリの種別:

- `brews`: CLI ツール（formulae）
- `casks`: GUI アプリケーション
- `masApps`: Mac App Store アプリ（利用時は事前に App Store へサインインが必要。`"アプリ名" = App ID;` の形式で指定）

## 反映

```bash
sudo darwin-rebuild switch --flake .
```

## 注意点

- [`nix-darwin/homebrew.nix`](nix-darwin/homebrew.nix) の `onActivation.cleanup` は既定で `"none"`。`"zap"` にすると Brewfile に記載の無いアプリが削除される（完全宣言的運用になるが、手動導入アプリも消える点に注意）。
- tap 一覧の更新は `nix flake update homebrew-core homebrew-cask homebrew-bundle` で行う。

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

現在のホスト名の設定が自動選択される。

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
