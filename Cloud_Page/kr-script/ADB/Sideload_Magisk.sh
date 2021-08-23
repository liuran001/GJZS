#本脚本由　by Han | 情非得已c，编写
#应用于搞机助手上


if [[ $Customize -eq 1 ]]; then
    Download_File="$Magisk_File"
    [[ ! -f "$Download_File" ]] && abort "！$Download_File文件不存在"
    File_Name=`basename "$Download_File"`
else
   Choice=1
    . $Load com.topjohnwu.magisk
fi
    if [[ -f "$Download_File" ]]; then
        echo "- 如果无法自动重启到sideload模式请手动进入"
        case $Phone_Status in
            system|Recovery)
                echo "- 开始重启到sideload"
                adb reboot sideload
            ;;
            FASTBOOT)
                echo "- 等待设备连接到recovery……"
                fastboot flash misc $PeiZhi_File/misc.bin &>/dev/null
                fastboot reboot &>/dev/null
                adb wait-for-recovery
                echo "- 开始重启到sideload"
                adb reboot sideload
            ;;
        esac
            echo "- 等待设备连接到sideload……"
            adb wait-for-sideload
            echo "- 已连接到设备：`adb devices | grep -i 'sideload'`"
            echo "- 开始ADB线刷$File_Name……"
            echo "- 等待设备刷入完毕……"
            adb sideload "$Download_File" 1>/dev/null
            [[ $? -eq 0 ]] && echo "- $File_Name刷入完毕" || abort "！$File_Name刷入失败，请确保对方设备使用的是三方recovery"
            adb wait-for-recovery
                if [[ $ChongQi -eq 1 ]]; then
                    echo "- 已自动重启设备"
                    adb reboot
                fi
    else
        abort "！文件下载出错请重新下载，请检查网络是否正常"
    fi
