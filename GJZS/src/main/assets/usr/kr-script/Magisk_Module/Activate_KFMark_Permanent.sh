#本脚本由　by Han | 情非得已c，编写
#应用于搞机助手上


Choice=1
mask -vc
mask $1
user_versionCode=$versionCode
. $Load $1
echo
echo
echo "正在安装$name，请骚等……"


if [[ -d $Module && $user_versionCode -ge $versionCode ]]; then
    echo "- 已安装了最新版本：${name}-$version（$versionCode），不再重复安装。"
else
    [[ -d $Module && $user_user_versionCode -lt $versionCode ]] && echo "正在更新……" || echo "正在安装……"
    
    [[ ! -d $Module ]] && mkdir -p $Module
    cp -f "$Download_File" $Module/$id

cat <<Han >$Module_S2
#本模块由「搞机助手」创建
#特别鸣谢：by：topjohnwu & Magisk Manager提供服务支持

chmod 755 $Module/$id
$Module/$id
Han

printf "id=$id
name=$name
version=$version
versionCode=$versionCode
author=$author
description=用途：每次重启手机自动激活快否，由cn.endureblaze.activatebenchaf & 快否激活器v$version提供服务器支持" >$Module_XinXi

    if [[ -f $Module_XinXi && -f $Module_S2 ]]; then
        echo "「$name」Magisk模块创建完成，模块将在下次重启生效"
        chmod 755 $Module/$id
    fi
fi
CQ