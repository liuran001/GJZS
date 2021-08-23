#本脚本由　by Han | 情非得已c，编写
#应用于搞机助手上


echo "ChongQi=$ChongQi" > $Data_Dir/Show_touch_Option.log
echo "Show_touch_Option=$Show_touch_Option" >> $Data_Dir/Show_touch_Option.log

mask -vc
Choice=1
id=Show_touch
. $Load $id
name=`sed -n "s/${Show_touch_Option}|//p" $ShellScript/Magisk_Module/Show_touch_Option.log`触摸点
version=$version
versionCode=$versionCode
author="$author"
description="修改显示点按操作视觉反馈触摸点，当前已选择：$name"
MODPATH=$Modules_Dir/$id
MODPROP="$MODPATH"/module.prop
TMPDIR="$TMPDIR/$id"
jian=`pm path android | cut -f2 -d ':'`
jian2="$MODPATH$jian"
jian3="$MODPATH/pointer_spot_touch_icon.xml"

Clean() {
    rm -rf "$MODPATH"
    mkdir -p `dirname $jian2`
}

abort() {
    echo "$@" 1>&2
    rm -rf "$MODPROP" "$TMPDIR"
    sleep 3
    exit 1
}

[[ -z `which zip` ]] && abort "！缺少zip命令无法安装"
[[ ! -f $jian ]] && abort "！未找到android系统路径：$jian"
ui_print "- 开始安装 $name-$version($versionCode)"
ui_print "- 安装目录：$MODPATH"
ui_print "- 已选择：$name"
ui_print "- 模块作者：$author"
ui_print "- 模块描述：$description"
ui_print
ui_print "- Powered by Magisk & topjohnwu"


Clean

cat <<Han >$MODPROP
id=$id
name=$name
version=$version
versionCode=$versionCode
author=$author
description=$description
Han


cp -f $jian $jian2
[[ ! -f $jian2 ]] && abort "！复制 \"$jian\" 文件失败"


ui_print "- 开始提取文件……"
rm -rf "$TMPDIR" &>/dev/null
mkdir -p "$TMPDIR"
cd "$TMPDIR"
[[ $? -ne 0 ]] && abort "！创建目录失败了"

f=`unzip -l "$jian2" | awk '/pointer_spot_touch_icon.xml/{a=$NF} END{print a}'`
if [[ -n "$f" ]]; then
    unzip -l "$jian2" | egrep 'pointer_spot_down_icon.xml|/pointer_spot_up_icon.xml|/pointer_spot_touch.png' 1>/dev/null
    if [[ $? -ne 0 ]]; then
        echo "！未找到布局文件"
    else
        unzip -ojq "$jian2" "$f" -d "$MODPATH"
        [[ ! -f "$jian3" ]] && abort -e "！提取布局文件出错，错误代码：\n`unzip --help`"
        unzip -o "$jian2" 'res/*/pointer_spot_down_icon.xml' 'res/*/pointer_spot_up_icon.xml' 'res/*/pointer_spot_touch.png' -d "$TMPDIR" &>/dev/null
        echo "- 开始处理布局文件……"
        find "$TMPDIR" -name '*.xml' -type f | while read xml; do
            cp -f "$jian3" "$xml"
        done
    fi
fi
        ls $TMPDIR/res/*/pointer_spot_touch.png &>/dev/null || abort -e "！未提取到图片文件"
        echo "- 替换图片文件……"
        unzip -o "$Download_File" "$Show_touch_Option.png" -d "$MODPATH" &>/dev/null
        find "$TMPDIR" -name '*.png' -type f | while read png; do
            cp -f "$MODPATH/$Show_touch_Option.png" "$png"
        done
        zip -rq "$jian2" ./*
        [[ $? -ne 0 ]] && abort "！打包$jian2失败了"
        rm -rf "$MODPATH/$Show_touch_Option.png" "$jian3" "$TMPDIR"
        test -f $MODPROP && ui_print "- 模块安装完成" || abort "！模块安装失败"
        CQ