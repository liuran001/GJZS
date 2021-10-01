#本脚本由　by Han | 情非得已c，编写
#应用于搞机助手上


if [[ -n `which magisk` ]]; then
    s=`find /data/adb/magisk/ -type f 2>/dev/null | wc -l`
    if [[ $s -lt 10 ]]; then
        echo 1
        return 1
    else
        echo 0
        return 0
    fi
fi
