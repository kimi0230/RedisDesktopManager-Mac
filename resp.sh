#!/bin/bash

SHELL_FOLDER=$(cd "$(dirname "$0")";pwd)

echo '=======================Clone RDM repository======================='
git clone --recursive https://github.com/uglide/RedisDesktopManager.git resp

echo "=======================Switch to latest tag: ${TAG}===================="
cd $SHELL_FOLDER/resp
TAG=$(git describe --tags `git rev-list --tags --max-count=1`)
echo 'switch to latest tag: '$TAG
cd $SHELL_FOLDER/resp
git checkout -b $TAG $TAG

echo '=======================Build lz4======================='
cd $SHELL_FOLDER/resp/3rdparty/lz4/build/cmake
cmake -DLZ4_BUNDLED_MODE=ON -DBUILD_SHARED_LIBS=ON --build .
ls
make -s -j 8


echo '=======================Modify RDM version======================='
cd $SHELL_FOLDER
python ./resp/build/utils/set_version.py ${TAG} > ./resp/src/version.h
cd $SHELL_FOLDER/resp/src
echo 'backup resp.pro'
cp resp.pro resp.pro.bak
echo 'modify resp.pro'
sed -i "" "/^\( *\)VERSION=.*/s//\1VERSION=$TAG/" resp.pro


echo '=======================Release Translations======================='
cd $SHELL_FOLDER/resp/src
lupdate resp.pro
lrelease -verbose resp.pro


echo '=======================Install Python requirements======================='
mkdir -p $SHELL_FOLDER/resp/bin/osx/release
cd $SHELL_FOLDER/resp/bin/osx/release
cp -rf $SHELL_FOLDER/resp/src/py .
cd py
echo six >> requirements.txt
sudo pip3 install -t . -r requirements.txt
sudo python3 -m compileall -b .
sudo find . -name "*.py" | sudo xargs rm -rf
sudo find . -name "__pycache__" | sudo xargs rm -rf
sudo find . -name "*.dist-info" | sudo xargs rm -rf
sudo find . -name "*.egg-info" | sudo xargs rm -rf


echo "=======================Build RESP ${TAG}======================="
cd $SHELL_FOLDER/resp/src/resources
echo 'copy Info.plist'
cp Info.plist.sample Info.plist
cd $SHELL_FOLDER/resp/src
qmake resp.pro CONFIG-=debug
make -s -j 8


echo "=======================Copy Translations======================="
cd $SHELL_FOLDER/resp/src
mkdir ../bin/osx/release/RESP.app/Contents/translations
cp -f ./resources/translations/*.qm ../bin/osx/release/RESP.app/Contents/translations
echo "OK!"

echo "=======================SUCCESS======================="
echo 'App file is:'$SHELL_FOLDER/resp/bin/osx/release/RESP.app
