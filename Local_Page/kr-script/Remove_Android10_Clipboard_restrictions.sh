#本脚本由　by Han | 情非得已c，编写
#应用于搞机助手上
#脚本代码来源于酷安


QuChu() {
    appops set $1 SYSTEM_ALERT_WINDOW allow
    pm grant $1 android.permission.READ_LOGS
    am force-stop $1
}

[[ -z $package ]] && abort "！未选中应用"

for i in $package; do
    QuChu $i
done
