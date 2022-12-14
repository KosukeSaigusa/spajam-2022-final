# spajam2022final

Flutter Lovers チームが参加する SPAJAM 2022 本戦のリポジトリです。

## Flutter

SDK バージョン

```plain
Dart SDK: >=2.18.2 <3.0.0
Flutter SDK: 3.3.8
```

VSCode を使用している場合は、`.vscode/settings.base.json` を参考にしてください。

## Dart Define

VSCode を使用している場合は `.vscode/launch.base.json` を参考にしてください。

|  内容  |  設定  |
| ---- | ---- |
|  --dart-define=FLAVOR=local  |  Firebase Local Emulator に接続したい場合  |
|  --dart-define=GITHUB_TOKEN={your-github-token}  |  あなたの GitHub トークン  |

## Firebase Local Emulator

`firebase/functions` ディレクトリで必要な依存関係をインストールしてください。

```shell
npm ci
```

VSCode に functions ディレクトリの場所を正しく認識させるために、`.vscode/settings.json` に下記を追加してください。

`.vscode/settings.base.json` にも記載しています。

```json:.vscode/settings.json
{
  "eslint.workingDirectories": ["./firebase/functions"]
}
```

Firebase CLI の最新バージョンをマシンのグローバルにインストールしてください。

```shell
npm install -g firebase-tools
```

プロジェクトルートで次のコマンドを実行してください。

```shell
npm --prefix functions run build && firebase emulators:start --inspect-functions --import data --export-on-exit
```

VSCode でブレイクポイントを打ちながらデバッグできるようにするために、`.vscode/launch.json` に次の設定を追加して、実行してください。

```json:.vscode/launch.json
{
  "version": "0.2.0",
  "configurations": [
    {
      "name": "Debug Functions (local)",
      "type": "node",
      "request": "attach",
      "restart": true,
      "port": 9229
    }
  ]
}
```

成功すると、上記で `firebase emulators:start` したコンソールに "Debugger attached." という出力が現れ、VSCode に下記のような表示が現れます。

![vscode_debug_functions](docs/images/vscode_debug_functions.png)

これで VSCode で `firebase/functions/src/firebase-functions` 下の Firebase Functions のソースコードにブレイクポイントを打ちながらデバッグすることが可能になりました。

Firebase Functions のソースコードを随時編集してホットリロードしながら同様にデバッグしたい場合は、`concurrently` を使用している `npm run watch` のコマンドの方を使用してください。

```shell
npm --prefix functions run watch && firebase emulators:start --inspect-functions --import data --export-on-exit
```

実行中の Firebase Emulator は Control + C で停止できますが、何らかの理由でプロセスが残ったままの場合には、次のコマンドを一通り実行してください。

```shell
kill -9 $(lsof -t -i:9099)
kill -9 $(lsof -t -i:5001)
kill -9 $(lsof -t -i:8080)
kill -9 $(lsof -t -i:8085)
kill -9 $(lsof -t -i:9199)
``
