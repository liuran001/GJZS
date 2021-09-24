#本脚本由　by Han | 情非得已c，编写
#应用于搞机助手上


if [[ $1 = -p ]]; then
    echo "- 开始从/system  /vendor  /product里查找bootanimation.zip文件"
    echo "- 已找到的文件："
    echo
fi
    find /system /vendor /product -name 'bootanimation.zip'
