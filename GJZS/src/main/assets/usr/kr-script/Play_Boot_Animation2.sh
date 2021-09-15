#本脚本由　by Han | 情非得已c，编写
#应用于搞机助手上


echo "$Set_Time" >$Data_Dir/Play_Boot_Animation2.log
if [[ -f $Modules_Dir/$1/update ]]; then
    abort -e "！由于您刚刚使用的Magisk模块方式挂载，你需要重启一次使模块生效，才能播放开机动画。\n在重启一次过后、以后就不需要重启可以直接播放开机动画了"
fi
. ./Play_Boot_Animation.sh
