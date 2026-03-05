# Nix 開発環境セットアップ

## Nix のインストール

> 参照: https://nixos.org/download/

### Linux

マルチユーザーインストール(推奨)
```sh
sh <(curl --proto '=https' --tlsv1.2 -L https://nixos.org/nix/install) --daemon
```

シングルユーザーインストール
```sh
sh <(curl --proto '=https' --tlsv1.2 -L https://nixos.org/nix/install) --no-daemon
```

---

### Mac

```sh
sh <(curl --proto '=https' --tlsv1.2 -L https://nixos.org/nix/install)
```

インストール完了後、一度ターミナルを再起動します。

```sh
nix --version # 動作確認
```

---

### Windows (WSL2)

> Windows は Nix を直接サポートしていないため、WSL2 (Windows Subsystem for Linux) 経由で使用します

マルチユーザーインストール(systemd が有効になっている WSL が必要)
```sh
sh <(curl --proto '=https' --tlsv1.2 -L https://nixos.org/nix/install) --daemon
```

シングルユーザーインストール
```sh
sh <(curl --proto '=https' --tlsv1.2 -L https://nixos.org/nix/install) --no-daemon
```

## nix develop

`path:` を指定すると Git の追跡状態に関係なく実行ができる
```sh
nix develop path:.
```

## direnv

direnv を使うと、ディレクトリに入るだけで自動的に `nix develop` の環境が現在のシェルに読み込まれます。
`nix develop` とは異なり新しいシェルを起動しないため、zsh 等のシェル設定もそのまま維持されます。

---

### direnv のインストール

#### Linux / Windows (WSL2)

```sh
curl -sfL https://direnv.net/install.sh | bash
```

#### Mac

```sh
brew install direnv
```

---

### シェルへのフック設定(各自1回だけ実施)

使用しているシェルの設定ファイルに以下を追記し、シェルを再起動します。

**zsh**

```sh
echo 'eval "$(direnv hook zsh)"' >> ~/.zshrc
exec zsh
```

**bash**

```sh
echo 'eval "$(direnv hook bash)"' >> ~/.bashrc
exec bash
```

---

### プロジェクトへの適用

`.envrc` はリポジトリにコミット済みのため、以下のコマンドで有効化するだけで完了です。

```sh
direnv allow
```

以降はディレクトリに入るだけで自動的に環境が読み込まれます。
