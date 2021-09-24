#本脚本由　by Han | 情非得已c，编写
#应用于搞机助手上


f [[ -n $screen_brightness ]];then
    echo "您输入了$screen_brightness，即将开始修改。"
    adb2 -c settings put system screen_brightness $screen_brightness 2>/dev/null
    echo "已成功修改当前屏幕亮度为：$screen_brightness"
else
    echo "您没有输入数值，无法修改哦！！！"
    echo "开始执行下方滑动修改方案…………"
    adb2 -c settings put system screen_brightness $screen_brightness2
fi
    sleep 3
    exit 0
