#本脚本由　by Han | 情非得已c，编写
#应用于搞机助手上


echo "Clean=$Clean" > $Data_Dir/$1.log
echo "Cache=$Cache" >> $Data_Dir/$1.log
echo "Frequency=$Frequency" >> $Data_Dir/$1.log
echo "Compulsory_Rescue=$Compulsory_Rescue" >> $Data_Dir/$1.log
echo "Set_Time=$Set_Time" >> $Data_Dir/$1.log
echo "Pattern=$Pattern" >> $Data_Dir/$1.log
echo "OTA=$OTA" >> $Data_Dir/$1.log
echo "DPI=$DPI" >> $Data_Dir/$1.log
echo "size=$size" >> $Data_Dir/$1.log

if [[ `getprop init.svc.bootanim` != "stopped" ]]; then
    abort "！未支持您的设备请联系我适配，错误代码：`getprop init.svc.bootanim`"
fi
    if [[ $Clean -eq 1 ]]; then
        if [[ $Frequency -le $Cache ]]; then
            echo "- 当前设置方案①重启次数=$Cache"
            echo "- 当前设置方案②重启次数=$Frequency"
            abort "！方案①的重启次数小于或等于方案②设置的重启次数无法安装，方案②重启次数设置至少要比方案①大1"
        fi
    fi

    echo "$Set_Time" | egrep 'm|s' && abort "！设置的时间不能带单位，只允许数字和小数点"


MODID=$1
mask -vc
mask $MODID
. $Load $MODID
jian=$Module/Automatic_brick_rescue.sh
jian2=$Module/Automatic_brick_rescue2.sh
jian3=$Module/Number_of_brick_rescue.log
jian4=$Module/Automatic_brick_rescue3.sh

a=
[[ -f $jian3 ]] && a=`cat $jian3`
rm -rf $Module
mkdir -p $Module
[[ -n $a ]] && echo "$a" >$jian3


cat <<Han >$Module_S
#!`which sh`
#本脚本由搞机助手自动创建
#作者：$author
#请不要试图篡改本脚本，否则一切后果自负，已安装版本：$version($versionCode)
#特别鸣谢Magisk提供服务支持：by topjohnwu


MODDIR=\${0%/*}
export PATH="$PATH0:$ELF4_Path:$MAGISKTMP/.magisk/busybox"
`which sh` \$MODDIR/Automatic_brick_rescue.sh
exit 0
Han

cat <<Han >$Module_S2
#!`which sh`
#本脚本由搞机助手自动创建
#作者：$author
#请不要试图篡改本脚本，否则一切后果自负，已安装版本：$version($versionCode)
#特别鸣谢Magisk提供服务支持：by topjohnwu


MODDIR=\${0%/*}
export PATH="$PATH0:$ELF4_Path:$MAGISKTMP/.magisk/busybox"
Han
if [[ $OTA = 1 ]]; then
cat <<Han >>$Module_S2
save_version_file=\$MODDIR/save_version
save_version=\$(cat \$save_version_file)
now_version=\$(getprop ro.system.build.id)
if [[ \$save_version != \$now_version ]];then
   getprop ro.system.build.id > \$save_version_file
   sleep 15m
fi
Han
fi
cat <<Han >>$Module_S2
`which sh` \$MODDIR/Automatic_brick_rescue3.sh &
`which sh` \$MODDIR/Automatic_brick_rescue2.sh
exit 0
Han


cat <<Han >$jian2
#!/system/bin/sh
#本脚本由搞机助手自动创建
#作者：$author
#请不要试图篡改本脚本，否则一切后果自负，已安装版本：$version($versionCode)
#特别鸣谢Magisk提供服务支持：by topjohnwu


Disable_All_Modules() {
    ls "$Modules_Dir" | while read i; do
        [[ "\$i" = "\$MODID" ]] && continue
        touch "$Modules_Dir/\$i/disable" &>/dev/null
    done
    reboot
}

Statistics() {
    if [[ ! -f \$LOG ]]; then
        echo "1" >\$LOG
    else
        Number_of_brick_rescue=\`cat \$LOG\`
        p="\$(expr \$Number_of_brick_rescue + 1)"
        echo "\$p" >\$LOG
    fi
}


MODDIR=\${0%/*}
MODID=\${MODDIR##*/}
Module_XinXi=\$MODDIR/module.prop
START_LOG=\$MODDIR/Number_of_starts.log
LOG=\$MODDIR/Number_of_brick_rescue.log
Han


cp -f $jian2 $jian
cp -f $jian2 $jian4

if [[ $OTA = 1 ]]; then
cat <<Han >>$jian4
now_version=\$(getprop ro.system.build.id)
save_version_file=\$MODDIR/save_version
save_version=\$(cat \$save_version_file)
Han
fi
if [[ $DPI = 1 ]]; then
cat <<Han >>$jian4
save_dpi_file=\$MODDIR/save_dpi
save_dpi=\$(cat \$save_dpi_file)
Han
fi
if [[ $size = 1 ]]; then
cat <<Han >>$jian4
save_size_file=\$MODDIR/save_size
save_size=\$(cat \$save_size_file)
Han
fi
cat <<Han >>$jian4

while [[ ! \$status = 1 ]]
do
        if [[ \`getprop init.svc.bootanim\` = "stopped" ]]; then
Han
if [[ $DPI = 1 ]]; then
cat <<Han >>$jian4
            now_dpi=\`echo -e "\\\`wm density | awk -F': ' '{print \$2}' | sed -n 2p\\\`\c"\`
            [[ ! \$now_dpi ]] && now_dpi=\`echo -e "\\\`wm density | awk -F': ' '{print \$2}' | sed -n 1p\\\`\c"\`
            if [[ \$save_dpi != \$now_dpi ]]; then
            wm density \$save_dpi
            fi
Han
fi
if [[ $size = 1 ]]; then
cat <<Han >>$jian4
            now_size=\`echo -e "\\\`wm size | awk -F': ' '{print \$2}' | sed -n 2p\\\`\c"\`
            [[ ! \$now_size ]] && now_size=\`echo -e "\\\`wm size | awk -F': ' '{print \$2}' | sed -n 1p\\\`\c"\`
            if [[ \$save_size != \$now_size ]]; then
            wm size \$save_size
            fi
Han
fi
cat <<Han >>$jian4
            rm -f "\$START_LOG"
            if [[ -f \$LOG ]]; then
            Number_of_brick_rescue=\`cat \$LOG\`
            sed -i "/^description=/c description=用途：当刷入一些模块后导致无法正常开机，触发已设置的自动救砖操作方式：在重启第2次时清除系统包名缓存和关闭SELinux模块尝试第3次开机操作。如果再重启第4次时未开机，强制禁用所有模块开机一次后仍无法进入系统后最终进入recovery模式，同时删除启动记录次数文件，重新从1开始记录开机次数。正常启动卡在第二屏等待2.5分钟后无法开机，自动禁用所有模块尝试一次开机，已为您自动救砖：\$Number_of_brick_rescue次。" "\$Module_XinXi"
Han
if [[ $OTA = 1 ]]; then
cat <<Han >>$jian4
            [[ -f \$save_version_file ]] && echo "\$now_version" > "\$save_version_file"
Han
fi
cat <<Han >>$jian4
        fi
            status=1
            else
            sleep 2
fi
done
Han

if [[ $OTA = 1 ]]; then
echo '- 已选择开启OTA支持'
echo $(getprop ro.system.build.id) > $Modules_Dir/Automatic_brick_rescue/save_version
else
[[ -f $Modules_Dir/Automatic_brick_rescue/save_version ]] && rm $Modules_Dir/Automatic_brick_rescue/save_version
fi
if [[ $DPI = 1 ]]; then
echo '- 已选择开启DPI锁定'
echo -e "`wm density | awk -F': ' '{print $2}' | sed -n 2p`\c" > $Modules_Dir/Automatic_brick_rescue/save_dpi
[[ ! -s $Modules_Dir/Automatic_brick_rescue/save_dpi ]] && echo -e "`wm density | awk -F': ' '{print $2}' | sed -n 1p`\c" > $Modules_Dir/Automatic_brick_rescue/save_dpi
[[ ! -s $Modules_Dir/Automatic_brick_rescue/save_dpi ]] && echo "! DPI锁定不支持你的机型，已经自动关闭" && rm $Modules_Dir/Automatic_brick_rescue/save_dpi && DPI=0
else
[[ -f $Modules_Dir/Automatic_brick_rescue/save_dpi ]] && rm $Modules_Dir/Automatic_brick_rescue/save_dpi
fi
if [[ $size = 1 ]]; then
echo '- 已选择开启屏幕分辨率锁定'
echo -e "`wm size | awk -F': ' '{print $2}' | sed -n 2p`\c" > $Modules_Dir/Automatic_brick_rescue/save_size
[[ ! -s $Modules_Dir/Automatic_brick_rescue/save_size ]] && echo -e "`wm size | awk -F': ' '{print $2}' | sed -n 1p`\c" > $Modules_Dir/Automatic_brick_rescue/save_size
[[ ! -s $Modules_Dir/Automatic_brick_rescue/save_size ]] && echo "! 屏幕分辨率锁定不支持你的机型，已经自动关闭" && rm $Modules_Dir/Automatic_brick_rescue/save_size && size=0
else
[[ -f $Modules_Dir/Automatic_brick_rescue/save_size ]] && rm $Modules_Dir/Automatic_brick_rescue/save_size
fi

if [[ $Clean -eq 1 ]]; then
    echo 0 >$Status
    (
    PATH="$PATH0"
    if [[ -z `$which setenforce` ]]; then
        echo "- 检测到系统缺少命令，开始复制busybox"
        cp -f "$ELF4_Path/busybox" $Module
        chmod 755 $Module/busybox
        echo 127 >$Status
    fi
    )
    Frequency=$((Frequency+1))
    Cache1=$((Cache+1))
    Result=`cat $Status`
        if [[ $Result = 127 ]]; then
            setenforce="\$MODDIR/busybox setenforce"
        else
            setenforce=setenforce
        fi
fi

if [[ $OTA = 1 ]]; then
cat <<Han >>$jian
now_version=\$(getprop ro.system.build.id)
save_version_file=\$MODDIR/save_version
save_version=\$(cat \$save_version_file)
Han
fi

cat <<Han >>$jian
if [[ ! -f \$START_LOG ]]; then
    echo 0 >"\$START_LOG"
    Frequency2=1
else
    Frequency=\`cat \$START_LOG\`
    Frequency2="\$(expr \$Frequency + 1)"
    echo "\$Frequency2" >"\$START_LOG"
Han
if [[ $OTA = 1 ]]; then
cat <<Han >>$jian
    [[ -f \$save_version_file ]] && echo "\$now_version" > "\$save_version_file"
Han
fi
cat <<Han >>$jian
fi
Han


if [[ $Clean = 1 ]]; then
Choice0="在重启第$Cache次时清除系统包名缓存和关闭SELinux模块尝试第$Cache1次开机操作。"
cat <<Han >>$jian
    if [[ \$Frequency2 -eq $Cache ]]; then
        rm -rf /data/system/package_cache/*
        Statistics
        reboot
Han
else
Choice0=
fi



case "$Compulsory_Rescue" in
Disable_and_recovery | Disable_and_fastboot | Disable_and_9008 | Disable_and_Security_mode)
fa2=$((Frequency+2))
if [[ $Clean = 1 ]]; then
cat <<Han >>$jian
    elif [[ \$Frequency2 -eq $Cache1 ]]; then
        $setenforce 0
        echo 0 >/sys/fs/selinux/enforce
    elif [[ \$Frequency2 -eq $Frequency ]]; then
Han
else
cat <<Han >>$jian
    if [[ \$Frequency2 -eq $Frequency ]]; then
Han
fi
;;

*)
if [[ $Clean = 1 ]]; then
cat <<Han >>$jian
    elif [[ \$Frequency2 -eq $Cache1 ]]; then
        $setenforce 0
        echo 0 >/sys/fs/selinux/enforce
    elif [[ \$Frequency2 -ge $Frequency ]]; then
Han
else
cat <<Han >>$jian
    if [[ \$Frequency2 -ge $Frequency ]]; then
Han
fi
;;
esac


case "$Compulsory_Rescue" in
Disable_and_recovery)
Choice1="禁用所有模块开机一次后仍无法进入系统后最终进入recovery模式，同时删除启动记录次数文件，重新从1开始记录开机次数"
cat <<Han >>$jian
        chmod 000 /data/adb/service.d/* /data/adb/post-fs-data.d/*
        Statistics
        Disable_All_Modules
    elif [[ \$Frequency2 -ge $fa2 ]]; then
        rm -f "\$START_LOG"
        Statistics
        reboot recovery
    fi
Han
;;

Disable_and_fastboot)
Choice1="禁用所有模块开机一次后仍无法进入系统后最终进入FASTBOOT模式，同时删除启动记录次数文件，重新从1开始记录开机次数"
cat <<Han >>$jian
        chmod 000 /data/adb/service.d/* /data/adb/post-fs-data.d/*
        Statistics
        Disable_All_Modules
    elif [[ \$Frequency2 -ge $fa2 ]]; then
        rm -f "\$START_LOG"
        Statistics
        reboot bootloader
    fi
Han
;;

Disable_and_9008)
Choice1="禁用所有模块开机一次后仍无法进入系统后最终进入9008模式，同时删除启动记录次数文件，重新从1开始记录开机次数"
cat <<Han >>$jian
        chmod 000 /data/adb/service.d/* /data/adb/post-fs-data.d/*
        Statistics
        Disable_All_Modules
    elif [[ \$Frequency2 -ge $fa2 ]]; then
        rm -f "\$START_LOG"
        Statistics
        reboot edl
    fi
Han
;;

Disable_and_Security_mode)
Choice1="禁用所有模块开机一次后仍无法进入系统后最终进入安全模式，同时删除启动记录次数文件，重新从1开始记录开机次数"
cat <<Han >>$jian
        chmod 000 /data/adb/service.d/* /data/adb/post-fs-data.d/*
        Statistics
        Disable_All_Modules
    elif [[ \$Frequency2 -ge $fa2 ]]; then
        rm -f "\$START_LOG"
        Statistics
        setprop persist.sys.safemode 1 && reboot
    fi
Han
;;

recovery)
Choice1="进入recovery，同时删除启动记录次数文件，重新从1开始记录开机次数"
cat <<Han >>$jian
        rm -f "\$START_LOG"
        Statistics
        reboot recovery
    fi
Han
;;

Security_mode)
Choice1="进入安全模式，同时删除启动记录次数文件，重新从1开始记录开机次数"
echo "- 在安全模式里只加载系统必要程序，系统之外的第三方程序或文件统统不会启动。需要退出安全模式，只要重启就可以退出"

cat <<Han >>$jian
        Statistics
        setprop persist.sys.safemode 1 && reboot
    fi
Han
;;

fastboot)
Choice1="进入FASTBOOT，同时删除启动记录次数文件，重新从1开始记录开机次数"
cat <<Han >>$jian
        rm -f "\$START_LOG"
        Statistics
        reboot bootloader
    fi
Han
;;

9008)
Choice1="进入9008，同时删除启动记录次数文件，重新从1开始记录开机次数"
cat <<Han >>$jian
        rm -f "\$START_LOG"
        Statistics
        reboot edl
    fi
Han
;;
esac

echo "    exit 0" >>$jian


case "$Pattern" in
Core_model)
Choice2="启用Magisk核心功能模式，请确定Magisk专区 --> 「Magisk 核心功能模式」的开关识别状态是否跟Magisk Manger设置里「Magisk 核心功能模式」一致，如果识别错误请务必联系我修复，否则本模块将会无法开启Magisk核心功能模式！"
echo "- 已选择Magisk核心功能模式，仅启用核心功能，不加载任何模块。MagiskSU 和 MagiskHide 仍会持续运作"
    error "！$Choice2" | sed 's#启用Magisk核心功能模式，##'
;;

Disable)
Choice2="禁用所有模块尝试一次开机"
;;

recovery)
Choice2="进入recovery模式"
;;

Security_mode)
Choice2="进入安全模式"
echo "- 在安全模式里只加载系统必要程序，系统之外的第三方程序或文件统统不会启动。需要退出安全模式，只要重启就可以退出"
;;

9008)
Choice2="进入9008模式"
;;

fastboot)
Choice2="进入FASTBOOT模式"
;;
esac


description="用途：当刷入一些模块后导致无法正常开机，触发已设置的自动救砖操作方式：$Choice0如果再重启第$Frequency次时未开机，强制$Choice1。正常启动卡在第二屏等待$Set_Time分钟后无法开机，自动$Choice2"


cat <<Han >>$jian2
    mv -f \$Module_XinXi.bak \$Module_XinXi && sed -i '32d' "\$0"
    sleep ${Set_Time}m
    if [[ \`getprop init.svc.bootanim\` != "stopped" ]]; then
        Statistics
Han


case "$Pattern" in
Core_model)
    if check_ab_device; then
        File=/data/cache/.disable_magisk
    else
        File=/cache/.disable_magisk
    fi

cat <<Han >>$jian2
            touch "$File"
            reboot
        fi
Han
;;

Disable)
cat <<Han >>$jian2
        Disable_All_Modules
    fi

Han
;;

recovery)
cat <<Han >>$jian2
        reboot recovery
    fi

Han
;;

Security_mode)
cat <<Han >>$jian2
        setprop persist.sys.safemode 1 && reboot
    fi

Han
;;

9008)
cat <<Han >>$jian2
        reboot edl
    fi

Han

;;

fastboot)
cat <<Han >>$jian2
        reboot bootloader
    fi

Han

;;
esac



printf "id=$MODID
name=$name-等待重启中
version=$version
versionCode=$versionCode
author=by Han　|　情非得已c & 快播内部工作人员
description=正在等待重启后，测试Magisk开机脚本是否正常执行，来判断$name是否支持您的机型。如果不支持你的机型名称将一直是：$name-等待重启中" >$Module_XinXi

printf "id=$MODID
name=$name
version=$version
versionCode=$versionCode
author=by Han　|　情非得已c & 快播内部工作人员
description=$description" >$Module_XinXi.bak
[[ -f $Module_XinXi ]] && echo -e "\n- 「$name」模块已创建模块将在下次重启手机生效！"

echo "- 查看「$name」模块描述："
echo "- $description"

# tail -n +34 $jian
# echo 查看service.sh
# tail -n +34 $jian2
