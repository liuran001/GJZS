#本脚本由　by Han | 情非得已c，编写
#应用于搞机助手上


Start_Charging() {
    Start_Time
    Chargeing_DL=$(Power)
}

End_Charging() {
    Chargeing_DL1=$(Power)
    End_Time "从${Chargeing_DL}% - ${Chargeing_DL1}%充电"
}


if [[ ! -f $Charging_control && ! -f $Charging_control2 ]]; then
    echo "目前没有适配你的机型，您可以在关于里通过私信我寻求适配"
    echo "后会有期，即将退出"
    exit 1
fi
    [[ -f $Charging_control ]] && Status=`cat $Charging_control`
    [[ -f $Charging_control2 ]] && Status2=`cat $Charging_control2`
    Han=false
    echo "Stop=$Stop" > $Data_Dir/Charging_control2.log
    echo "Set_Greedy_Time=$Set_Greedy_Time" >> $Data_Dir/Charging_control2.log
    
    until $Han; do
        A=$(Power | tr -d '%')
        if [[ -z $B ]]; then
            Start_Charging
            echo "时间：`date '+%T'` | 电量：$(Power) | 正在保护充电中……" && let B=A+1
        elif [[ $A == $B ]]; then
            echo "时间：`date '+%T'` | 电量：$(Power) | 正在保护充电中……" && let B=A+1
        fi
        if [[ $A == $Stop ]]; then
            if [[ $Status == 0 || $Status2 == 1 ]]; then
                echo "时间：`date '+%T'` | 已充电到设置的电量：$Stop"
                echo "请手动关闭方案①充电控制开关，或者忘了关，重启手机才能正常充电"
                if [[ -n $Set_Greedy_Time ]]; then
                    echo "开始贪充 `echo "$Set_Greedy_Time"|sed -r -e 's/[0-9]$/&秒/' -e 's/s/秒/' -e 's/m/分钟/' -e 's/d/天/'`" 
                    echo "时间：`date '+%T'` | 电量：$(Power) | 正在贪懒充电中……"
                    sleep "$Set_Greedy_Time"
                    echo "时间：`date '+%T'` | 电量：$(Power) | 贪充结束，已停止充电。"
                else
                    echo "已停止充电"
                fi
                    End_Charging
                    [[ -f $Charging_control ]] && echo 1 >$Charging_control
                    [[ -f $Charging_control2 ]] && echo 0 >$Charging_control2
                    Han=true
            fi
        fi
        sleep 10
    done
