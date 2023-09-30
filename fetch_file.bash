#!/usr/bin/bash

# 一時ディレクトリのパスを指定（例：/tmp）
temp_dir="/tmp"

# ランダムな一時ファイル名を生成
temp_file="${temp_dir}/tmp_$(date +%s%N).html"

# 1. wget で HTML を取得する
wget "$1" -O "$temp_file"

# 2. nkf でエンコーディングを UTF-8 にする
encoding=$(nkf --guess "$temp_file")
echo "this is $encoding"

# Pandoc は入出力ともに UTF-8 を使います
if [[ ! $encoding =~ UTF-8.* ]]; then
    # UTF-8 に変換して一時ファイルに上書き
    nkf -w --overwrite "$temp_file"
fi

# 3. Pandoc でプレーンテキストにする
echo "HTML to Plain text"
pandoc -f html -t plain "$temp_file" > output.txt

# 4. 一時ファイルを削除する
rm -f "$temp_file"
