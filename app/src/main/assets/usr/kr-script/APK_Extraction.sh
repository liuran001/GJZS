#本脚本由　by Han | 情非得已c，编写
#应用于搞机助手上


name=$Data_Dir/APK_Name.log
log=$Data_Dir/APK_Extraction_Format.log

echo "luj=$luj" >$log
echo "Format=$Format" >>$log
[[ -z "$package" ]] && abort "！应用都不选提取空气？"

[[ ! -f $name ]] && sh ./Get_Apk_Name.sh 1>/dev/null && sleep 3
[[ ! -s $name ]] && abort "！获取包名对应的应用名称出错" || . $name
[[ ! -d $luj ]] && mkdir -p "$luj"

for i in $package; do
    ii=\$${i//./_}
    A=`eval echo "$ii"`
    V=`pm dump $i | grep -m 1 versionName | sed -n 's/.*=//p'`
    P="$i"
    C=`pm list packages --show-versioncode $i | sed -n "s/.*$i .*://p"`
    apk=`pm path $i | sed 's/.*://g'`
    Suffix=.${apk##*.}
    tf=`eval echo "$Format"`
    echo "- 开始提取$tf$Suffix"
    cp -f "$apk" "$luj/$tf.$Suffix"
    echo
done
