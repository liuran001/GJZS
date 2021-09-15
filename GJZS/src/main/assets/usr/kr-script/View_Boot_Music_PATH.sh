#本脚本由　by Han | 情非得已c，编写
#应用于搞机助手上


if [[ $1 = -p ]]; then
    echo "- 开始从/system  /vendor  /product里查找bootanimation.zip文件路径，理论上开机动画和开机音乐在同一目录下"
    echo "- 已找到的文件："
    echo
fi
    find /system /vendor /product -name 'bootanimation.zip' | sed 's/\/bootanimation.zip/\/bootaudio.mp3/g'
