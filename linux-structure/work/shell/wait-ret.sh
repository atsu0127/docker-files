#!/bin/bash

false &
wait $!
echo "falseコマンドが終了しました: $?"