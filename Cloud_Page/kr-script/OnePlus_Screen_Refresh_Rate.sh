#本脚本由　by Han | 情非得已c，编写
#应用于搞机助手上


getprop ro.product.brand | grep -iq OnePlus
if [[ $? -ne 0 ]]; then
    abort "您的设备不是一加，无法执行"
fi
    settings put global oneplus_screen_refresh_rate 0
    [[ $? = 0 ]] && echo "已激活一加隐藏的屏幕刷新率选项"
