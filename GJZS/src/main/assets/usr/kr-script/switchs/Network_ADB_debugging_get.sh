#本脚本由　by Han | 情非得已c，编写
#应用于搞机助手上


if [[ `getprop service.adb.tcp.port` -eq 5555 ]]; then
    echo 1
else
    echo 0
fi