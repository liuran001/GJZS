#本脚本由　by Han | 情非得已c，编写
#应用于搞机助手上


if [[ $Screen_Size0 = 1 ]]; then
    wm size reset
    [[ $? = 0 ]] && echo "已恢复默认" && exit 0
fi

    if [[ -n $Screen_Size_X && -n $Screen_Size_Y ]]; then
        wm size ${Screen_Size_X}x${Screen_Size_Y}
        [[ $? = 0 ]] && echo "已修改屏幕分辨率为：${Screen_Size_X}X${Screen_Size_Y}"
    fi
    sleep 2