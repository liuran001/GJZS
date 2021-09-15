#本脚本由　by Han | 情非得已c，编写
#应用于搞机助手上


. $ShellScript/Magisk_Manager_Package_name.sh
[[ -z $Magisk_Manager ]] && abort "！未找到Magisk包名"
. ./Get_Package_Name-s.sh | grep -wq "$Magisk_Manager" || abort -e "！Magisk 不是系统应用，且进入Magisk未提示\n${description2:27}"

if [[ "$1" = -Direct ]]; then
    echo "- 提取应用"
    apk=`pm path $i | sed 's/.*://g'`
    File="$Script_Dir/$Magisk_Manager.apk"
    cp -f "$apk" "$File"
    echo "- 开始卸载重装还原为用户应用。"
    pm uninstall --user 0 $Magisk_Manager
    . $ShellScript/install_apk.sh
    echo "- 修复完成，打开Magisk即可，不需要重启"
    exit 0
fi

. $Load $1
mask $1
lu=`pm path $Magisk_Manager | cut -f2 -d ':'`


case $lu in
    /product/* | /vendor/*)
        lu="/system$lu"
    ;;
    /data/*)
        pm uninstall $Magisk_Manager
        lu=`pm path $Magisk_Manager | cut -f2 -d ':'`
    ;;
esac

case $lu in
    /product/* | /vendor/*)
        lu="/system$lu"
    ;;
    /data/*)
        abort "！卸载Magisk失败，请手动卸载Magisk"
    ;;
esac

mktouch "$Module/$lu"

cat <<Han >$Module_XinXi
id=$id
name=$name
version=$version
versionCode=$versionCode
author=$author
description=$description2
Han

cat <<Han >$Module_us
#!`which sh`

rm -rf /data/system/package_cache/*/*$Magisk_Manager*
Han
sh $Module_us
. ./install_App_Store_File.sh com.topjohnwu.magisk
CQ
