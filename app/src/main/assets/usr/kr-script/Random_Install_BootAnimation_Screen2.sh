#本脚本由　by Han | 情非得已c，编写
#应用于搞机助手上


[[ -z $BootAnimation_Screen2 && -z $ZiDY_Screen2 ]] && abort "！未选择要随机的开机动画"

log="$Data_Dir/Random_Install_BootAnimation_Screen2.log"
id=BootAnimation_Screen2
version=v1.3
versionCode=3
author='by：Han | 情非得已c'
lu=$PeiZhi_File/BootAnimation_Screen2
PeiZhi_File=$lu
[[ ! -d $lu ]] && mkdir -p $lu
mask -vc
mask $id
BUYBOX=$Module/busybox
MODDH=$Module/bootanimation

echo "BootAnimation_Screen2=\"$BootAnimation_Screen2\"" >"$log"
echo "ZiDY_Screen2=\"$ZiDY_Screen2\"" >>"$log"
echo "return 0" >>"$log"
echo "bootanimation=$bootanimation" >>"$log"
echo "Customize_lu=$Customize_lu" >>"$log"
echo "Authority=$Authority" >>"$log"
echo "Set_Time=$Set_Time" >>"$log"
echo "install_Way=$install_Way" >>"$log"


    find $Modules_Dir -name bootanimation.zip | while read o; do
        modid=`echo "$o" | cut -f5 -d '/'`
        modname=`grep_prop name "$Modules_Dir/$modid/module.prop"`
        [[ "$o" = "$Modules_Dir/BootAnimation_Screen2/"* ]] && continue
        abort "！！已检测到存在相同的Magisk开机动画模块：「$modname」，无法安装！"
    done


    if [[ -f "$bootanimation" ]]; then
        echo "- 已选择路径：$bootanimation"
        jian=$bootanimation
        jian2=${jian}.bak
        jian3=$bootanimation.bak
    elif [[ $bootanimation = Customize ]]; then
        echo "- 已选择自定义路径：$Customize_lu"
        jian="$Customize_lu"
    fi
        case $jian in
        /system/*)
        :;;
        
        /vendor/* | /product/*)
        jian=/system/$jian
        ;;
        
        *)
        abort "！$jian路径不支持制作Magisk模块"
        ;;
        esac

        if [[ $install_Way = 0 ]]; then
            [[ ! -d "$MODDH" ]] && mkdir -p $MODDH
        elif [[ $install_Way = 1 ]]; then
            rm -rf $Module
            mkdir -p $MODDH
        fi
            cd $TMPDIR
            cd $Module
            rm -rf `ls | egrep -v '^bootanimation$'`
            [[ ! -f $BUYBOX ]] && cp -f $ELF4_Path/busybox $BUYBOX


cat <<Han >$Module_S2
#!/system/bin/sh
#本脚本由搞机助手自动创建
#作者：$author
#请不要试图篡改本脚本，否则一切后果自负，已安装版本：$version($versionCode)
#特别鸣谢Magisk提供服务支持：by topjohnwu


MODDIR=\${0%/*}
sleep ${Set_Time}m
cp -fp "\`\$MODDIR/busybox shuf -n1 \$MODDIR/RANDOM.log\`" \$MODDIR$jian
Han

rm -rf $Module/RANDOM.log
for i in $BootAnimation_Screen2; do
    echo
    MODNAME=`sed -n "s/${i}|//p" $ShellScript/Install_BootAnimation_Screen2_Option.sh`
    echo "- 已选择了「$MODNAME」作为随机开机动画"
    . $Load BootAnimation_Screen2 "$i"
        if [[ ! -f $MODDH/$File_MD5.zip ]]; then
            cp -f $Download_File "$MODDH/$File_MD5.zip"
        else
            echo "- 「$MODNAME」开机动画已存在不再重复复制"
        fi
        echo "$MODDH/$File_MD5.zip" >>$Module/RANDOM.log
done


if [[ -n "$ZiDY_Screen2" ]]; then
    echo "- 注入自定义的开机动画文件"
    for o in $ZiDY_Screen2; do
        echo
        if [[ -f "$o" ]]; then
            md5=`md5sum "$o" | sed 's/ .*//'`
            echo "$MODDH/$md5.zip" >>$Module/RANDOM.log
                if [[ ! -f $MODDH/$md5.zip ]]; then
                    echo "- 添加$o动画到随机开机动画列表"
                    cp -f $o "$MODDH/$md5.zip"
                else
                    echo "- 「$o」开机动画已存在不再重复复制"
                fi
        else
            error "！$o文件不存在无法添加到随机开机动画列表"
        fi
    done
fi

sed -i '/^$/d' $Module/RANDOM.log
c=`sed -n '$=' $Module/RANDOM.log`

printf "id=$id
name=随机开机动画第二屏
version=$version
versionCode=$versionCode
author=$author
description=在重启手机$Set_Time分钟后，在$c个开机动画里随机抽取一个开机动画做为下一次的开机动画，让你永远也猜不出下一次开机动画" >$Module_XinXi

mkdir -p $Module`dirname $jian`
set_perm_recursive $Module 0 0 0755 0644
set_perm $BUYBOX 0 0 755
cp -fp "`$BUYBOX shuf -n1 $Module/RANDOM.log`" $Module$jian
echo "- 「随机开机动画第二屏」模块创建完成"
CQ
