#!/bin/bash
# Paperサーバーのバージョンを変更するスクリプト
# 使用方法: ./change_version.sh <major> <minor>
set -e

MAJOR=$1
MINOR=$2

# バージョン文字列の組み立て
case $MAJOR in
    8)
        VERSION="1.8.8"
        ;;
    12)
        VERSION="1.12.2"
        ;;
    20)
        # マイナー指定がない場合は 1.20.1 をデフォルトに
        if [ -z "$MINOR" ]; then MINOR="1"; fi
        VERSION="1.20.$MINOR"
        ;;
    21)
        # マイナー指定がない場合は 1.21.1 をデフォルトに
        if [ -z "$MINOR" ]; then MINOR="1"; fi
        VERSION="1.21.$MINOR"
        ;;
    *)
        VERSION=$MAJOR # 直接入力（1.16.5など）の場合
        ;;
esac

echo "★ Paper $VERSION への切り替えを開始します..."

# Paper APIから最新のビルド番号を取得
BUILD_INFO=$(curl -s https://api.papermc.io/v2/projects/paper/versions/$VERSION)
if echo "$BUILD_INFO" | grep -q "error"; then
    echo "エラー: バージョン $VERSION は PaperMC API で見つかりませんでした。"
    echo "指定したメジャーバージョン $MAJOR に対して、マイナーバージョン $MINOR が存在するか確認してください。"
    exit 1
fi

LATEST_BUILD=$(echo "$BUILD_INFO" | jq -r '.builds[-1]')
DOWNLOAD_URL="https://api.papermc.io/v2/projects/paper/versions/$VERSION/builds/$LATEST_BUILD/downloads/paper-$VERSION-$LATEST_BUILD.jar"

echo "★ ビルド $LATEST_BUILD をダウンロード中..."
mkdir -p ./run
wget "$DOWNLOAD_URL" -O ./run/paper.jar --quiet

echo "★ Paper $VERSION (ビルド $LATEST_BUILD) への更新が完了しました。"
echo "★ サーバーを起動（F5キー）して動作を確認してください。"
