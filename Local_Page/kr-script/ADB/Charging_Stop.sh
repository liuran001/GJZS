#本脚本由　by Han | 情非得已c，编写
#应用于搞机助手上


adb root &>/dev/null
echo 已禁止给对方设备供电
adbsu -c "
Charging_control=$Charging_control
Charging_control2=$Charging_control2
echo 1 >$Charging_control
echo 0 >$Charging_control2"
