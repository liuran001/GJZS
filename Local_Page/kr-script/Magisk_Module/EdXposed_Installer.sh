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

        [[ $Riru_version = 1 ]] && . ./Magisk_Module/Riru_Installer.sh $Riru_version
        if [[ -d $DATA_DIR/com.solohsu.android.edxp.manager ]]; then abort -e "已检测到您安装了EdXposed Installer，由于作者没更新了导致无法检测到新版EDXposed，显示未安装！\n请卸载EdXposed Installer选择EdXposed_Manager才能继续安装"; fi
            [[ -f /system/lib/libjit.so ]] && abort "！一山不容二虎，请先卸载太极 · 阳模块，再来安装EDXposed吧！"
            [[ -d $Modules_Dir/riru_lsposed ]] && echo "！已安装了Riru - LSPosed版已自动禁用" && touch $Modules_Dir/riru_lsposed/disable
            [[ -d $Modules_Dir/riru_dreamland ]] && echo "！已安装了Riru-Dreamland已自动禁用" && touch $Modules_Dir/riru_dreamland/disable
            echo -e "- 卸载可能已经安装的\n$Modules_Dir/riru_edxposed\n$Modules_Dir/riru_edxposed_sandhook\n避免部分人同时安装俩个导致EDXposed框架无法激活\n"
            sleep 2
            sh $Modules_Dir/riru_edxposed/uninstall.sh &>/dev/null
            sh $Modules_Dir/riru_edxposed_sandhook/uninstall.sh &>/dev/null
            rm -rf $Modules_Dir/riru_edxposed $Modules_Dir/riru_edxposed_sandhook
            . $Load riru_edxposed
            ZIPFILE="$Download_File"
            if [[ -f "$ZIPFILE" ]]; then
                echo "---------------------------------------------------------"
                sh $install_MOD $Compatible $Error "$ZIPFILE" 0
            else
                abort "！文件不存在安装失败"
            fi
                sleep 2
                echo
                [[ $edxpapk -eq 1 ]] && . ./install_App_Store_File.sh org.meowcat.edxposed.manager
                ChongQi=$ChongQi2
                CQ
    