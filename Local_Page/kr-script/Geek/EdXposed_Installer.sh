#本脚本由　by Han | 情非得已c，编写
#应用于搞机助手上


Riru="$Frame_Dir/riru-core/module.prop"
Choice=1

Check_Riru
    if [[ -f "$Riru" ]]; then
        version=`grep_prop version "$Riru"`
        versionCode=`grep_prop versionCode "$Riru"`
        echo "- 已安装了Riru （Riru - Core）$version($versionCode)"
        echo
    else
        echo 6
        No_Riru
    fi

        if [[ $EdXp_Type = Custom ]]; then
            ZDY=1
            MODNAME="自定义EDXposed版本刷入"
        else            
            if [[ $EdXp_Type -eq 1 ]]; then
                MODID=riru_edxposed
                Old_YAHFA=1
                MODNAME="$Old_EDXP版YAHFA版EdXposed"
            elif [[ $EdXp_Type -eq 2 ]]; then
                MODID=riru_edxposed_sandhook
                Old_SandHook=1
                MODNAME="$Old_EDXP版SandHook版EdXposed"
            fi
        fi


if [[ $EdXp_Type != 0 ]]; then
    if [[ $SDK -ge 30 ]]; then
abort -e "！极客专区Riru EDXposed无法适配安卓11

由于Riru模块作者对Riru 22+进行了改动，直接修改/system/build.prop无法成功修改Riru 里那个system.prop属性，在查阅了资料后才得知这个属性由boot.img控制，所以导致新版Riru 22+以上版本无法直接写入系统，自然也就只保留了一个21.3版本和最后一个兼容21.3版本的Riru EdXposed

意思就是安卓11+的用户想使用EDXposed必须去解锁BL然后使用Magisk模块方式安装"
    fi
        if [[ -d $DATA_DIR/com.solohsu.android.edxp.manager ]]; then abort -e "已检测到您安装了EdXposed Installer，由于作者没更新了导致无法检测到新版EDXposed，显示未安装！\n请卸载EdXposed Installer选择EdXposed_Manager才能继续安装"; fi
        [[ -f /system/lib/libjit.so ]] && abort "！一山不容二虎，请先卸载太极 · 阳模块，再来安装EDXposed吧！"
            if [[ $SDK -lt 26 ]]; then
                echo "******************************"
                echo "! 检测到旧版Android $SDK（在Oreo以下）"
                echo "! 在Android 8.0下只能使用原始的Xposed框架"
                echo "! 您可以从“ Xposed安装程序”或“ Magisk Manager ”中下载"
                echo "! Learn more: https://github.com/ElderDrivers/EdXposed/wiki/Available-Android-versions"
                abort "******************************"
            fi
                sleep 2
                . $Install_Method riru_edxposed
                . $Install_Method riru_edxposed_sandhook
                echo "已选择$MODNAME"
                    if [[ $ZDY -eq 1 ]]; then
                        ZIPFILE="$File"
                        [[ -d $Script_Dir ]] && rm -rf $Script_Dir &>/dev/null
                        [[ ! -d $Script_Dir ]] && mkdir -p $Script_Dir
                        unzip -ojq "$ZIPFILE" "module.prop" -d $Script_Dir
                        
                        MODID=`grep_prop id "$Script_Dir/module.prop"`
                        rm -rf $Script_Dir &>/dev/null
                        case $MODID in
                            riru_edxposed | riru_edxposed_sandhook)
                                :
                            ;;
                            
                            *)
                                abort "！您选择的自定义文件 \"$ZIPFILE\" 不是EDXposed Magisk模块无法刷入"
                            ;;
                        esac
                    else
                        . $Load EdXposed
                        ZIPFILE="$Download_File"
                    fi
                        MODPATH=$Frame_Dir/$MODID
                        if [[ -f "$ZIPFILE" ]]; then
                            Frame_installation_Check
                            echo "---------------------------------------------------------"
                            sh $install_Frame 1 1 "$ZIPFILE" 0
                        else
                            abort "！文件不存在安装失败"
                        fi
fi
                            sleep 2
                            echo
                            [[ $apk -eq 1 ]] && . ./install_App_Store_File.sh org.meowcat.edxposed.manager.45700
                            [[ `cat $Status` = 0 ]] && echo "- 安装EdXposed Manager-4.5.7(45700).apk成功，以后请不要更新4.5.7(45700)以上版本，否则会导致不兼容会使框架显示未安装" || error "！安装EdXposed Manager-4.5.7(45700).apk失败"
                            End_installation
