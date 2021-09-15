#本脚本由　by Han | 情非得已c，编写
#应用于搞机助手上


. $Load Redmi-K30-5G-recovery

case $Phone_Status in
    system|Recovery)
        echo "- 正在自动重启至FASTBOOT模式"
        adb reboot bootloader
    ;;
esac
    unset a b
    a=`fastboot devices 2>/dev/null`
    if [[ -n $a ]]; then
        echo "- 已连接 ${a/fastboot/} 设备"
    else
        echo "- 开始等待设备连接，如果等待1分钟后还是无法连接成功，请重新插拔数据线"
        echo "- 如果最终都无法连接成功，请检查您的OTG是否能正常的进行文件传输"
        until [[ -n $b ]]; do
            b=`fastboot devices 2>/dev/null`
            [[ -n $b ]] && echo "- 等待 ${b/fastboot/} 设备连接成功"
        done
    fi
        fastboot flash recovery "$Download_File"
        fastboot flash misc $PeiZhi_File/misc.bin &>/dev/null
        fastboot reboot
