#Custom variable
export Util_Functions_Code=2021080101
export SDdir=/data/media/0
export Magisk=`$which magisk`
if $Have_ROOT;then
	if [[ -x $Magisk ]]; then
		Magisk_lite_Version=$(echo `$Magisk -v` | grep "lite")
		if [[ "$Magisk_lite_Version" != "" ]];then
			export Modules_Dir=/data/adb/lite_modules
		else
			export Modules_Dir=/data/adb/modules
		fi
	fi
else
	export Modules_Dir=/data/adb/modules
fi
export Script_Dir=$TMPDIR/tmp
export install_MOD=$ShellScript/Magisk_Module/install_Module_Script.sh
export install_Frame=$ShellScript/Geek/install_Frame_Script.sh
export Install_Method=$ShellScript/Geek/Installation_Check.sh
export APK_Name_list=$Data_Dir/APK_Name.log
export APK_Name_list2=$Data_Dir/APK_Name2.log
export jian="$Script_Dir/update-binary"
export jian2="$Script_Dir/update-script"
export Frame_Dir=/data/misc/$Package_name
export Charging_control=/sys/class/power_supply/battery/input_suspend
export Charging_control2=/sys/class/power_supply/battery/charging_enabled
export Game_Toolbox_File=/data/data/com.miui.securitycenter/files/gamebooster/freeformlist
export Status=$Data_Dir/Status.log
export Termux=$DATA_DIR/com.termux/files
export BOOTMODE=true
export Choice=0
export New_Version=3.0.1-Alpha
export New_Code=2021072501
export ChongQi Configuration File File_Name Download_File File_MD5 id name version versionCode author description MODID MODNAME MODPATH MAGISK_VER MAGISK_VER_CODE LOCKED
$Have_ROOT && LOCKED=false || LOCKED=true


#Dynamic variable
export Time=`date '+%s'`
export ABI=`getprop ro.product.cpu.abi`
[[ -z "$ABI" ]] && export ABI=`getprop ro.product.cpu.abi2`

if [[ -f "$Data_Dir/GJZS_PATH" ]]; then
    export GJZS=$(cat "$Data_Dir/GJZS_PATH")
else
    export GJZS="$SD_PATH/Documents/$Package_name"
fi
export lu=$GJZS/Batch_installation
export lu2=$GJZS/Add_Modules
export lu3=$GJZS/XianShua


#Function
mask() {
        export Magisk=`$which magisk`
        export MAGISKTMP=`$Magisk --path 2>/dev/null`
        [[ -z "$MAGISKTMP" ]] && export MAGISKTMP=/sbin
        if [[ "$1" == '-v' ]]; then
            if [[ -x $Magisk ]]; then
                MAGISK_VER=`$Magisk -v | sed 's/:.*//'`
                MAGISK_VER_CODE=`$Magisk -V`
            else
                abort "！未检测到Magisk，请确定Magisk Manager主页已显示安装了Magisk"
            fi
        elif [[ "$1" == '-vc' ]]; then
            if [[ -x $Magisk ]]; then
                MAGISK_VER=`$Magisk -v | sed 's/:.*//'`
                MAGISK_VER_CODE=`$Magisk -V`
            else
                abort "！未检测到Magisk，请确定Magisk Manager主页已显示安装了Magisk"
            fi
                if [[ -d $Modules_Dir ]]; then
                    echo "已安装Magisk版本：$MAGISK_VER（$MAGISK_VER_CODE）"
                    [[ $MAGISK_VER_CODE -lt 19000 ]] && abort "！未适配Magisk 19.0以下的版本，19.0以下版本采用magisk.img方式挂载模块"
                    echo "---------------------------------------------------------"
                    [[ `sh $ShellScript/support/Missing_file.sh` = 1 ]] && abort -e "已检测到Magisk需要修复运行环境\n缺失 Magisk 正常工作所需的文件，如果不修复您将无法使用模块功能，可在Magisk Manger里修复也可以在Magisk专区一键修复Magisk运行环境" || return 0
                fi
        elif [[ -n "$1" ]]; then
            Module="$Modules_Dir/$1"
            Module_XinXi="$Module/module.prop"
            Module_S="$Module/post-fs-data.sh"
            Module_S2="$Module/service.sh"
            Module_us="$Module/uninstall.sh"
            Module_prop="$Module/system.prop"
            Module_Disable="$Module/disable"
            Module_Remove="$Module/remove"
            Module_Skip_Mount="$Module/skip_mount"
            Module_Update="$Module/update"
            if [[ -f $Module_XinXi ]]; then
                version=`grep_prop version "$Module_XinXi"`
                versionCode=`grep_prop versionCode "$Module_XinXi"`
            fi
        fi
}

adb() (
    local ADB=`$which adb`
    if [[ $# -eq 0 ]]; then
        exec "$ADB"
    fi
    
    case "$1" in
        help | --help | kill-server | start-server | reconnect | devices | keygen | tcpip | connect | disconnect | usb | wait-for-*)
           exec "$ADB" "$@"
        ;;
        -reset)
            "$ADB" kill-server
            exec "$ADB" start-server
    esac
    
    
    [[ -z `"$ADB" devices | egrep -vi 'List of.*'` ]] && error "！无设备连接" && exit 126
    exec "$ADB" "$@"
)

fastboot() (
    local FASTBOOT=`$which fastboot`
    if [[ $# -eq 0 ]]; then
        exec "$FASTBOOT"
    fi
    
    case "$1" in
        help | --help | -h | devices)
        : ;;
        
        *)
            [[ -z `"$FASTBOOT" devices` ]] && error "！无设备连接" && exit 126
        ;;
    esac
    
    exec "$FASTBOOT" "$@"
)

error() {
    echo "$@" 1>&2
}

abort() {
    error "$@"
    sleep 3
    exit 1
}

abort2() {
    abort -e "$@\n\n错误代码：`cat $Status`"
}

show_progress() {
    [[ -n $2 ]] && echo "progress:[$1/$2]" || echo "progress:[$1/100]"
}

adb2() { 
    if [[ "$#" -eq 0 ]]; then
        adb shell
        if [[ $? -ne 0 ]]; then
            abort "没有设备连接无法继续哦⊙∀⊙！"
        fi
    elif [[ "$1" = "-s" && "$#" -eq 2 ]]; then
        shift
        adb shell < "$1"
    elif [[ "$1" = "-c" ]]; then
        shift
        adb shell "$@"
    fi
}

adbsu() {
    local a b
    a=`adb shell su --help | grep '\-c'`
    [[ -n "$a" ]] && b=true || b=false
        if [[ "$#" -eq 0 ]]; then
            adb shell su
        elif [[ "$1" = "-s" && "$#" -eq 2 ]]; then
            shift
            adb shell su < "$1"
        elif [[ "$1" = "-c" ]]; then
            shift
            $b && adb shell su -c \'"$@"\' || echo "Link@" | adb shell su
        fi
}

Install_curl() {
    curl -where &>/dev/null && return 0
    unzip --help &>/dev/null || return 1
    wget -where &>/dev/null || return 1
    [[ ! -f $Load ]] && return 1
    local jian jian2
    . $Load curl
    
    jian=$TMPDIR/curl.zip
    jian2=$Script_Dir/META-INF/com/google/android/update-binary
    WGET -c -O $jian "http://d0.ananas.chaoxing.com/download/$url"
    [[ ! -f "$jian" ]] && abort "！下载文件失败"
    echo "- 开始安装curl"
    rm -rf $Script_Dir
    mkdir -p $Script_Dir
    unzip -oq "$jian" 'META-INF/com/google/android/update-binary' -d $Script_Dir
    
    if [[ -f "$jian2" ]]; then
        sh "$jian2" $Package_name 1 "$jian"
        PATH="$PATH"
    else
        abort "！解压文件失败"
    fi
    rm -f $jian
}


Install_Applet2() {
    JCe="$PeiZhi_File/Applet_Installed.log"
    [[ -f "$JCe" ]] && JCe3=`cat $JCe`

    Start_Install2() {
       # Download "$@"
        
            if [[ -f "$Download_File" ]]; then
                [[ ! -d $ELF2_Path ]] && mkdir -p "$ELF2_Path" && chown $APP_USER_ID:$APP_USER_ID $ELF2_Path || rm -rf $ELF2_Path/*
                unzip -oq "$Download_File" -d "$ELF2_Path"
                    if [[ $? = 0 ]]; then
                        echo "$versionCode" >$JCe
                        chmod -R 700 $ELF2_Path/*
                        chown -R $APP_USER_ID:$APP_USER_ID $ELF2_Path/*
                            case "$ABI" in
                                arm64*)
                                    mv -f "$ELF2_Path/arm64/"* "$ELF2_Path"
                                ;;
                                
                                arm*)
                                    mv -f "$ELF2_Path/arm/"* "$ELF2_Path"
                                ;;
                                *)
                                    echo "！ 未知的架构 ${ABI}，无法安装adb & fastboot"
                                    rm -f "$ELF2_Path/adb"
                                    [[ $ABI = x86* ]] && mv -f "$ELF2_Path/x86/"* "$ELF2_Path"
                                ;;
                            esac
                            echo "- $name-$versionCode安装成功。"
                            rm -rf "$Download_File" $ELF2_Path/{arm,arm64,x86}
                    fi
            fi
        }
                           if [[ -z "$JCe3" || ! -f "$ELF2_Path/CQ" ]]; then
                               echo "- 开始安装$name-$versionCode"
                               Start_Install2 "$@"
                           elif [[ "$JCe3" -lt "$versionCode" ]]; then
                               echo "- 开始更新$name-$versionCode"
                               Start_Install2 "$@"
                           fi
}

Cloud_Update() {
    local File S
    File="$PeiZhi_File/Cloud.zip"
    JCe="${PeiZhi_File}/Cloud_Version.log"
    [[ -f "$JCe" ]] && JCe5=`cat "$JCe"`
    unset S
        if [[ -z "$JCe5" || ! -f "$Pages/Home.xml" ]]; then
            S=初始化
        elif [[ "$JCe5" -lt "$Cloud_Version" ]]; then
            S=更新
        fi
            if [[ -n "$S" ]]; then
                echo "- 正在$S云端页面：$Cloud_Version"
                    XiaZai -s "$CODING/$Cloud_ID" "$File"
                    if [[ -f "$File" ]]; then
                                unzip -oq "$File" -d ~
                                    if [[ $? = 0 ]]; then
                                        echo "- $S内置页面成功"
                                        echo "$Cloud_Version" >"$JCe"
                                        find ~ -exec chmod 700 {} \; -exec chown $APP_USER_ID:$APP_USER_ID {} \; &
                                        rm -f "$File"
                                    else
                                        echo "！$S内置页面失败❌"
                                    fi
                           fi
                    else
                        abort "！未连接到网络❓"
                    fi
}

Start_Installing_Busybox() {
    JCe=$PeiZhi_File/busybox_Installed.log
    [[ -f $JCe ]] && JCe2=`cat $JCe`
    case "$ABI" in
        arm64*) Type=arm64;;
        arm*) Type=arm;;
        x86_64*) Type=x86_64;;
        x86*) Type=x86;;
        mips64*) Type=mips64;;
        mips*) Type=mips;;
        *) echo "！ 未知的架构 ${ABI}，无法安装busybox"; return 1;;
    esac
    
    CloudBusybox=1

    Start_Install() {
        Download_File=$Other/busybox/busybox_$Type
        if [[ -f "$Download_File" ]]; then
            BusyBox2=$ELF4_Path/busybox
            [[ ! -d $ELF4_Path ]] && mkdir -p "$ELF4_Path" && chown $APP_USER_ID:$APP_USER_ID $ELF4_Path || rm -f $ELF4_Path/*
            cp "$Download_File" "$BusyBox2" && chmod 700 $BusyBox2
            echo "- 正在安装busybox-$Type版"
            "$BusyBox2" --install -s "$ELF4_Path" &>/dev/null
                if [[ -L "$ELF4_Path/true" ]]; then
                    echo "- busybox-$Type版安装成功。"
                    echo "$CloudBusybox" >$JCe
                    chown $APP_USER_ID:$APP_USER_ID "$BusyBox2"
                    # rm -f $Download_File
                else
                    echo "！busybox安装失败❌"
                    rm -f "$BusyBox2"
                    sleep 3
                fi
        fi
    }

        if [[ -z "$JCe2" || ! -L $ELF4_Path/true ]]; then
            echo "- 开始安装busybox"
            Start_Install
        elif [[ "$JCe2" -lt "$CloudBusybox" ]]; then
            echo "- 开始更新busybox"
            Start_Install
        fi
}

Installing_Busybox() {
    Start_Installing_Busybox
    . $Load Install_Applet
    [[ ! -d $lu ]] && mkdir -p $lu &>/dev/null
    [[ ! -d $lu2 ]] && mkdir -p $lu2 &>/dev/null
    [[ ! -d $lu3 ]] && mkdir -p $lu3 &>/dev/null
}

Start_Time() {
    Start_ns=`date +'%s%N'`
}

End_Time() {
    #小时、分钟、秒、毫秒、纳秒
    local h min s ms ns End_ns time ms1 ms2
    End_ns=`date +'%s%N'`
    time=`expr $End_ns - $Start_ns`
    [[ -z "$time" ]] && return 0
    ns=${time:0-9}
    s=${time%$ns}
    ms1=`expr $ns / 1000000`
    ms2=`expr $ns % 1000000`
    [[ -n "$ms2" ]] && ms=$ms1.$ms2 || ms=$ms1
    
        if [[ $s -ge 3600 ]]; then
            h=`expr $s / 3600`
            h=`expr $s % 3600`
            if [[ $s -ge 60 ]]; then
                min=`expr $s / 60`
                s=`expr $s % 60`
            fi
            echo "- 本次$1用时：$h小时$min分钟$s秒$ms毫秒"
        elif [[ $s -ge 60 ]]; then
            min=`expr $s / 60`
            s=`expr $s % 60`
            echo "- 本次$1用时：$min分钟$s秒$ms毫秒"
        elif [[ -n $s ]]; then
            echo "- 本次$1用时：$s秒$ms毫秒"
        else
            echo "- 本次$1用时：$ms毫秒"
        fi
}

Mount_Write() {
    GZai=$1
    Result=1
    echo "开始使用`which mount`挂载$2可读写$3"
    mount -o rw,remount $GZai
        if [[ -w /$2 ]]; then
            system=/system
            vendor=/vendor
            Result=0
            return 0
        elif [[ -w "$GZai" ]]; then
            Result=0
            if [[ "$GZai" = / ]]; then
                unset GZai
            elif [[ "$GZai" = $MAGISKTMP/.magisk/mirror/system_root ]]; then
                if [[ -w "$GZai/system" ]]; then
                    GZai="$GZai/system"
                    Result=0
                else
                    unset GZai
                    Result=1
                    return 1
                fi
            fi
            return 0
        fi
        echo "开始使用`busybox -where` mount挂载$2可读写$3"
        echo
        busybox mount -o rw,remount $GZai
            if [[ -w /$2 ]]; then
                system=/system
                vendor=/vendor
                Result=0
                return 0
            elif [[ -w "$GZai" ]]; then
                Result=0
                if [[ "$GZai" = / ]]; then
                    unset GZai
                elif [[ "$GZai" = $MAGISKTMP/.magisk/mirror/system_root ]]; then
                    if [[ -w "$GZai/system" ]]; then
                        GZai=$GZai/system
                        Result=0
                    else
                        unset GZai
                        Result=1
                        return 1
                    fi
                fi
            else
                unset GZai
                Result=1
                return 1
            fi
}


Check_Mount() {
    [[ "$Result" -eq 0 ]] && echo "挂载$1读写成功。"
    if [[ "$Result" -eq 1 ]]; then
        error "！您的`getprop ro.product.model`（Android `getprop ro.build.version.release`）设备未解锁system"
        echo -e "\n\n错误详情：\n"
        mount | grep -m 1 /system 1>&2
        abort
    fi
}

Mount_system() {
    mask
    Mount_Write /system system . 2>/dev/null
    if [[ $? -eq 1 ]]; then
        Mount_Write $MAGISKTMP/.magisk/mirror/system system .. 2>/dev/null
        if [[ $? -eq 1 ]]; then
            Mount_Write $MAGISKTMP/.magisk/mirror/system_root system ... 2>/dev/null
            if [[ $? -eq 1 ]]; then
                Mount_Write / system .... 2>/dev/null
            fi
        fi
    fi

    export system=${GZai:-/system}
    export audio="$system/media/audio/ui"
    Check_Mount system
    
    Unload(){
        mount -o ro,remount "$GZai" &>/dev/null
        [[ -w "$GZai" ]] && busybox mount -o ro,remount "$GZai" &>/dev/null
        #umount -r $GZai
    }
}

Mount_vendor() {
    mask
    Mount_Write /vendor vendor . 2>/dev/null
    if [[ $? -eq 1 ]]; then
        Mount_Write $MAGISKTMP/.magisk/mirror/vendor vendor .. 2>/dev/null
        if [[ $? -eq 1 ]]; then
            Mount_Write / vendor ... 2>/dev/null
        fi
    fi
    export vendor=${GZai:-/vendor}
    Check_Mount vendor
    
    
    Unload_vendor(){
        mount -o ro,remount "$GZai" &>/dev/null
        [[ ! -w "$GZai" ]] && busybox mount -o ro,remount "$GZai" &>/dev/null
        #umount -r $GZai
    }
}

grep_prop() {
    local J="s/^$1=//p"
    [[ -z "$2" ]] && { getprop $1; return $?; }
    [[ -f "$2" ]] && sed -n "$J" $2 2>/dev/null | head -n 1 || return 2
}

mkdir() {
    umask 022
    `$which mkdir` "$@"
}

touch() {
    umask 022
    `$which touch` "$@"
}

set_perm() {
    chown $2:$3 $1 || return 1
    chmod $4 $1 || return 1
    CON=$5
    [ -z $CON ] && CON=u:object_r:system_file:s0
    chcon $CON $1 || return 1
}

set_perm_recursive() {
    find $1 -type d 2>/dev/null | while read dir; do
        set_perm $dir $2 $3 $4 $6
    done
        find $1 -type f -o -type l 2>/dev/null | while read file; do
            set_perm $file $2 $3 $5 $6
        done
}

mktouch() {
    mkdir -p ${1%/*} 2>/dev/null
    [[ -z $2 ]] && touch "$1" || echo "$2" > "$1"
    chmod 644 "$1"
}

Write_Record() {
    local system=${system%/*}
    local jian=$MODPATH/Write_Record.sh
        cd $MODPATH
        for c in `find system`; do
            [[ -d "$c" ]] && continue
            if [[ -f "$system/$c" ]]; then
                #Original_file
                echo "$c文件存在源文件开始备份"
                dir=`dirname "$c"`
                mkdir -p "$MODPATH/Original_file/$dir"
                cp -arf "$system/$c" "$MODPATH/Original_file/$dir"
            else
                #Add_file
                echo "$system/$c文件属于新添加文件开始写入记录"
                echo "rm -f \$$c" >>$jian
            fi
        done
}

Inject_prop() {
    if [[ -f "$MODPATH/system.prop" ]]; then
        grep '^[^#]' "$MODPATH/system.prop" | while read i; do
            if ! grep -q ^"$i"$ "$system/build.prop"; then
                echo "$i" >>"$system/build.prop"
                echo "$i" >>"$MODPATH/build.prop"
        fi
        done
    fi
}

Delete_prop() {
    if [[ -f "$MODPATH/build.prop" ]]; then
        cat "$MODPATH/build.prop" | while read i; do
            sed -i "/"$i"/d" "$system/build.prop"
        done
    fi
}

End_installation() {
    lu="$MODPATH/system"
    Inject_prop
    case "$MODID" in
        riru_edxposed | riru_edxposed_sandhook)
            echo "- 已跳过模块启动脚本"
        ;;
        
        *)
            [[ -f "$MODPATH/service.sh" ]] && sh "$MODPATH/service.sh" &>/dev/null
            [[ -f "$MODPATH/post-fs-data.sh" ]] && sh "$MODPATH/post-fs-data.sh" &>/dev/null
        ;;
    esac
    [[ ! -d "$lu" ]] && ls "$MODPATH" >"$Status" && abort2 "\n！ "$MODNAME"安装失败"
    Write_Record
    cp -arf "$lu"/* "$system"
    [[ $? = 0 ]] && echo "- "$MODNAME"安装成功" && rm -rf "$lu" || abort "！$MODNAME安装失败"
    Unload
    if [[ -f "$MODPATH/module.prop" ]]; then
        echo "THE END"
        [[ "$Result" = 0 ]] && CQ
    else
        abort "！未在框架目录里找到module.prop"
    fi
}

check_ab_device() {
    . $ShellScript/Block_Device_Name.sh | egrep -q 'boot_a|boot_b'
    return $?
}

set_Game_Toolbox() {
    am force-stop com.miui.securitycenter
    set_perm /data/data/com.miui.securitycenter/files/gamebooster system system 700
    set_perm "$Game_Toolbox_File" system system 444
    echo "将在下次启动游戏时立即生效，不需要重启手机哦 ⊙∀⊙"
}

Check_Riru() {
    No_Riru() {
        error "*********************************************************"
        error "！未安装Riru - Core 框架，安装失败！！！"
        abort "*********************************************************"
    }
        if [[ ! -f "/data/misc/riru/api_version" && ! -f "/data/misc/riru/api_version.new" ]]; then
            No_Riru
        fi
}

Frame_installation_Check() {
    if [[ -d "$Modules_Dir/$MODID" ]]; then
        abort -e "！已检测到用Magisk模块方式安装了$MODID，无法再次安装\n模块安装目录：\"$Modules_Dir/$MODID\""
    fi
}

Play_Music() {
    am start -n $Package_name/com.projectkr.shell.MusicPlayer --es music "$1" 1>/dev/null
}

Power() {
    echo "`cat /sys/class/power_supply/battery/capacity 2>/dev/null`%"
}

module_prop() {
    echo "- 正在打印模块信息……"
cat <<Han >$Module_XinXi
id=$id
name=$name
version=$version
versionCode=$versionCode
author=$author
description=$description
Han
}

Clean_install() {
    [[ -z "$id" ]] && abort"！未设置id"
    mask $id
    rm -rf $Module
    mkdir -p $Module
    ui_print "- 开始安装 $name-$version($versionCode)"
    ui_print "- 安装目录：$Module"
    ui_print "- 模块作者：$author"
    ui_print "- Powered by Magisk & topjohnwu"
    abort() {
        rm -rf $Module
        error "$@"
        sleep 3
        exit 1
    }
}

Notice() {
cat <<End
    <group>
        <text>
            <title>📢公告</title>
            <desc>当前为离线模式，部分功能可能无法正常使用，不接受反馈，若需使用请更换在线模式
            </desc>
        </text>
    </group>
End
}