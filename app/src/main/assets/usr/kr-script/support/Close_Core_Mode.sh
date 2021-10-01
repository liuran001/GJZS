#本脚本由　by Han | 情非得已c，编写
#应用于搞机助手上


mask -v

if [[ $MAGISK_VER_CODE -ge 21000 ]]; then
    echo 0
    exit 0
else
    echo 1
fi
