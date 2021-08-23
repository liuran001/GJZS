#本脚本由　by Han | 情非得已c，编写
#应用于搞机助手上


var(){
    echo "$line" | sed "s/^$1=//g"
}

XML() {
    fgrep 'string name' "$xml" | sed 's/&quot;/"/g; s/\\\//\//g; s/","/\n/g; s/":"/="/g' | sed 's/$/"/g' | sed -n '/^md5=/p; s/^name=/\n\n\n\n\n\nname=/gp; /^version=/p; /^codebase=/p; /^filename=/p; /^filesize=/p'
    echo
}

c=false
xml=/data/data/com.android.updater/shared_prefs/version_json.xml
File="${File:="$File2"}"
echo "- 正在校验，请骚等……"
if [[ -n $MD5 ]]; then
    echo "- 当前输入的md5为：$MD5"
elif [[ -z $MD5 ]]; then
    [[ ! -f $File ]] && abort "！$File文件不存在无法校验"
    MD5=`md5sum $File | sed 's/ .*//g'`
    echo "- $File文件md5为：$MD5"
fi
    echo "- 开始校验"

XML | grep -q "^md5=\"$MD5\"$"
    if [[ $? = 0 ]]; then
        md5_now=`XML | sed -n "/$MD5/=" | head -n 1`
        start=$((md5_now-6))
        end=$((md5_now+6))
        eval $(XML | sed -n "$start,${end}p")
        echo "- md5检验成功"
        echo
        echo -e "符合的ROM为:$name\nMD5：$md5\n安卓版本：$codebase\n文件大小：$filesize\nROM版本：$version"
        c=true
    fi

$c || abort -e "\n！md5检验失败"