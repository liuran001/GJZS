#本脚本由　by Han | 情非得已c，编写
#应用于搞机助手上


script="${script:="$script2"}"

Variable() {
    echo "script=$script"
    echo "script2=$script2"
    echo "script3=$script3"
    echo "script4=$script4"
    echo "script5=$script5"
    echo "script6=$script6"
}

Start_Time
if [[ -f "$script" ]]; then
    echo "已选择方案①，线刷"$script"脚本存在开始线刷中……"
    cd ${script%/*}
    sh "$script"
    End_Time 线刷
    exit 0
else
    echo "方案①未找到"$script"线刷.sh脚本，开始执行方案②……"
fi

C=$(Variable|grep =1|wc -l)

if [[ $C > 1 ]]; then
    echo "你是真的皮同时勾选$C个刷机脚本，只能勾选一个，重新勾选再来吧！"
elif [[ $C == 0 ]]; then
    echo "方案①和方案②里没看到您选择了脚本，无法进行线刷"
elif [[ $C == 1 ]]; then
    echo "即将开始线刷……"
    echo "！如果提示Missmatching image and device（翻译：错误匹配图像和设备）就是代表你的线刷包可能下错了"
    printf '！如果百分百确认线刷包设备代号无误的话，可以把\n「if [ $? -ne 0 ] ; then echo "Missmatching image and device"; exit 1; fi」\n该行代码删除即可，当然删了一切后果需要您自己承担风险！'
    echo -e "\n\n----------------------------------------\n"

    [[ $script3 = 1 ]] && echo "您当前选择了：清除所有数据" && E='flash_all.sh'
    [[ $script4 = 1 ]] && echo "您当前选择了：保留用户data数据" && E='flash_all_except_data.sh'
    [[ $script5 = 1 ]] && echo "您当前选择了：清除全部数据并lock上锁" && E='flash_all_lock.sh'
    [[ $script6 = 1 ]] && echo "您当前选择了：清除全部数据并lock上锁并进行CRC文件效验" && E='flash_all_lock_crc.sh'
    
        if [[ -f "$lu3"/${E} ]]; then
            cd "$lu3"
            sh "$lu3"/${E}
            End_Time 线刷
        else
            echo ""$lu3"/${E}刷机脚本文件不存在"
        fi
fi
exit 0
