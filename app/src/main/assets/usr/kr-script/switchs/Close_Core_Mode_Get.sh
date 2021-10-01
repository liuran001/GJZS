#本脚本由　by Han | 情非得已c，编写
#应用于搞机助手上


. $ShellScript/support/Close_Core_Mode.sh &>/dev/null
if check_ab_device; then
    File=/data/cache/.disable_magisk
else
    File=/cache/.disable_magisk
fi


if [[ -f $File ]]; then
    echo 1
else
    echo 0
fi