# dart

検証などで使いたい dart の project を置いておく場所。

## 使い方

### 事前準備

以下必要です

- docker
- vscode

### 環境作成

```bash
## dart createで作成
## ref: https://dart.dev/tools/dart-create
dart create -t <type> <project_name>

## devcontainerの設定をコピー
cp -r template/.devcontainer <project_name>
cp -r template/.github <project_name>
cp -r template/.vscode <project_name>

## devcontainer.jsonの編集
### dartのバージョンとかextensionのバージョンを必要なものに変更
### ref: https://containers.dev/implementors/json_reference/

## launch.jsonの編集
### dartコマンドの実行時引数とか変えたかったら変える
### ref: https://code.visualstudio.com/docs/editor/debugging#_launchjson-attributes
```

### 実行

vscode で`<project_name>`のフォルダ開いて以下で devcontainer に接続する

1. コマンドパレット開く(Cmd+Shift+P)
2. `Reopen In Container`を実行

接続できたらサイドバーの`実行とデバッグ`から`dart run`を選択して実行できます。

コマンドラインから実行したい場合は devcontainer に接続した状態で`ターミナル`から

```bash
dart run
```

を実行すれば OK

## 注意点

### experimental な機能の format について

experimental な機能を使っているファイルをフォーマットするには、以下の実行が必要

```bash
dart format --enable-experiment macros .
```
