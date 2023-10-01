#!/bin/bash

# 元の行を変数に格納
for line in $(cat $1); do
# スペースで行を分割して配列に格納
    IFS=',' read -ra parts <<< "$line"

# 配列から各要素を取り出す
    author="${parts[1]}"
    title="${parts[2]}"
    url="${parts[0]}"

# 各変数の値を表示
    echo "著者: $author"
    echo "タイトル: $title"
    echo "URL: $url"

    bash downloader.bash $url
    mv output.txt $title.txt
    sleep 3

done

