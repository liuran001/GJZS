mask -vc
mask $1

[[ -d $Module ]] && rm -rf $Module
echo "正在移除温控"

[[ $VendorJson = 1 ]] && {
    for i in `find "/vendor" -name "*thermal*.json" -o -name "*thermal*.conf" -type f`; do
        echo "$i" | fgrep -iq 'android.' && continue
        echo - $i
        mktouch "$Module/system/$i"
    done
}

[[ $Vendor32 = 1 ]] && {
    for o in `find "/vendor" -name "*thermal*" ! -name "*thermal*.json" ! -name "*thermal*.conf" -type f`; do
        echo "$o" | fgrep -iq 'android.' && continue
        echo "$o" | fgrep -iq 'mi_thermald' && continue
        if [[ $Vendor64 == 0 ]];then
            echo "$o" | fgrep -iq 'lib64' && continue
        fi
        echo - $o
        mktouch "$Module/system/$o"
    done
}

[[ $Perf = 1 ]] && {
    for a in `find "/vendor/etc/perf" -name "*.xml" -type f`; do
        echo "$a" | fgrep -iq 'android.' && continue
        echo - $a
        mktouch "$Module/system/$a"
    done
    for l in `find "/vendor/etc/perf" -name "perf*" -type f`; do
        echo "$l" | fgrep -iq 'android.' && continue
        echo - $l
        mktouch "$Module/system/$l"
    done
    for b in `find "/vendor/etc/perf" -name "*conf" -type f`; do
        echo "$b" | fgrep -iq 'android.' && continue
        echo - $b
        mktouch "$Module/system/$b"
    done
}

[[ $MIUICloudThermal = 1 ]] && {
    if [ -d "/data/thermal" ];then
        rm -rf /data/thermal
        touch /data/thermal
        /data/adb/magisk/busybox chattr +i  /data/thermal
    else
        echo "MIUI云控的/data/thermal已经被移除了哦"
    fi
    if [ -d "/data/vendor/thermal" ];then
    rm -rf /data/vendor/thermal
    touch /data/vendor/thermal
    /data/adb/magisk/busybox chattr +i  /data/vendor/thermal
    else
        echo "MIUI云控的/data/vendor/thermal已经被移除了哦"
    fi
}

mktouch "$Module/uninstall.sh"
echo "/data/adb/magisk/busybox chattr -i  /data/thermal" >> "$Module/uninstall.sh"
echo "/data/adb/magisk/busybox chattr -i  /data/vendor/thermal" >> "$Module/uninstall.sh"

. $Load $1
module_prop
[[ -f $Module_XinXi ]] && echo -e "\n- 「$name」模块已创建" && CQ
