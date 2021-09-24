#本脚本由　by Han | 情非得已c，编写
#应用于搞机助手上


Backup() {
    echo "- 正在备份第二屏中…………"
    if [ ! -f "$jian2" ];then
        echo "- 第二屏已自动备份"
        mv -f $jian $jian2 &>/dev/null
        echo "- 备份文件已保存到$jian2"
    else
        echo "- 第二屏备份已存在"
    fi
}

check_bootanimation_Module() {
    find $Modules_Dir -name bootanimation.zip | while read o; do
        modid=`echo "$o" | cut -f5 -d '/'`
        modname=`grep_prop name "$Modules_Dir/$modid/module.prop"`
        [[ "$o" = "$Modules_Dir/BootAnimation_Screen2/"* ]] && continue
        abort "！！已检测到存在相同的Magisk开机动画模块：「$modname」，无法安装！"
    done
}

Magisk_Module() {
    echo "- 已选择通过Magisk模块挂载"
        mask -vc
        mask $1
        MOD_id="$1"
        Module_File=${Module}$jian
        if [[ ! -d $Module ]]; then
            mkdir -p $Module
            touch $Module_Update
        else
            rm -rf $Module/*
        fi
        
            mkdir -p `dirname $Module_File` &>/dev/null
            
                if [[ $BootAnimation_Screen2 = 0 && -f "$ZiDY_Screen2" ]]; then
                    cp -f "$ZiDY_Screen2" $Module_File
                    [[ $? = 0 ]] && echo "- $MODNAME动画已通过Magisk模块挂载"
                else
                    cp -f $lu/${BootAnimation_Screen2}.zip $Module_File
                    [[ $? = 0 ]] && echo "- $MODNAME动画已通过Magisk模块挂载"
                fi
                    set_perm_recursive $Module 0 0 0755 $Authority
                    [[ ! -f $Module_Update ]] && cp -fp $Module_File $jian &>/dev/null

printf "id=$MOD_id
name=开机动画第二屏
version=1
versionCode=1
author=by：Han | 情非得已c
description=修改开机动画第二屏为：$MODNAME" >$Module_XinXi

                    if [[ -f $Module_XinXi && -f $Module_File ]]; then
                        echo "- 「$MODNAME」Magisk模块创建完成"
                        CQ
                        exit
                    fi
}



echo "bootanimation=$bootanimation" >$Data_Dir/Install_BootAnimation_Screen2.log
echo "Customize_lu=$Customize_lu" >>$Data_Dir/Install_BootAnimation_Screen2.log
echo "Authority=$Authority" >>$Data_Dir/Install_BootAnimation_Screen2.log
echo "install_Way=$install_Way" >>$Data_Dir/Install_BootAnimation_Screen2.log

GZ=false
[[ $install_Way = system ]] && GZ=true
[[ $install_Way = Module ]] && GZ=false
lu=$PeiZhi_File/BootAnimation_Screen2
PeiZhi_File=$lu
[[ ! -d $lu ]] && mkdir -p $lu


if [[ $bootanimation = Customize ]]; then
    echo "- 已选择自定义路径：$Customize_lu"
    jian="$Customize_lu"
elif [[ -f "$bootanimation" ]]; then
    echo "- 已选择路径：$bootanimation"
    jian=$bootanimation
fi
    [[ ! -f "$jian" ]] && abort "- $jian 开机动画第二屏文件不存在"
    jian2=${jian}.bak
    if [[ $install_Way = Module ]]; then
        case $jian in
            /system/*)
        :;;
            /vendor/* | /product/*)
            jian=/system$jian
        ;;
        
        *)
            abort "！$jian路径不支持制作Magisk模块"
        ;;
        esac
    else
        case $jian in
            /system/*)
                Mount_system && jian=${jian/\/system/$system}
        ;;
        
            /vendor/*)
                Mount_vendor && jian=${jian/\/vendor/$vendor}
        ;;
        
            /product/*)
                mount -o rw,remount /product
                [[ -w /product ]] && echo "- 挂载/product读写成功" || abort "！挂载/product读写失败"
                
        ;;
        *)
            mount -o rw,remount /
        ;;
        esac
    fi
        if [[ $Default == 1 ]]; then
            echo "- 您选择了恢复默认"
            if [[ -d $Modules_Dir/BootAnimation_Screen2 ]]; then
                rm -rf $Modules_Dir/BootAnimation_Screen2
                echo "- 开机动画模块已移除，将在下次重启手机后失效"
            fi
                if [[ -f $jian2 ]]; then
                    echo "- 开机动画备份文件存在，开始恢复"
                    mv -f $jian2 $jian
                    [[ $? = 0 ]] && echo "- 开机动画恢复成功"
                fi
                    CQ
                    sleep 4
                    exit
        fi



check_bootanimation_Module
if [[ $BootAnimation_Screen2 = 0 ]]; then
    echo "- 开始安装自定义文件$ZiDY_Screen2"
    if [[ -f "$ZiDY_Screen2" ]]; then
        MODNAME=`basename "$ZiDY_Screen2"`
        if [[ $install_Way = Module ]]; then
            Magisk_Module BootAnimation_Screen2
        elif [[ $install_Way = system ]]; then
                Backup
                cp -f "$ZiDY_Screen2" $jian >/dev/null && echo "- $MODNAME动画安装成功。" && Succeed=1
                chmod $Authority $jian &>/dev/null
                Unload
                [[ $Succeed = 1 ]] && CQ
                sleep 3
                exit 0
        fi
    else
        abort "！您选择的自定义文件 $ZiDY_Screen2 不存在"
    fi
fi


MODNAME=`sed -n "s/${BootAnimation_Screen2}|//p" $ShellScript/Install_BootAnimation_Screen2_Option.sh`
$GZ && Backup
echo "- 您当前选择了「$MODNAME」开机动画"
. $Load BootAnimation_Screen2 "$BootAnimation_Screen2"
echo
echo "- 开始安装……"

    if [[ -f $lu/${BootAnimation_Screen2}.zip ]]; then
        if [[ $install_Way = Module ]]; then
            Magisk_Module BootAnimation_Screen2
        elif [[ $install_Way = system ]]; then
            cp -f $lu/${BootAnimation_Screen2}.zip $jian
            if [[ $? = 0 ]]; then
                echo "- 「$MODNAME」第二屏开机动画已安装完成。"
                chmod $Authority $jian &>/dev/null
                case $bootanimation in
                /product/*)
                    mount -o ro,remount /product &>/dev/null
                ;;
                /vendor/*)
                    Unload_vendor
                ;;
                /system/*)
                    Unload
                ;;
                esac
                CQ
            else
                abort "！「$MODNAME」第二屏安装失败❌！！！"
            fi
        fi
    else
        abort "！文件下载失败无法安装！！！❌"
    fi
