# 青空文庫の書籍をダウンロードするシェルスクリプトを書いた

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

これで作品名.txt と言うファイルがディレクトリにできます。

