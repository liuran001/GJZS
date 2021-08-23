#本脚本由　by Han | 情非得已c，编写
#应用于搞机助手上


if [[ -n $dpi ]];then
    adb2 -c wm density $dpi
    echo "已自定义修改dpi为：$dpi"
else
    adb2 -c wm density reset
    echo "已恢复默认初始值"
fi
    sleep 2
