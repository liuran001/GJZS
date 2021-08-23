#本脚本由　by Han | 情非得已c，编写
#应用于搞机助手上


a=`fastboot devices`
if [[ -n "$a" ]]; then
    fastboot getvar all 2>&1 | grep 'partition-type' | sed -r 's/.*partition-type:(.*):.*/\1/g' | sort
else
    echo "！无FASTBOOT设备连接"
fi
