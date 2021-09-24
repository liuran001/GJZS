#本脚本由　by Han | 情非得已c，编写
#应用于搞机助手上


mask Automatic_protective_charging
user_versionCode=$versionCode
version=v2021011815
versionCode=2021011815
author='by：Han | 情非得已c'
jian=$Module/Charging_control4.sh
log=$Module/充电记录.log

if [[ "$1" = -status ]]; then
    if [[ -d "$Module" ]]; then
        echo "- 模块已安装"
        [[ $user_versionCode -lt versionCode ]] && echo "- 发现新版本：$version（$versionCode）"
    fi
    exit 0
fi
    mask -vc

    echo "Stop=$Stop" > $Data_Dir/Charging_control4.log
    echo "Start=$Start" >> $Data_Dir/Charging_control4.log
    echo "Set_Greedy_Time=$Set_Greedy_Time" >> $Data_Dir/Charging_control4.log
    echo "Delay=$Delay" >> $Data_Dir/Charging_control4.log
    echo "ChongQi=$ChongQi" >> $Data_Dir/Charging_control4.log
    echo "DEBUG=$DEBUG" >> $Data_Dir/Charging_control4.log
    
    
    if [[ -f $Charging_control || -f $Charging_control2 ]]; then
        echo "支持您的设备"
        if [[ $Stop -lt 100 ]]; then
            description="由「搞机助手」生成的自动充电保护模块，大于或等于$Stop停止充电，低于或等于$Start才能允许充电，不需要可随时卸载重启即可恢复。"
        elif [[ $Stop -eq 100 ]]; then
            description="由「搞机助手」生成的自动充电保护模块，等于$Stop停止充电，低于或等于$Start才能允许充电，不需要可随时卸载重启即可恢复。"
        fi
    elif [[ ! -f $Charging_control && ! -f $Charging_control2 ]]; then
        error "目前没有适配你的机型，您可以在关于里通过私信我寻求适配"
        abort "后会有期……"
    fi
    
        [[ ! -d $Module ]] && mkdir -p $Module
        rm -f $Module/*
        [[ $MAGISK_VER_CODE -lt 18100 ]] && touch $Module/auto_mount && echo "已创建auto_mount"
        [[ $DEBUG -eq 1 ]] && description="$description日志保存路径：$log" && DEBUG=true || DEBUG=false


cat <<Han >$jian
#!`which sh`
#本脚本由搞机助手自动创建
#作者：$author
#请不要试图篡改本脚本，否则一切后果自负，已安装版本：$version($versionCode)
#特别鸣谢Magisk提供服务支持：by topjohnwu



Time() {
    date '+%F  %H:%M:%S'
}

MODDIR=\${0%/*}
Charging_control=$Charging_control
Charging_control2=$Charging_control2
level=/sys/class/power_supply/battery/capacity
log=\$MODDIR/充电记录.log
Start=$Start
Stop=$Stop
Delay=$Delay
DEBUG=$DEBUG
Set_Greedy_Time=$Set_Greedy_Time
Status=0
Status2=1

unset L H
[[ ! -f \$Charging_control && ! -f \$Charging_control2 ]] && exit 1
echo "当前模块版本：$version（$versionCode）" >\$log
echo "时间：\`Time\`" >>\$log
echo "脚本已执行正在保护充电，电量：\$(cat \$level)%" >>\$log
sleep 2m


until false; do
    [[ -n \$Delay ]] && sleep \$Delay
    Power=\$(cat \$level)%
    [[ \`wc -c < \$log\` -ge 9338880 ]] && rm -f \$log
    \$DEBUG && echo "\`Time\`，正在保护充电中，电量：\$Power" >>\$log
    [[ -f \$Charging_control ]] && Status=\`cat \$Charging_control\`
    [[ -f \$Charging_control2 ]] && Status2=\`cat \$Charging_control2\`
    if [[ \$(cat \$level) -ge \$Stop ]]; then
        if [[ \$Status -eq 0 || \$Status2 -eq 1 ]]; then
            if [[ -n \$L ]]; then
                L=\$L
            elif [[ -z \$L ]]; then
                [[ -n \$Set_Greedy_Time ]] && sleep \$Set_Greedy_Time
                [[ -f \$Charging_control ]] && echo 1 >\$Charging_control
                [[ -f \$Charging_control2 ]] && echo 0 >\$Charging_control2
                L=1
                unset H
                \$DEBUG && echo "\`Time\`，已在\$Power时停止充电" >>\$log
            fi
        fi
    elif [[ \$(cat \$level) -le \$Start ]]; then
        if [[ \$Status -eq 1 || \$Status2 -eq 0 ]]; then
            if [[ -n \$H ]]; then
                H=\$H
            elif [[ -z \$H ]]; then
                [[ -f \$Charging_control ]] && echo 0 >\$Charging_control
                [[ -f \$Charging_control2 ]] && echo 1 >\$Charging_control2
                H=1
                unset L
                \$DEBUG && echo "\`Time\`，已在\$Power时重新启用充电" >>\$log
            fi
        fi
    fi
done
Han

cat <<Han >$Module_S2
#!`which sh`
#本脚本由搞机助手自动创建
#作者：$author
#请不要试图篡改本脚本，否则一切后果自负，已安装版本：$version($versionCode)
#特别鸣谢Magisk提供服务支持：by topjohnwu


MODDIR=\${0%/*}
export PATH="$PATH0:$ELF4_Path:$MAGISKTMP/.magisk/busybox"
`which sh` \$MODDIR/Charging_control4.sh
Han

printf "id=Automatic_protective_charging 
name=方案④全自动充电保护
version=$version
versionCode=$versionCode
author=$author
description=$description" >$Module_XinXi

[[ -f $Module_S2 ]] && echo "Magisk模块创建完成，将在下次重启时生效"
echo "- 查看「$name」模块描述："
echo "- $description"
CQ
