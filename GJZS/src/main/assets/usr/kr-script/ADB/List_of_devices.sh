#本脚本由　by Han | 情非得已c，编写
#应用于搞机助手上

case $1 in
-0)
    a=`adb devices -l | grep -v -i 'List of .*'`
    Number=`adb devices | grep -v -i 'List of .*' | wc -l`
    if [[ -n `echo "$a" | grep -i 'unauthorized'` ]]; then
    {
        adb keygen "$Data_Dir/.android/adbkey"
        adb reconnect offline
            if [[ -f "$Data_Dir/Connect_Network_adb2.log" ]]; then
                . "$Data_Dir/Connect_Network_adb2.log"
                adb reconnect
                adb disconnect $ip:$port
                adb connect $ip:$port
            fi
    } &>/dev/null
                echo "- 已检测到未授权USB调试，已重新申请授权"
                echo "- 请在确定授权后，右上角菜单里刷新页面，重新检测"
    elif [[ -z "$a" ]]; then
        echo "！无设备连接"
    elif [[ "$Number" -gt 2 ]]; then
        echo "！多个设备连接"
        echo "$a"
    elif [[ -n "$a" ]]; then
        echo  "- 设备已连接："
        echo "$a"
    fi
;;

-FASTBOOT)
    a=`fastboot devices -l | sed 's/fastboot/ &/g'`
    if [[ -n "$a" ]]; then
        echo  "- 设备已连接："
        echo "$a"
    else
        echo "！无FASTBOOT设备连接"
    fi
;;

-9008)
    ui_print() {
        echo "$@"
        exit 0
    }
    
    a=`lsusb`
    echo "$a" | egrep -q '.*9008$' && ui_print '- 已处于9008模式下' || ui_print "！无9008设备连接"
    ui_print "$a"
;;

-USB)
    a=`lsusb`
    if [[ -n "$a" ]]; then
        b=`echo "$a" | wc -l`
        if [[ $b -eq 2 ]]; then
            echo "- 已连接到OTG，但是未连接到设备"
            echo "$a"
        elif [[ $b -gt 2 ]]; then
            echo  "- 设备已连接："
            echo "$a"
        fi
    else
        echo '！未连接OTG，或未开启OTG功能'
    fi
;;
esac
