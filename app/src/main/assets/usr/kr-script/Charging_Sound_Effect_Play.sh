#本脚本由　by Han | 情非得已c，编写
#应用于搞机助手上


log="$Data_Dir/Charging_Sound_Effect.log"
lu=$PeiZhi_File/Charging_Sound_Effect

[[ -f $log ]] && user_version=`cat $log` || user_version=0

. $Load Charging_Sound_Effect
if [[ $user_version -lt $versionCode ]]; then
    Choice=1
    . $Load Charging_Sound_Effect
    rm -rf $lu
    mkdir -p $lu
    echo "- 开始解压资源文件"
    unzip -oq "$Download_File" -d $lu
    [[ $? -eq 0 ]] && echo "$versionCode" >$log || abort "！解压失败"
    find $lu -exec chown $APP_USER_ID:$APP_USER_ID {} \; >/dev/null
fi
    [[ $1 = -exit ]] && return 0