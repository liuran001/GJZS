#本脚本由　by Han | 情非得已c，编写
#应用于搞机助手上


mask -vc
mask $1
xp=edxp

[[ -d $Module ]] && rm -rf $Module
if [[ $xp = lspd ]]; then
    m=LSPosed
    mid=riru_lsposed
    echo "- 应用$m配置"
elif [[ $xp = edxp ]]; then
    m=EDXposed
    if [[ -d $Modules_Dir/riru_edxposed ]]; then
        echo "- 应用$m YAHFA版配置"
        mid=riru_edxposed
    elif [[ -d $Modules_Dir/riru_edxposed_sandhook ]]; then
        echo "- 应用$m SandHook版配置"
        mid=riru_edxposed_sandhook
    fi
fi

MISC_PATH=$(cat /data/adb/edxp/misc_path)
BASE_PATH="/data/misc/$MISC_PATH"
[[ ! -d $BASE_PATH ]] && abort "- 未找到配置路径，请确定您安装了$m"
echo "- 已找到的配置路径"
echo $BASE_PATH

mkdir -p $Module

cat <<Han >$Module_S2
#!`which sh`
#本脚本由搞机助手自动创建
#作者：$author
#请不要试图篡改本脚本，否则一切后果自负，已安装版本：$version($versionCode)
#特别鸣谢Magisk提供服务支持：by topjohnwu


MODDIR=\${0%/*}
export PATH="$PATH0:$ELF4_Path:$MAGISKTMP/.magisk/busybox"
BASE_PATH=$BASE_PATH
[[ ! -d \$BASE_PATH ]] && exit 1

Han



for i in $user; do
    echo "[[ ! -d \$BASE_PATH/$i ]] && mkdir \$BASE_PATH/$i" >>$Module_S2
    echo "mount --bind \$BASE_PATH/0 \$BASE_PATH/$i" >>$Module_S2
done


. $Load $1
description="免双开$m Manager和Xposed模块，使双开应用同步主用户$m模块配置"

printf "id=$id
name=$name
version=$version
versionCode=$versionCode
author=$author
description=$description" >$Module_XinXi
[[ -f $Module_XinXi ]] && echo -e "\n- 「$name」模块已创建模块将在下次重启手机生效！" && CQ
[[ $Immediately = 1 ]] && echo "- 已选择立即生效，开始执行脚本" && sh $Module_S2
