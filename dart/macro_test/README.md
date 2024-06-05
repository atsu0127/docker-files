# macro_test

dart の macro を試しました

## 参考

- https://dart.dev/language/macros
  - 公式、もうちょっとちゃんと説明してくれ(experimental だから仕方ないかな)
- https://zenn.dev/koichi_51/articles/8d9db8dfed4441
  - 日本語の雰囲気掴みやすい記事
- https://github.com/dart-lang/sdk/blob/master/pkg/json/lib/json.dart
  - 実際に使っているの読むのが手っ取り早い

## 実装について

とりあえず任意のクラスに関数を追加するマクロ実装してみた感じ、以下のイメージ

1. external で関数シグネチャ作成
   - `ClassDeclarationsMacro`の実装で実施
   - `String`とかを使いたい場合、以下の対応が必要
     - `Uri.parse('dart:core');`などで path 持ってくる
     - `MemberDeclarationBuilder.resolveIdentifier(<path>, 'String');`で`identifier`持ってきてこれ使う
2. 関数の実際の処理実装
   - `ClassDefinitionMacro`の実装で実施
   - `ClassDeclaration`からメソッド一覧持ってきて、それを引数とした`buildMethod`を作成
   - ↑ で作成した builder に実際のメソッドの中身を記載

という感じで interface(`ClassDeclarationsMacro`など)と builder(`TypeDefinitionBuilder`など)を作成したいもの(constructor, method, field...)に合わせて組み合わせて実装する感じ

- 詳細な説明が出るまでは`https://github.com/dart-lang/sdk/blob/main/pkg/_macros/lib/src/api`を眺めて実装する感じになりそう
  - `〇〇Macro`は[pkg/\_macros/lib/src/api/macros.dart](https://github.com/dart-lang/sdk/blob/main/pkg/_macros/lib/src/api/macros.dart)に記載がある
  - `〇〇builder`は[pkg/\_macros/lib/src/api/builders.dart](https://github.com/dart-lang/sdk/blob/main/pkg/_macros/lib/src/api/builders.dart)に記載がある

## 実行方法

[README](../README.md)参照
