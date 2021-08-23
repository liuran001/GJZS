#本脚本由　by Han | 情非得已c，编写
#应用于搞机助手上


model2=`getprop ro.product.model`
device2=`getprop ro.product.device`
brand2=`getprop ro.product.brand`
version2=`getprop ro.build.version.incremental`
Android_V=`getprop ro.build.version.release`
x=`wm size | sed 's/.*x//'`
DL=`dumpsys battery | grep "status: 2"`

bd() {
printf `getprop ro.build.version.security_patch
getprop ro.vendor.build.security_patch` | head -n 1
}

rt() {
    if $Have_ROOT; then
        echo "已ROOT"
        echo
        echo "su文件：`which -a su`"
    else
        echo "未ROOT"
    fi
}

ab() {
    . $ShellScript/Switch_ab_partition.sh -c
    [[ $? -eq 0 ]] && echo "是，当前使用的是$SLOT系统" || echo "否"
}

bb() {
    (
    PATH="$PATH0"
    which -a busybox
    [[ $? -ne 0 ]] && echo "未找到"
    )
}

tb() {
    (
    PATH="$PATH0"
    which -a toybox
    [[ $? -ne 0 ]] && echo "未找到"
    )
}

fingerprint() {
    a=`getprop ro.build.fingerprint`
    if [[ -n "$a" ]]; then
        echo "$a"
    else
        echo "不支持指纹"
    fi
}

sl() {
    if [[ `getenforce` = Enforcing ]]; then
        echo "开启（Enforcing）"
    else
        echo "关闭（Permissive）"
    fi
}


echo "
当前手机型号：$model2

ROOT状态：`rt`

系统busybox位置：`bb`

系统toybox位置：`tb`

SELinux状态：`sl`

安卓版本：$Android_V

安卓SDK：$SDK

安卓安全补丁日期：`bd`

品牌：$brand2

设备代号：$device2

ROM版本号：$version2

ROM编译日期：`getprop ro.build.date`

设备CPU架构为：$(getprop ro.product.cpu.abi)

A/B设备：`ab`

当前屏幕dpi值：`wm density|sed -e 's/Physical density/默认值/' -e 's/Override density/当前设置的值/'`

屏幕密度：`getprop ro.sf.lcd_density`

屏幕分辨率：`wm size | sed 's/.*: //'`

屏幕宽高比：`awk "BEGIN{print $x/120}"`:9

RAM内存：`free -b|awk '/^Mem/ {print $2/1000000}'`m

`df -h /system | awk 'END{print "/system储存信息：总大小："$2"、已用："$3"、剩余："$4"、使用率："$5}'`

`df -h /data | awk 'END{print "内部储存信息：总大小："$2"、已用："$3"、剩余："$4"、使用率："$5}'`

当前电量：`Power`
"
if [[ -n $DL ]]; then
    echo "充电状态：正在充电"
else
    echo "充电状态：未充电"
fi
echo "
指纹：`fingerprint`

主板ID：`cat /sys/devices/soc0/serial_number 2>/dev/null`

设备ID：`settings get secure android_id`

已运行时间：`uptime`

内核类型：`uname -s`

内核架构：`uname -m`

内核版本：`uname -r`

内核版本发布时间：`uname -v`
"


# CPU=`cat /proc/cpuinfo | grep SDM | sed 's/.*SDM//'`
# CPU2=`getprop ro.product.board | sed 's/[a-zA-Z]//g'`
# CPU3=${CPU:=$CPU2}
# CPU4=`getprop | grep platform`
# CPU5=${CPU4:-未知}
# CPU型号：${CPU3:-$CPU5}

# echo -n "BL锁状态："
# a=`getprop ro.boot.flash.locked`
# b=`getprop ro.boot.verifiedbootstate`
    # if [[ "$a" = 0 && "$b" = orange ]]; then
        # echo "已解锁"
    # elif [[ "$a" = 1 && "$b" = green ]]; then
        # echo "未解锁"
    # fi
# echo "
# 
#当前电量：`dumpsys battery|awk '/level/{print $2}'`%
