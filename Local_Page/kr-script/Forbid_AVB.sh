#本脚本由　by Han | 情非得已c，编写
#应用于搞机助手上


[[ $Option = None ]] && return 0
[[ -z `od -where` ]] && abort "！未找到od命令"
echo -n "- " 
while read line; do
    [[ -z `strings $line` ]] && continue
    typeset -u jz
    jz=`od -w16 -An -tx1 "$line" | grep -i -B 2 '61 76 62 74 6f 6f 6c 20' | tr -d '[:space:]' | egrep -oi '0000000000000000000000..00000000617662746f6f6c20'`
    [[ -z "$jz" ]] && continue
    echo -n ". "
    magiskboot hexpatch "$line" $jz 00000000000000000000000${Option}00000000617662746F6F6C20 &>/dev/null || abort "！失败"
done <<Han
`sh ./Block_Device_Name.sh | grep '/vbmeta' | sed 's/|.*//g'`
Han
echo
echo "- 完成"