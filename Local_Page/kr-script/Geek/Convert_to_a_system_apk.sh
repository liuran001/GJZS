#本脚本由　by Han | 情非得已c，编写
#应用于搞机助手上


if [[ $APK = Fluid-NG ]]; then
    . $Load com.fb.fluid
elif [[ $APK = Gesture ]]; then
    . $Load com.omarea.gesture
fi

Modules_Dir=$Frame_Dir
mask $id
versionCode1=$versionCode
Choice=1
. $Load $id
File="$Download_File"

XR() {
    MODPATH=$Module
    ui_print "- 开始写入到/system……"
    echo 0 >$Status
    pm uninstall "$id" &>/dev/null
    sh $ShellScript/install_apk.sh &>/dev/null
    result=`cat $Status`
    [[ $result -eq 0 ]] && echo "- 安装成功" || abort "！安装失败"
    APK=`pm path "$id" | sed 's/package://'`
    rm -rf $Module &>/dev/null
    mkdir -p $Module/system/priv-app
    cp -r ${APK%/*} $Module/system/priv-app
    ui_print "- 设置权限……"
    set_perm_recursive $Module 0 0 0755 0644
    pm uninstall "$id" &>/dev/null
    End_installation
echo "id="$id"
name="$name"
version="$version"
versionCode="$versionCode"
author="$author"
description=将"$name"内置为/system应用获得最高权限，开机自启，设置一次后以后每次开机后自动打开权限，不再惧怕被杀后台" >$Module_XinXi
}

    
    case $Type in
        data)
            echo "开始安装"$name""
            echo 0 >$Status
            pm uninstall "$id" &>/dev/null
            sh $ShellScript/install_apk.sh &>/dev/null
            result=`cat $Status`
            [[ $result -eq 0 ]] && echo "- 安装成功" || abort "！安装失败"
        ;;
        
        0)
            Mount_system
            echo
            echo
            echo "- 正在检测「"$name"」是否已安装，请骚等……"
            if [[ ! -d $Module ]] ; then
                echo "- 正在安装……"
                XR
                if [[ -f $Module_XinXi ]]; then
                    echo "- 「"$name"」已安装为系统应用，将在下次重启生效"
                    Unload
                    End_of_Frame_installation
                    CQ
                fi
            elif [[ -d $Module && $versionCode1 -lt $versionCode ]]; then
                echo "- 正在更新……"
                XR
                if [[ -f $Module_XinXi ]]; then
                    echo "- 「"$name"」已更新完成，将在下次重启生效"
                    CQ
                fi
            elif [[ -d $Module && $versionCode1 -ge $versionCode ]]; then
                echo "- 已安装了最新版本：${name}-$version（$versionCode），不再重复安装。"
            fi
            
        ;;
    esac
