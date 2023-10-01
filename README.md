# 青空文庫の書籍をダウンロードするシェルスクリプトを書いた

*青空文庫では作品の HTML ページに "著者名 作品名" のタイトルを与えています。サイト内検索の HTML をパースすれば検索語を含む作品の著者名・作品名・URLを一度に取得できるのではと思いつき、このプログラムを書きました。*  
*しかし実際は、著者名がなかったり著者名と作品名が逆になったりしたファイルなどがあり想定通りには動かないことがわかりました。*

このプログラムは青空文庫から比較的少数のファイルをダウンロードすることを前提にしています。

青空文庫の全ての作品をダウンロードしたいなどの場合は、github にデータがアップロードされているのでそちらを使ってください。

[GitHub - aozorahack/aozorabunko_text: text-only archives of www.aozora.gr.jp](https://github.com/aozorahack/aozorabunko_text)

## やりたいこと

それなりの頻度で日本語の例文が欲しくなるときがある。適当にでっち上げても良いのだが、どうせなら実際に使われているものが良い。

青空文庫には有名な文章がたくさんあるので、ここからダウンロードしたい。

## 今回書いたスクリプト

- aozora\_downloader.bash
    - タイトルリストの内容を上から順番にダウンロードする
- fetch\_file.bash
    - ダウンロードして文字コードを整え Pandoc で txt ファイルにする
        - 青空文庫は SJIS を使っているので Pandoc に通す前に nkf で文字コードを変換する必要がある
            - nkf なのは ```nkf --guess```を使いたいから。
- hay.sh
    - grep する際に読みやすく整形するスクリプト
        - ルビを削除し、検索結果の間に改行を入れてくれる

## 使い方

```shell
$ ./aozora_downloader.bash titles.txt
```

titles.txt は作品のタイトルと URL からなる CSV。

これで作品名.txt という名前のファイルがディレクトリにできます。

## titles.txt

titles.txt は著者名・作品名・URL を列挙したテキストファイルです。

青空文庫でサイト内検索した結果ページから、次のプログラムをコンソールに入力することで取得できます。

```javascript
[...document.querySelectorAll('a')]
    .filter(e => e.href.includes("file"))
    .map(e => {const tmp = `"${(e.textContent).replace(/aozora.*/,"").replace(" ",'" "')}"`.split(" ");
               return [tmp[0], tmp[1] ,`"${e.href}"`]
              })
    .join("\n")
```
