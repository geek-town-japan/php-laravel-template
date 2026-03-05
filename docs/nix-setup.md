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
