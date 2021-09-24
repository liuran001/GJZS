#本脚本由　by Han | 情非得已c，编写
#应用于搞机助手上


mask -vc
mask $1

[[ -d $Module ]] && rm -rf $Module
echo "已选择移除的温控文件"

O_IFS="$IFS"
IFS=$'\n'
for i in $thermal; do
    echo "$i"
    mktouch "$Module$i"
done
IFS="$O_IFS"

        if [[ $Module/vendor ]]; then
            mkdir -p $Module/system
            mv -f $Module/vendor $Module/system/vendor
        fi

. $Load $1
printf "id=$id
name=$name
version=$version
versionCode=$versionCode
author=$author
description=$description" >$Module_XinXi
[[ -f $Module_XinXi ]] && echo -e "\n- 「$name」模块已创建模块将在下次重启手机生效！" && CQ
