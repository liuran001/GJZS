#本脚本由　by Han | 情非得已c，编写
#应用于搞机助手上


case $Scheme in
1)
echo "- 开始检验状态"
AVBf=`tail -c 2k "$img_File" | grep "AVBf" 2>/dev/null`
[[ -z "$AVBf" ]] && abort "- 没有AVB 2.0引导，无法注入补丁"
pReAVBf=`tail -c 2k "$img_File" | grep "pReAVBf" 2>/dev/null`
[[ -z "$pReAVBf" ]] && abort "- 已安装补丁，无需重复注入"


ui_print "- 开始修补启动注入补丁以防止twrp被覆盖"

tmp=$TMPDIR/boot.img
cp -f "$img_File" "$tmp"
magiskboot hexpatch "$tmp" 0000000041564266000000 0070526541564266000000 || abort "注入失败"
    for i in $Subarea; do
        echo "- 刷入刷写$i分区"
        fastboot flash "$i" "$tmp"
    done
;;

2)
    ui_print "- 开始签名boot.img以防止twrp被覆盖"
    tmp=$TMPDIR/boot.img
    File="$img_File"
    . $ShellScript/MultiFunction.sh Magisk -sign "$img_File" "$tmp"
    for i in $Subarea; do
        echo "- 刷入刷写$i分区"
        fastboot flash "$i" "$tmp"
    done
;;
esac
rm -f "$tmp"
