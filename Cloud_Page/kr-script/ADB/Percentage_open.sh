#本脚本由　by Han | 情非得已c，编写
#应用于搞机助手上


if [[ $battery == 1 ]];then
    adb2 -c content insert --uri content://settings/system --bind name:s:status_bar_show_battery_percent --bind value:i:$battery
    [ $? == 0 ] && echo "已成功开启电量百分比"
elif [[ $battery == 0 ]];then
    adb2 -c content insert --uri content://settings/system --bind name:s:status_bar_show_battery_percent --bind value:i:0
    [ $? == 0 ] && echo "已选择恢复默认"
fi
    sleep 2
    exit 0
