#本脚本由　by Han | 情非得已c，编写
#应用于搞机助手上


[[ -z "$3" ]] && YinYue="$PeiZhi_File/mute.ogg"

if [[ $1 = -system ]]; then
    Mount_system
    if [[ $state = 1 ]]; then
        mv $audio/$2 $audio/${2}.bak
        cp -f "$YinYue" $audio/$2
    else
        mv $audio/${2}.bak $audio/$2
    fi
    set_perm $audio/$2 0 0 644
    Unload
elif [[ $1 = -mask ]]; then
    mask -vc
    echo "- 已通过Magisk模块方式修改"
    echo "- 查找是否已安装冲突模块"
    find $Modules_Dir -name $2 | while read i; do
        modid=`echo "$i" | cut -f5 -d '/'`
        [[ "$modid" = Han.GJZS-MIUI ]] && continue
        Module="$Modules_Dir/$modid"
        Module_Disable="$Module/disable"
        Module_Remove="$Module/remove"
        modname=`grep_prop name "$Module/module.prop"`
            if [[ ! -f "$Module_Disable" || ! -f "$Module_Remove" ]]; then
                abort "- 已检测到「$modname」模块修改了该音频文件，导致冲突，请卸载/禁用后再来\n模块路径：$Modules_Dir/$modid"
            fi
    done
    echo "- 安装中……"
    id=Han.GJZS-MIUI
    name=搞机助手MIUI专区扩展模块
    version='v1'
    versionCode=1
    author='by：Han | 情非得已c'
    description='搞机助手MIUI专区扩展模块，在无法修改system的情况下，利用Magisk修改一些系统参数'
    audio="/system/media/audio/ui"
    MODPATH=$Modules_Dir/$id
    MODPROP=$MODPATH/module.prop
    MODFILE="$MODPATH$audio/$2"
        if [[ $state = 1 ]]; then
            [[ ! -d "$$MODPATH$audio" ]] && mkdir -p "$MODPATH$audio"
            cp -f "$YinYue" $MODFILE
            set_perm $MODFILE 0 0 644
cat <<Han >$MODPROP
id=$id
name=$name
version=$version
versionCode=$versionCode
author=$author
description=$description
Han
            test -f $MODPROP && ui_print "- 模块安装完成，重启后生效" || abort "！模块安装失败"
        else
            cp -ap $MODFILE $audio/$2 &>/dev/null
            rm -rf $MODFILE
            rmdir -p $MODPATH$audio &>/dev/null
            [[ ! -d $MODPATH/system ]] && rm -rf $MODPATH
            echo "- 已恢复默认，重启手机后生效"
        fi
fi
sleep 3
