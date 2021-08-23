#本脚本由　by Han | 情非得已c，编写
#应用于搞机助手上


a=0
lu=$GJZS/bootanimation
[[ ! -d $lu ]] && mkdir -p $lu
echo $a >$Status


find $SD_PATH/MIUI/theme/.data/content/bootanimation -type f 2>/dev/null; echo '/system/media/bootanimation.zip' | while read i; do
    md5=`md5sum $i | sed 's/ .*//'`
    f="$lu/bootanimation-$md5.zip"
        if [[ -f "$f" ]]; then
            echo "- `basename $f`文件已存在不在重复提取"
        else
            a=$((a+1))
            echo $a >$Status
            cp -f "$i" "$f"
        fi
done
    a=`cat $Status`
    echo
    echo
    echo "- 已提取出$a个开机动画文件"
    echo "- 文件保存路径：$lu"
