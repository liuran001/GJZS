#本脚本由　by Han | 情非得已c，编写
#应用于搞机助手上


mask -vc
Choice=1
mask $1
. $Load $1

APK=/system/framework/framework-res.apk
ZIPFILE="$Download_File"
bak_File=${PeiZhi_File}/framework-res.apk
Module_File=${Module}${APK}
Module_Dir=${Module_File%/*}

if [[ ! -f $APK ]]; then
    abort "未找到$APK文件无法安装过渡动画"
elif [[ ! -f $bak_File && ! -f $Module_File ]]; then
    echo "开始备份源文件用于切换$2"
    cp -f $APK $PeiZhi_File
elif [[ ! -f $bak_File && -f $Module_File ]]; then
    abort "！原备份文件不存在，请先卸载$2模块重启手机再来安装"
fi

if [[ -f "$ZIPFILE" ]]; then
    echo "开始安装……"
        if [[ -d $Module_Dir ]]; then
    rm -rf $Module_Dir
    mkdir -p $Module_Dir
        else
    mkdir -p $Module_Dir
        fi
    
    [[ -d $Script_Dir ]] && rm -rf $Script_Dir &>/dev/null
    [[ ! -d $Script_Dir ]] && mkdir -p $Script_Dir
    unzip -oq "$ZIPFILE" "$XuanZe/*" -d $Script_Dir
    
    if [[ -d $Script_Dir/$XuanZe ]]; then
        cp -f $bak_File $Module_File
        cd $Script_Dir/$XuanZe
        echo "开始添加$XuanZe $2文件……"
        zip -rq $Module_File ./*
    else
        abort "！解压文件失败"
    fi

printf "id=$id
name=$name
version=$version
versionCode=$versionCode
author=$author
description=原理：通过修改Android 系统，修改过渡动画，已选择$XuanZe过渡动画（$XuanZe）" >$Module_XinXi
[[ -f $Module_File ]] && echo "- $name模块已创建模块将在下次重启手机生效！"

CQ
else
    echo "文件不存在无法安装"
fi
