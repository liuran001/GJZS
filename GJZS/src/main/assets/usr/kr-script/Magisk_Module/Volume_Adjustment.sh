#本脚本由　by Han | 情非得已c，编写
#应用于搞机助手上


Rank=${Rank1:=$Rank2}
. $Load $1
MODPATH=$Modules_Dir/$id
MODPROP=$MODPATH/module.prop
x=false


Clean() {
    rm -rf $MODPATH
    mkdir -p $MODPATH
}

ui_print "- 开始安装 $name-$version($versionCode)"
ui_print "- 安装目录：$MODPATH"
ui_print "- 模块作者：$author"
ui_print "- Powered by Magisk & topjohnwu"

echo 0 >$Status
find $Modules_Dir -name system.prop | while read i; do
    grep '^ro.config.media_vol_steps=' "$i"
    if [[ $? -eq 0 ]]; then
        echo "- 已检测到${i%/*}模块存在该参数，不再创建新的$name模块"
        echo "- 开始设置音量级别为$Rank"
        sed -i "/^ro.config.media_vol_steps=/c ro.config.media_vol_steps=$Rank" "$i"
        echo 1 >$Status
    fi
done

result=`cat $Status`
if [[ $result -eq 1 ]]; then
    echo "- 修改完毕，重启手机后生效"
    CQ
    exit 0
fi
Clean

cat <<Han >$MODPATH/system.prop
#Magisk模块作者  by：$author
#本模块由「搞机助手」创建
#特别鸣谢：by：topjohnwu & Magisk Manager提供服务支持

ro.config.media_vol_steps=$Rank
Han


cat <<Han >$MODPROP
id=$id
name=$name
version=$version
versionCode=$versionCode
author=$author
description=将默认的按下音量键15次后放大至最大音量，改为$Rank次，我只在小米上测试OK，其它机型自己测试
Han

test -f $MODPROP && ui_print "- 模块安装完成" || abort "！模块安装失败"
CQ
exit 0
