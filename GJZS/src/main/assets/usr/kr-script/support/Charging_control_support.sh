#本脚本由　by Han | 情非得已c，编写
#应用于搞机助手上


if [[ -f $Charging_control || -f $Charging_control2 ]]; then
    echo 1
else
    echo 0
fi
