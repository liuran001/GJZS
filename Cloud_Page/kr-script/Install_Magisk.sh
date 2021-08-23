#本脚本由　by Han | 情非得已c，编写
#应用于搞机助手上


mask
[[ $KEEPVERITY = 1 ]] && export KEEPVERITY=true || export KEEPVERITY=false
[[ $KEEPFORCEENCRYPT = 1 ]] && export KEEPFORCEENCRYPT=true || export KEEPFORCEENCRYPT=false
[[ $RECOVERYMODE = 1 ]] && export RECOVERYMODE=true || export RECOVERYMODE=false
c=$1

case $c in
-install)
    ChongQi=1
    [[ -x $Magisk ]] && abort "已安装了Magisk，不再重复安装，如需更新请使用一键更新Magisk"
    . ./Forbid_AVB.sh
;;

-repair)
    mask -v
    ChongQi=1
;;

-update)
    . $Load com.topjohnwu.magisk
    mask -v
        if [ "$MAGISK_VER" = "$version" ]; then
           abort "！已是最新版$MAGISK_VER($MAGISK_VER_CODE)了"
        fi
        #if [[ "$MAGISK_VER_CODE" -ge "$versionCode" ]]; then
           #abort "！已是最新版$MAGISK_VER($MAGISK_VER_CODE)了"
        #fi
;;

*)
    exit 1
;;
esac

Choice=1
. $Load com.topjohnwu.magisk

    if [[ -f "$Download_File" ]]; then
        [[ -d $Script_Dir ]] && rm -rf $Script_Dir &>/dev/null
        [[ ! -d $Script_Dir ]] && mkdir -p $Script_Dir
        echo "---------------------------------------------------------"
        unzip -ojq "$Download_File" "META-INF/*" -d $Script_Dir
            if [[ -f $jian ]]; then
                if [[ $c = -repair ]]; then
                    echo "- 正在修复运行环境……"
                    sh $ShellScript/repair_Magisk.sh dummy 1 "$Download_File"
                    echo "- 修复运行环境完成"
                else
                    echo "正在安装$name-$version($versionCode).zip……"
                    sh $jian dummy 1 "$Download_File" 2>/dev/null
                    echo "- 正在安装$name-$version($versionCode).apk"
                    . ./install_App_Store_File.sh com.topjohnwu.magisk
                fi
            else
                echo "${jian##*/} 脚本丢失！"
                ChongQi=0
            fi
            rm -rf $Script_Dir &>/dev/null
            echo
            echo "THE END"
            CQ
    else
        abort "！文件下载出错请重新下载，请检查网络是否正常"
    fi
