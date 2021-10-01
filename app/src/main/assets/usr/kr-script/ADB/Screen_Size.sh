#本脚本由　by Han | 情非得已c，编写
#应用于搞机助手上


if [[ $Screen_Size0 = 1 ]]; then
    adb2 -c wm size reset
    [[ $? = 0 ]] && echo "已恢复默认"
    sleep 2
    exit 0
fi

echo "
if [[ -n $Screen_Size_X && -n $Screen_Size_Y ]]; then
    wm size ${Screen_Size_X}x${Screen_Size_Y}
    [[ $? = 0 ]] && echo "已修改屏幕分辨率为：${Screen_Size_X}X${Screen_Size_Y}"
else
    echo "没有数值无法修改"
fi
" | adb2 -c
sleep 2
