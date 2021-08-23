#本脚本由　by Han | 情非得已c，编写
#应用于搞机助手上


if [[ $state -eq 1 ]]; then
    settings put global enable_freeform_support 1
    echo "在安卓版本大于7时，可进入开发者选项，把「强制将活动设为可调整大小」打开，然后重启手机后生效"
    echo "由于MIUI系统的深度定制，阉割掉了此功能，所以MIUI系统不可用"
elif [[ $state -eq 0 ]]; then
    settings put global enable_freeform_support 0
fi
