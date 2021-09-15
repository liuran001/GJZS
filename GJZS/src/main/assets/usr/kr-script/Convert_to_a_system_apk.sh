#本脚本由　by Han | 情非得已c，编写
#应用于搞机助手上

Convert_to_a_system_apk() {
    MOD_id="$1"
    MOD_name="$2"
    MOD_author="$3"
    BaoMing="$4"
    
    mask -vc
    mask $1
    Choice=1
    . $Load $1
    File="$Download_File"


    case $Type in
    data)
        echo "开始安装$MOD_name"
        echo 0 >$Status
        pm uninstall "$BaoMing" &>/dev/null
        sh $ShellScript/install_apk.sh &>/dev/null
        result=`cat $Status`
        [[ $result -eq 0 ]] && echo "- 安装成功" || abort "！安装失败"
    ;;
    0)
        echo
        echo
        echo "- 正在检测「"$MOD_name"」是否已安装，请骚等……"
        if [[ ! -d $Module || $versionCode -lt $8 ]] ; then
            echo "- 正在安装${MOD_name}-$7（$8）……"
            echo "开始安装$MOD_name"
            echo 0 >$Status
            pm uninstall "$BaoMing" &>/dev/null
            sh $ShellScript/install_apk.sh &>/dev/null
            result=`cat $Status`
            if [[ $result -eq 0 ]]; then
                echo "- 写入成功"
                APK=`pm path "$BaoMing" | sed 's/package://'`
                rm -rf $Module &>/dev/null
                mkdir -p $Module/system/priv-app
                cp -r ${APK%/*} $Module/system/priv-app
                ui_print "- 设置权限……"
                set_perm_recursive $Module 0 0 0755 0644
                pm uninstall "$BaoMing" &>/dev/null
            else
                rm -rf $Module
                abort "！写入失败"
            fi
            
            
            echo "id="$MOD_id"
            name=Magisk版 "$MOD_name"
            version="$7"
            versionCode="$8"
            author="$MOD_author"
            description=将"$MOD_name"内置为/system应用获得最高权限，开机自启，设置一次后以后每次开机后自动打开权限，不再惧怕被杀后台" >$Module_XinXi
            
                if [[ -f $Module_XinXi ]]; then
                    echo "- 「"$MOD_name"」Magisk模块创建完成，模块将在下次重启生效"
                    CQ
                fi
        elif [[ -d $Module && $versionCode -ge $8 ]]; then
            echo "- 已安装了最新版本：${MOD_name}-$7（$8），不再重复安装。"
        fi
    ;;
    esac
}


if [[ $APK = Fluid-NG ]]; then
    Convert_to_a_system_apk Fluid-NG "流体手势导航" 佚名 com.fb.fluid
elif [[ $APK = Gesture ]]; then
    Convert_to_a_system_apk Gesture "Gesture(手势导航)" "by：酷安 @嘟嘟斯基" com.omarea.gesture
fi
