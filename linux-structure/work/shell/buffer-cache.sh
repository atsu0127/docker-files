#!/bin/bash

echo "ファイル作成前のシステム全体のメモリ使用量"
free

echo "1GBのファイルを作成します。これでカーネルはメモリ上に1GBのページキャッシュを獲得します。"
dd if=/dev/zero of=testfile bs=1M count=1K

echo "ページキャッシュ獲得後のシステム全体のメモリ使用量"
free

echo "ページキャッシュ削除後のシステム全体のメモリ使用量"
rm testfile
free
