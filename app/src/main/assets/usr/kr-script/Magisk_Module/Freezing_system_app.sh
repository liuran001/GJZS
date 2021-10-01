#本脚本由　by Han | 情非得已c，编写
#应用于搞机助手上


mask $1

[[ -z $package && -z $package2 ]] && abort "！应用都不选冻结空气？"
rm -rf $Module "$Data_Dir/Freezing_system_applist.log"
for i in $package $package2; do
lu=`pm path $i | cut -f2 -d ':'`


case $lu in
    /product/* | /vendor/*)
        lu="/system$lu"
    ;;
esac


if [[ $lu = /data/app/$i* ]]; then
    error "！$i应用无法冻结，因为已被更新了"
    echo "文件路径：$lu"
    echo "- 如果需要冻结请卸载更新还原到初始版本"
    echo
    continue
fi
echo "- 开始冻结$i"
echo $i >>"$Data_Dir/Freezing_system_applist.log"
mktouch "$Module/$lu"
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

cp -f "$Data_Dir/Freezing_system_applist.log" "$GJZS/Freezing_system_applist.log"
echo "- 冻结完成，冻结列表也保存到：$GJZS/Freezing_system_applist.log"
