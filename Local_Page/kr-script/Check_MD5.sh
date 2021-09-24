#本脚本由　by Han | 情非得已c，编写
#应用于搞机助手上


[[ ! -f "$File" ]] && abort "！$File文件不存在无法查看md5"
echo "- 正在校验md5，请骚等……"
echo
MD52=`md5sum "$File" | sed 's/ .*//g'`

if [[ -z $MD5 ]]; then
    echo "$MD52"
elif [[ -n $MD5 ]]; then
    echo "- 当前输入的md5为：$MD5"
    echo "- `basename $File`文件md5：$MD52"
    [[ "$MD52" = "$MD5" ]] && echo "- md5校验成功" || abort "！校验失败"
fi