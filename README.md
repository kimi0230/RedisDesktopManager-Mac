# RedisDesktopManager-Mac 

This repository provides a shell can compile [RedisDesktopManager](https://github.com/uglide/RedisDesktopManager), as well as a compiled DMG file.

Latest version: 2020.6

![screenshots](https://raw.githubusercontent.com/zgr0629/RedisDesktopManager-Mac/master/screenshots.2020.6.png)

## Usage

#### brew install package
```shell
brew install openssl cmake python3 qt@5
```
Change `qmake rdm.pro CONFIG-=debug` in `rdm.sh` qt5 to `/usr/local/Cellar/qt@5/5.15.2/bin/qmake rdm.pro CONFIG-=debug`. It is a workaround prevent qmake from runing `/Users/kimiimac/opt/anaconda3/bin/qmake`.

#### install python requirements

```shell
pip3 install -r https://raw.githubusercontent.com/uglide/RedisDesktopManager/2021/src/py/requirements.txt --upgrade
```

Download latest DMG file from [release](https://github.com/zgr0629/RedisDesktopManager-Mac/releases) page. Load Dmg file and drag .app file to your Application folder and enjoy.

If you have any questions, please feel free to submit an issue.

## Update for Big Sur

Big sur is missing CoreFoundation, this `rmd.sh` will meet an error like:

```bash
clang: error: no such file or directory: '/System/Library/Frameworks/CoreFoundation.framework/Versions/A/CoreFoundation'
clang: error: no such file or directory: '/System/Library/Frameworks/CoreServices.framework/Versions/A/CoreServices'
make: *** [../bin/osx/release/RDM.app/Contents/MacOS/RDM] Error 1
```

Thanks to https://github.com/FuckDoctors/rdm-builder, I build a github action to build RDM.app

## Reference
* http://docs.redisdesktop.com/en/latest/install/#mac-os-x
* https://github.com/zgr0629/RedisDesktopManager-Mac