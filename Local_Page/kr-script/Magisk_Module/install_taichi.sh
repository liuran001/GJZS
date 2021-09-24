#本脚本由　by Han | 情非得已c，编写
#应用于搞机助手上


exp2=$exp
exp=0
sh $install_MOD $Compatible $Error None 1 $1

Choice=0
exp=$exp2
if [[ $exp -eq 1 ]]; then
. $Load $1
File="$Download_File"
    if [[ -f $File ]]; then
        echo "开始安装太极-$expversion.apk……"
        sh $ShellScript/install_apk.sh
    else
        error "下载太极-$expversion.apk失败❌"
    fi
fi