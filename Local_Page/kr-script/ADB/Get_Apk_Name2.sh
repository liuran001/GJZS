#本脚本由　by Han | 情非得已c，编写
#应用于搞机助手上


Name() {
    ApkName=
    [[ -z $ApkName ]] && ApkName=`curl -s "http://app.mi.com/details?id=$i" | grep -F '<title>' | sed 's/-小米.*//; s/.*>//'`
    [[ -z $ApkName ]] && ApkName=`curl -s "https://www.coolapk.com/apk/$i" | grep -F '<title>' | sed 's/(.*//; s/.*>//'`
    $VPN && [[ -z $ApkName ]] && ApkName=`(curl -sL -H 'accept-language: zh,en;q=0.9,zh-CN;q=0.8' "https://play.google.com/store/apps/details?id=$1" | sed -n 's/.*id="main-title">//p' | sed 's/ - Google Play.*//')`
    [[ -z $ApkName ]] && ApkName=`curl -s https://repo.xposed.info/module/$1 | sed -n 's/<title>//p' | sed 's/ | .*//; s/.* not found.*//'`
    if [[ -n $ApkName ]]; then
        echo "$1=$ApkName"
        echo "$1|$ApkName" >>"$APK_Name_list2"
    else
        error "！$1匹配对应名称失败"
    fi
}


FIFO=$TMPDIR/tmp
rm -rf "$FIFO" "$APK_Name_list2"
mkfifo "$FIFO"
exec 6<>"$FIFO"
    for o in `seq "$Number_of_threads"`;do
        echo 0
    done >&6

echo "- 开始访问www.google.com查看是否已开启VPN"
curl -l -m 5 "https://play.google.com" &>/dev/null
[[ $? = 0 ]] && VPN=true || VPN=false
$VPN && echo "- 已检测有VPN" || echo "- 没有VPN"
echo "- 正在使用$Number_of_threads个线程量联网匹配包名对应的应用名称，请骚等……"
echo


for i in `adb2 -s ./Get_Package_Name-3.sh`; do
{
    Name $i
  echo 0 >&6
} &
done
wait
echo -e "\n- 匹配完成。"
exec 6>&-
