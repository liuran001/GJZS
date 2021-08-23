#本脚本由　by Han | 情非得已c，编写
#应用于搞机助手上


case $1 in
    -push)
        if [[ -n "$Dir" ]]; then
            echo "- 已选择推送$Dir目录下的所有文件到$Target"
            echo
            echo "- 开始发送……"
            sleep 1
            adb push "$Dir"/* "$Target"
        fi
        if [[ -n "$File" ]]; then
            echo "- 推送$File文件到$Target"
            adb push "$File" "$Target"
        fi
    ;;
    
    -pull)
        [[ ! -d "$Dir" ]] && mkdir -p "$Dir"
        echo "- 开始从对方设备复制文件/目录……"
        sleep 1
        adb pull "$Target" "$Dir"
    ;;
esac
