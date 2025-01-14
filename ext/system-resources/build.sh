#!/bin/sh
set -e

apk add --no-cache nodejs npm
npm install -g npm@7.19.1

mkdir -p data

# txAdmin
MONITOR_ARTIFACT_URL="https://github.com/tabarra/txAdmin/releases/download/v7.0.0/monitor.zip"

MONITOR_PATH=data/monitor
MONITOR_ARTIFACT_PATH=data/monitor.zip

rm -rf $MONITOR_PATH
mkdir -p $MONITOR_PATH

curl -Lo $MONITOR_ARTIFACT_PATH $MONITOR_ARTIFACT_URL
unzip $MONITOR_ARTIFACT_PATH -d $MONITOR_PATH
rm $MONITOR_ARTIFACT_PATH

# chat
cd resources/chat/

npm install yarn@1.22
node_modules/.bin/yarn
node_modules/.bin/webpack
cd ../../

rm -rf resources/chat/node_modules/
cp -a resources/chat data/chat
rm -rf data/chat/package.json data/chat/yarn.lock
rm -rf data/chat/html/
mkdir data/chat/html/
cp -a resources/chat/html/vendor data/chat/html/vendor
