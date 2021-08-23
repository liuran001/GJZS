#本脚本由　by Han | 情非得已c，编写
#应用于搞机助手上


if [[ -n $screen_brightness ]];then
    echo "您输入了$screen_brightness，即将开始修改。"
    settings put system screen_brightness $screen_brightness
    [[ $? = 0 ]] && echo "已成功修改当前屏幕亮度为：$screen_brightness"
elif [[ -n $screen_brightness2 ]];then
    echo "开始执行下方滑动修改方案…………"
    settings put system screen_brightness "$screen_brightness2"
    [[ $? = 0 ]] && echo "已成功修改当前屏幕亮度为：$screen_brightness2"
else
    echo "您没有输入数值，无法修改哦！！！"
fi
    sleep 3
