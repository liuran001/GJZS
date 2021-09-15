#本脚本由　by Han | 情非得已c，编写
#应用于搞机助手上


s=/cache/recovery/openrecoveryscript
[[ ! -f "$zipFile" ]] && abort "！未找到ROM卡刷包"

echo >$s

if [[ -z "$Wipe" ]]; then
    echo "未选择高级清除"
else
    for i in $Wipe; do
        echo "wipe $i" >>$s
    done
fi

echo "install $zipFile" >>$s

if [[ $Function = Magisk ]]; then
    Choice=1
    . $Load com.topjohnwu.magisk
    echo "install $Download_File" >>$s
elif [[ $Function = sign ]]; then
    echo "cmd File=$EXECUTOR_PATH" >>$s
    for i in `grep '/boot' "$Data_Dir/by_name.log" | sed 's/|.*//'`; do
        echo "cmd $ShellScript/MultiFunction.sh Magisk -sign $i $i" >>$s
    done
else
    echo "未选择附加功能"
fi

    if [[ $Google_Verify -eq 1 ]]; then
        echo 'cmd settings put secure user_setup_complete 1
        cmd settings put global device_provisioned 1' >>$s
    fi
    
        [[ $ChongQi -eq 1 ]] && echo 'reboot' >>$s
        echo "即将在5秒后自动重启，开始倒计时……"
        for i in $(seq 5 -1 1); do
            echo $i
            sleep 1
        done
            echo "即将重启"
            reboot recovery
