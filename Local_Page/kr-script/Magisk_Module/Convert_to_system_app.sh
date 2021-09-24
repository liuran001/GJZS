#本脚本由　by Han | 情非得已c，编写
#应用于搞机助手上


mask $1
dir=$Module/system/$Location
log=$Data_Dir/Convert_to_system_app.log


if [[ -n "$Delete" ]]; then
    for o in $Delete; do
        echo "- 删除$o系统应用模块"
        rm -rf $Module/system/*app/$o* 
        sed -i "/^$o$/d" $log
    done
    exit 0
fi

[[ -z "$package" ]] && abort "！请选择应用"

if [[ $Retain -eq 0 ]]; then
    rm -rf $Module
fi

mkdir -p $dir

for i in $package; do
    echo "- 开始将$i转换为系统应用"
    lu=`pm path $i | cut -f2 -d ':'`
    lu2=`dirname $lu`
    cp -rf "$lu2" "$dir"
    echo $i >>$log
done

. $Load $1
cat <<Han >$Module_XinXi
id=$id
name=$name
version=$version
versionCode=$versionCode
author=$author
description=$description
Han

test -f $Module_XinXi && echo "- $name模块创建完成" || { rm -rf $Module; abort "！$name模块创建失败"; }