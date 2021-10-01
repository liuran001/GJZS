#本脚本由　by Han | 情非得已c，编写
#应用于搞机助手上


if [[ $state -eq 1 ]]; then
    setprop service.adb.tcp.port 5555
    stop adbd; start adbd
elif [[ $state -eq 0 ]]; then
    adb usb &>/dev/null
    setprop service.adb.tcp.port -1
    stop adbd; start adbd
fi
