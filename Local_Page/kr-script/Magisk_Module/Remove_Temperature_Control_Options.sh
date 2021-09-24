#本脚本由　by Han | 情非得已c，编写
#应用于搞机助手上


version=1

jian="$Data_Dir/Remove_Temperature_Control_Options.log"
log="$Data_Dir/Remove_Temperature_Control_Options_version.log"

[[ -f $log ]] && user_version=`cat $log` || user_version=0

if [[ $user_version -lt $version || ! -f $jian ]]; then
    find /system /vendor -type f \( -iname "*thermal*" ! -iname "android.*" \) >$jian
    echo $version >$log
fi

if [[ $1 = -d ]]; then
    cat $jian | grep -iv libthermal
else
    cat $jian
fi
