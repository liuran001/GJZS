#本脚本由　by Han | 情非得已c，编写
#应用于搞机助手上

if [[ $1 = -system ]]; then
    Mount_system
    File="$system/etc/hosts"
    tf=$TMPDIR/hosts
    cp -f $File $tf
        if [[ $state = 1 ]]; then
            echo '127.0.0.1 update.miui.com' >>$tf
            echo "- [MIUI 更新检查] 已禁用！"
        else
            sed -i '/update.miui.com/d' $tf
        fi
        pm clear com.android.updater &>/dev/null
        set_perm $tf 0 0 644
        mv -f $tf $File
        Unload
elif [[ $1 = -mask ]]; then
id=Han.GJZS-MIUI
name=搞机助手MIUI专区扩展模块
version='v1'
versionCode=1
author='by：Han | 情非得已c'
description='搞机助手MIUI专区扩展模块，在无法修改system的情况下，利用Magisk修改一些系统参数'
File=/system/etc/hosts
MODPATH=$Modules_Dir/$id
MODPROP=$MODPATH/module.prop
MODFILE=$MODPATH$File

echo "- 已通过Magisk模块方式修改"

echo 0 >$Status
find $Modules_Dir -name hosts | while read i; do
    grep -q 'update.miui.com' "$i"
    if [[ $? -eq 0 ]]; then
        modid=`echo "$i" | cut -f5 -d '/'`
        echo 1 >$Status
        modname=`grep_prop name "$Modules_Dir/$modid/module.prop"`
        if [[ $state = 1 ]]; then
            echo "- 已检测到「$modname」模块存在hosts文件，不再创建新的「$name」模块"
            sed -i "/update.miui.com/d" "$i"
            echo '127.0.0.1 update.miui.com' >>$i
            echo "- [MIUI 更新检查] 已禁用."
            echo "- 修改完成，重启手机后生效."
        else
            echo "- 已恢复默认，重启手机后生效."
            sed -i "/update.miui.com/d" "$i"
            if [[ "$modid" = "Han.GJZS-MIUI" ]]; then
                rm -rf $MODFILE
                rmdir -p $MODPATH/system/etc &>/dev/null
                [[ ! -d $MODPATH/system ]] && rm -rf $MODPATH
            fi
        fi
    fi
done

r=`cat $Status`

    if [[ $r -eq 0 ]]; then
        if [[ $state = 1 ]]; then
            mask -vc
            mkdir -p $MODPATH/system/etc
            cp -af $File $MODFILE
            sed -i "/update.miui.com/d" "$MODFILE"
            echo '127.0.0.1 update.miui.com' >>$MODFILE
            set_perm $MODFILE 0 0 644
cat <<Han >$MODPROP
id=$id
name=$name
version=$version
versionCode=$versionCode
author=$author
description=$description
Han
            echo "- [MIUI 更新检查] 已禁用.."
            test -f $MODPROP && ui_print "- 模块安装完成，重启后生效.." || abort "！模块安装失败.."
        else
            rm -rf $MODFILE
            rmdir -p $MODPATH/system/etc &>/dev/null
            [[ ! -d $MODPATH/system ]] && rm -rf $MODPATH
            echo "- 已恢复默认，重启手机后生效.."
        fi
    fi
fi
sleep 3
