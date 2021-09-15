#本脚本由　by Han | 情非得已c，编写
#应用于搞机助手上
# 1A=1000000微安μA


battery=/sys/class/power_supply

view() {
    cat $battery/$1 2>/dev/null
}

Convert_V() {
    r=
    r=`view "$1" | sed -r "s/.{6}$/.&$2V(伏)/"`
    [[ -n $r ]] && echo "$r" || echo "未知"
}

Convert_A() {
    r=
    r=`view "$1" | sed -r "s/.{3}$/.&mA(毫安)/"`
    [[ -n $r ]] && echo "$r" || echo "未知"
}

Convert_C() {
    r=`view "$1" | sed 's/^../&./; s/.$/&℃/'`
    [[ -n $r ]] && echo "$r" || echo "未知"
}

Power() {
    echo "`cat $battery/battery/capacity`%"
}

cwa() {
    cv=`view usb/voltage_now`
    ca=`view usb/input_current_now`
    cw=`expr $cv \* $ca`
    cw1=`expr $cw / 1000000000000`
    [[ -z "$cw1" ]] && cw1=0
    cw2=`expr $cw % 1000000000000`
    cw3="$cw1.$cw2w(瓦)"
echo "
充电协议：`view usb/type | sed 's/_HVDCP_3/ 高通QC3.0/'`
充电温度：`Convert_C usb/connector_temp`
充电电压：`Convert_V usb/voltage_now`
充电电流：`Convert_A usb/input_current_now`
充电功率：$cw3
"
}


echo "- 参数1"
dumpsys battery | sed -e 's/Current Battery Service state.*/当前电池状态/' \
-e 's/AC powered/交流电源/' \
-e 's/USB powered/USB电源/' \
-e 's/Wireless powered/无线电源/' \
-e 's/Max charging current/最大充电电流/' \
-e 's/Max charging voltage/最大充电电压/' \
-re 's/(Charge counter)(.*)(.{3}$)/电池剩余容量\2.\3mA毫安/' \
-e 's/status: 2/电池状态: 充电中/' \
-e 's/status: .*/电池状态: 未充电/' \
-e 's/health: 2/电池健康状态: 很好/' \
-e 's/health/电池健康状态/' \
-e 's/present./电池是否已安装: /' \
-e 's/level/当前电量/' \
-e 's/scale/最大电量/' \
-e 's/voltage/当前电压/' \
-e 's/(temperature)(.*)(.$)/电池温度\2.\3℃/' \
-e 's/current now/电流值，负数表示正在充电/' \
-e 's/technology/电池类型/' \
-e 's/true/真/g' \
-e 's/false/假/g'


[[ ! -d $battery ]] && exit 0

bs=`view battery/status`
bv=`view battery/voltage_now`
bma=`view battery/current_now`
bw=`expr $bv \* $bma`
bw1=`expr $bw / 1000000000000`
[[ -z "$bw" ]] && bw1=0
bw2=`expr $bw % 1000000000000`
bw3="$bw1.$bw2w(瓦)"

echo "

- 参数2
当前电量：`Power`
出厂设计电池容量：`Convert_A bms/charge_full_design`
充满电后的实际容量：`Convert_A battery/charge_full`
电池剩余容量：`Convert_A battery/charge_counter`
当前电池状态：`echo $bs | sed 's/Discharging/未充电/; s/Charging/充电中/; s/Full/已充满/'`
当前电池温度：`Convert_C battery/temp`
电池周期充电次数：`view battery/cycle_count`次
电池最大电压时：`Convert_V battery/voltage_max`
电池最小电压时：`Convert_V bms/voltage_min`
电池放电电压：`Convert_V battery/voltage_now`
电池放电电流：`Convert_A battery/current_now`
电池放电功率：$bw3

注意：如果在充电的情况下，获取得到的放电电流是不准确的，此时显示的是，充电电流 - 放电电流
"


if [[ $bs = Charging || $bs = Full ]]; then
    echo "- 充电时的参数3"
    sleep 2
    if [[ $Cycle = 1 ]]; then
        [[ -z $Rate ]] && error "！未设置刷新间隔，已默认设置为1秒" && Rate=1
        while true; do
            cwa
            sleep $Rate
        done
    else
        cwa
    fi
fi

echo "- 数据仅供参考"
