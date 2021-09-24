#本脚本由　by Han | 情非得已c，编写
#应用于搞机助手上
#脚本代码来源于酷安


Add() {
    echo "- 已添加包名：$1"
    dumpsys deviceidle whitelist +$1
}

[[ -z $package ]] && abort "！未选中应用"

for i in $package; do
    Add $i
done

