#本脚本由　by Han | 情非得已c，编写
#应用于搞机助手上


ChongQi2=$ChongQi
ChongQi=0
Choice=1

if [[ $SELinux_OFF = 1 ]]; then
    sh $install_MOD $Compatible $Error None 1 "SELinux_OFF"
fi

    mask riru-core
    if [[ -d "$Module" ]]; then
        echo "- 已安装了Riru （Riru - Core）$version($versionCode)"
        [[ -n $versionCode && $versionCode -lt 41 && $Riru_version -eq 0 ]] && echo "！已安装的Riru （Riru - Core）版本在v22以下，已自动打开安装Riru开关" && Riru_version=1
    fi

        [[ -f /system/lib/libjit.so ]] && abort "！一山不容二虎，请先卸载太极 · 阳模块，再来安装吧！"
        [[ -d $Modules_Dir/riru_edxposed ]] && echo "！已安装了EDXposed YAHFA版已自动禁用" && touch $Modules_Dir/riru_edxposed/disable
        [[ -d $Modules_Dir/riru_edxposed_sandhook ]] && echo "！已安装了EDXposed SandHook版已自动禁用" && touch $Modules_Dir/riru_edxposed_sandhook/disable
        [[ -d $Modules_Dir/riru_dreamland ]] && echo "！已安装了Riru-Dreamland已自动禁用" && touch $Modules_Dir/riru_dreamland/disable
        [[ $Riru_version = 1 ]] && . ./Magisk_Module/Riru_Installer.sh $Riru_version
            . $Load riru_lsposed
            if [[ -f "$Download_File" ]]; then
                echo "---------------------------------------------------------"
                sh $install_MOD $Compatible $Error "$Download_File" 0
            else
                abort "！文件下载失败"
            fi
                sleep 2
                echo
                ChongQi=$ChongQi2
                CQ
    