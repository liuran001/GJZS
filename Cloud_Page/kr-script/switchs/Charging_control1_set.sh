#本脚本由　by Han | 情非得已c，编写
#应用于搞机助手上


if [[ ! -f $Charging_control && ! -f $Charging_control2 ]]; then
    echo "目前没有适配你的机型，您可以在关于里通过私信我寻求适配"
    echo "后会有期，即将退出"
    exit
fi

if [[ $state == 0 ]]; then
    [[ -f $Charging_control ]] && echo 0 >$Charging_control
    [[ -f $Charging_control2 ]] && echo 1 >$Charging_control2
elif [[ $state == 1 ]]; then
    [[ -f $Charging_control ]] && echo 1 >$Charging_control
    [[ -f $Charging_control2 ]] && echo 0 >$Charging_control2
fi
