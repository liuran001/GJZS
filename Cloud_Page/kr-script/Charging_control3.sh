#本脚本由　by Han | 情非得已c，编写
#应用于搞机助手上

set -x
Start_Charging() {
    Start_Time
    Chargeing_DL=$(Power)
}

End_Charging() {
    Chargeing_DL1=$(Power)
    End_Time "从${Chargeing_DL}% - ${Chargeing_DL1}%充电"
}

YiMan() {
    if [[ $Status == 0 || $Status2 == 1 ]]; then
        if [[ -n $C ]]; then
            C=$C
        elif [[ -z $C ]]; then
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
                C=1
                unset D
        fi
    fi
}

HuiFu() {
    if [[ $Status == 1 || $Status2 == 0 ]]; then
        if [[ -n $D ]]; then
            D=$D
        elif [[ -z $D ]]; then
            echo "电量已下降到设置好的$Start值，已再次启用充电"
            echo "时间：`date '+%T'` | 电量：$A | 正在保护充电中……" && let B=A+1
            [[ -f $Charging_control ]] && echo 0 >$Charging_control
            [[ -f $Charging_control2 ]] && echo 1 >$Charging_control2
            D=1
            unset C B
        fi
    fi
}


if [[ ! -f $Charging_control && ! -f $Charging_control2 ]]; then
    echo "目前没有适配你的机型，您可以在关于里通过私信我寻求适配"
    echo "后会有期，即将退出"
    exit 1
fi
    [[ -f $Charging_control ]] && Status=`cat $Charging_control`
    [[ -f $Charging_control2 ]] && Status2=`cat $Charging_control2`

echo "Stop=$Stop" > $Data_Dir/Charging_control3.log
echo "Start=$Start" >> $Data_Dir/Charging_control3.log
echo "Set_Greedy_Time=$Set_Greedy_Time" >> $Data_Dir/Charging_control3.log

until false; do
    A=$(Power | tr -d '%')
    if [[ -z $B ]]; then
        Start_Charging
        echo "时间：`date '+%T'` | 电量：$A | 正在保护充电中……" && let B=A+1
    elif [[ $A == $B ]]; then
        echo "时间：`date '+%T'` | 电量：$A | 正在保护充电中……" && let B=A+1
    fi
    
    if [[ $A -le $Start ]]; then
        HuiFu
    elif [[ $A -eq $Stop ]]; then
        YiMan
    fi
    sleep 10
done
