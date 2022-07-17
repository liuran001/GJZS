#Custom variable
export Util_Functions_Code=2022071801
export SDdir=/data/media/0
export Magisk=`$which magisk`
export Modules_Dir=/data/adb/modules
if $Have_ROOT; then
	if [[ -x $Magisk ]]; then
		[[ `$Magisk -v | grep 'alpha'` != '' ]] && export Magisk_Type=alpha
		[[ `$Magisk -v | grep 'lite'` != '' ]] && export Magisk_Type=lite
		[[ $Magisk_Type = lite ]] && export Modules_Dir=/data/adb/lite_modules
	fi
fi
export Script_Dir=$TMPDIR/tmp
export install_MOD=$ShellScript/Magisk_Module/install_Module_Script.sh
export install_Frame=$ShellScript/Geek/install_Frame_Script.sh
export Install_Method=$ShellScript/Geek/Installation_Check.sh
export APK_Name_list=$Data_Dir/APK_Name.log
export APK_Name_list2=$Data_Dir/APK_Name2.log
export jian="$Script_Dir/update-binary"
export jian2="$Script_Dir/updater-script"
export Frame_Dir=/data/misc/$Package_name
export Charging_control=/sys/class/power_supply/battery/input_suspend
export Charging_control2=/sys/class/power_supply/battery/charging_enabled
export Game_Toolbox_File=/data/data/com.miui.securitycenter/files/gamebooster/freeformlist
export Status=$Data_Dir/Status.log
export Termux=$DATA_DIR/com.termux/files
export BOOTMODE=true
export Choice=0
if [[ -f "$ShellScript/APP_Version.sh" ]]; then
    . $ShellScript/APP_Version.sh
else
    export New_Version=1
    export New_Code=1
fi
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
        Download "$@"
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
                                    [[ $ABI = x86 ]] && mv -f "$ELF2_Path/x86/"* "$ELF2_Path"
                                    [[ $ABI = x86_64 ]] && mv -f "$ELF2_Path/x86_64/"* "$ELF2_Path"
                                ;;
                            esac
                            echo "- $name-$versionCode安装成功。"
                            rm -rf "$Download_File" $ELF2_Path/{arm,arm64,x86,x86_64}
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

    Start_Install() { CloudBusybox="$8"; }
        . "$Load" Install_busybox

    Start_Install() {
        Download "$@"
        if [[ -f "$Download_File" ]]; then
            BusyBox2=$ELF4_Path/busybox
            [[ ! -d $ELF4_Path ]] && mkdir -p "$ELF4_Path" && chown $APP_USER_ID:$APP_USER_ID $ELF4_Path || rm -f $ELF4_Path/*
            cp "$Download_File" "$BusyBox2" && chmod 700 $BusyBox2
            echo "- 正在安装busybox-$Type版-$7($8)"
            "$BusyBox2" --install -s "$ELF4_Path" &>/dev/null
                if [[ -L "$ELF4_Path/true" ]]; then
                    echo "- busybox-$Type版-$7($8)安装成功。"
                    echo "$8" >$JCe
                    chown $APP_USER_ID:$APP_USER_ID "$BusyBox2"
                    rm -f $Download_File
                else
                    echo "！busybox安装失败❌"
                    rm -f "$BusyBox2"
                    sleep 3
                fi
        fi
    }

        if [[ -z "$JCe2" || ! -L $ELF4_Path/true ]]; then
            echo "- 开始安装busybox"
            . "$Load" Install_busybox
        elif [[ "$JCe2" -lt "$CloudBusybox" ]]; then
            echo "- 开始更新busybox"
            . "$Load" Install_busybox
        fi
}

Installing_Busybox() {
    Install_curl
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

CURL() {
    local v=`getprop ro.build.version.release`
    local model="`getprop ro.product.model`"
    [[ -z "$v" ]] && v=11
    [[ -z "$model" ]] && model='Redmi K30 5G'

    curl -A "Mozilla/5.0 (Linux; Android $v; $model) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/93.0.4577.62 Mobile Safari/537.36 GJZS/9.20" "$@"
}

WGET() {
    local v=`getprop ro.build.version.release`
    local model="`getprop ro.product.model`"
    [[ -z "$v" ]] && v=11
    [[ -z "$model" ]] && model='Redmi K30 5G'

    wget -U "Mozilla/5.0 (Linux; Android $v; $model) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/93.0.4577.62 Mobile Safari/537.36 GJZS/9.20" "$@"
}

XiaZai() {
    local code
    echo none >"$Status"
    if [[ "$#" -lt 3 ]]; then
        echo 2 >"$Status"
        abort "！没有参数无法下载"
    fi
        local dir
            dir=${3%/*}
            if [[ ! -d "$dir" ]]; then
                echo 2 >"$Status"
                abort "！No such \"$dir\" directory"
            fi
            	[[ "$#" -eq 4 ]] && CURL $1 -C - -o "$3" -w "- HTTP状态码：%{http_code}\n" -kL "$2" -e "$4" || CURL $1 -C - -o "$3" -w "- HTTP状态码：%{http_code}\n" -kL "$2"
                code=$?
                echo "$code" >"$Status"
                [[ $code -eq 6 ]] && error "！未连接到互联网"
                [[ $code -ne 0 ]] && error "！错误代码：$code"
}

EndMD5() {
    if [[ "$File_MD5" = '' ]];then
        echo '- 无MD5信息，跳过检验'
    else
        md5_down=`md5sum "$Download_File" | sed 's/ .*//g'`
        if [[ "$File_MD5" != "$md5_down" ]]; then
           Deleting_file
           abort2 "！ ["$File_Name"] MD5校验失败✘，如果一直无法下载请在搞机助手功能区 -->刷新搞机助手云端状态后重试，或者在关于页面里发送邮件我处理"
        else
           echo "- ["$File_Name"]文件MD5校验成功✔"
           echo "- MD5=$md5_down"
          return 0
        fi
    fi
}

Start_Download() {
    Check_command2() {
        $1 -where &>/dev/null
        return $?
    }

    local Download_File2 File_Type YiXZ YiXZ_2 YiXZ_SuDu Remaining_Time Percentage Size2 md5_down code
    Download_File2="$2"
        if Check_command2 awk && Check_command2 wc && Check_command2 md5sum; then
            Start_Time
            XiaZai -sL "$@" &
            code=`cat "$Status"`
            [[ $code = 2 || $code = 6 ]] && abort
                until [[ -f "$Download_File2" ]]; do
                    [[ `cat "$Status"` != none ]] && break
                done
                    echo "- 连接服务器成功"
                    if [[ $File_Size -ge 1048576 ]]; then
                        File_Type=`awk "BEGIN{print $File_Size/1048576}"`MB
                    elif [[ $File_Size -ge 1024 ]]; then
                        File_Type=`awk "BEGIN{print $File_Size/1024}"`kb
                    elif [[ $File_Size -le 1024 ]]; then
                        File_Type=${File_Size}b
                    fi
                    echo "- 正在下载 [$File_Name2]，文件总大小：${File_Type}"
                    echo -e "\n-----------------------------------------"
                    [[ `cat "$Status"` != none ]] && End_Time 下载 && EndMD5
                        until [[ $code != none ]]; do
                           YiXZ=`ls -l $Download_File2 | awk '{print $5}'`
                           sleep 1
                           YiXZ_2=`ls -l $Download_File2 | awk '{print $5}'`
                               if [[ $YiXZ -gt 0 ]]; then
                                   YiXZ_SuDu=$(($YiXZ_2-$YiXZ))
                                   Remaining_Time=`awk "BEGIN{print ($File_Size-$YiXZ_2)/$YiXZ_SuDu}" 2>/dev/null`
                                   Remaining_Time=${Remaining_Time:-0}
                                   Percentage=`awk "BEGIN{print $YiXZ_2/($File_Size/100)}" 2>/dev/null`
                                   show_progress ${Percentage%.*}
                                       if [[ $YiXZ_2 -ge 1048576 ]]; then
                                           Size2=`awk "BEGIN{print $YiXZ_2/1048576}"`MB
                                       elif [[ $YiXZ_2 -ge 1024 ]]; then
                                           Size2=`awk "BEGIN{print $YiXZ_2/1024}"`kb
                                       elif [[ $YiXZ_2 -le 1024 ]]; then
                                           Size2=${YiXZ_2}b
                                       fi
                                           Schedule() { echo "- 已下载：${Size2}/$File_Type 已完成${Percentage}%" ; echo "-----------------------------------------"; }
                                           if [[ $YiXZ_SuDu -ge 1048576 ]]; then
                                               echo -n "- 正在飞一般的下载：`awk "BEGIN{print $YiXZ_SuDu/1048576}"`MB/s"; echo " 剩余时间$Remaining_Time/s"; Schedule
                                           elif [[ $YiXZ_SuDu -ge 1024 ]]; then
                                               echo -n "- 正在慢速下载：`awk "BEGIN{print $YiXZ_SuDu/1024}"`kb/s"; echo " 剩余时间$Remaining_Time/s"; Schedule
                                           elif [[ $YiXZ_SuDu -lt 1024 && $YiXZ_SuDu -gt 0 ]]; then
                                               echo -n "- 正在龟速下载：${YiXZ_SuDu}b/s"; echo " 剩余时间$Remaining_Time/s"; Schedule
                                           elif [[ $YiXZ_SuDu -eq 0 ]]; then
                                               code=`cat "$Status"`
                                               if [[ $code = 0 ]]; then
                                                   [[ $Options = -split ]] && break
                                                   echo "- 下载完成，开始MD5校验……"
                                                   End_Time 下载
                                                   EndMD5
                                               else
                                                   Schedule
                                                   echo "- 与服务器连接已断开，如果网络正常或别的资源可以下请私信我修复……"
                                                   sleep 1
                                               fi
                                           fi
                               fi
                done
        else
        	echo "- 正在下载 [$File_Name2]配置文件……文件总大小：${File_Size}b"
            Start_Time
            XiaZai "" "$@"
            End_Time 下载
            EndMD5
        fi
}

Download() {
    if [[ "$#" -lt 5 ]]; then
        abort "！没有参数无法提供下载"
    fi

    Deleting_file() {
        rm -rf "$PeiZhi_File/$Delete"*
    }

    MD5() {
        if [[ -f "$Download_File" ]]; then
            if [[ "$File_MD5" = '' ]];then
                Deleting_file
                return 1
            else
                md5_down=`md5sum "$Download_File" | sed 's/ .*//g'`
                if [[ "$File_MD5" != "$md5_down" ]]; then
                    Deleting_file
                    echo "- 文件已升级正在重新下载"
                    return 1
                else
                    return 0
                fi
            fi
        else
                Deleting_file
                echo "- 正在连接服务器下载中……"
                return 1
        fi
    }



    local Han Options ID File_Name2 File_Size Delete split_size Total_size n size xsize PeiZhi_File0
    Han=0
    Options="$1"
    ID="$2"
        case "$Options" in
            -url)
                shift
                Link="$ID"
            ;;
            -coding)
                shift
                Link="https://qqcn.coding.net/p/import-rt20/d/GJZS-Warehouse/git/raw/main/$ID"
            ;;
            -file)
                shift
                Link="https://s1.gjzsr.com:2083/GJZS/$ID"
            ;;
            -gh)
                shift
                Link="https://ghproxy.com/?q=https://github.com/$ID"
            ;;
            -cos)
                shift
                Link="https://s1.gjzsr.com:2083/file/$ID"
            ;;
            *)
                abort "！暂不支持下载"
            ;;
        esac
        
        File_Name="$2"
        if [[ "$3" != '' ]]; then
            File_Size="$3"
        else
            File_Size=`CURL --head "$Link" -sL | grep Content-Length | awk '{print $2}'`
        fi
        File_MD5="$4"
        Delete="$5"
        Download_File="$PeiZhi_File/$File_Name"
        MD5
        [[ $? -eq 0 ]] && return 0
        File_Name2="$File_Name"
        Start_Download "$Link" "$Download_File"
}

downloader() {
    #代码来自https://u.qqcn.xyz/QkccEM
    local downloadUrl="$2"
    local md5="$3"
    downloader_result=""
    local hisotry="$HOME/downloader/path/$md5"
    if [[ -f "$hisotry" ]]; then
        local abs_path=`cat "$hisotry"`
        if [[ -f "$abs_path" ]]; then
            local local_file=`md5sum "$abs_path"`
            if [[ "$local_file" = "$md5" ]]; then
                downloader_result="$abs_path"
                return
            fi
        fi
    fi
    local task_id=`cat /proc/sys/kernel/random/uuid`
    activity="$Package_name/.ActionPageOnline"
    am start -a android.intent.action.MAIN -n "$activity" --es downloadUrl "$downloadUrl" --ez autoClose true --es taskId "$task_id" 1 > /dev/null
    local task_path="$HOME/downloader/status/$task_id"
    local result_path="$HOME/downloader/result/$task_id"
    while [[ '1' = '1' ]]
    do
        if [[ -f "$task_path" ]]; then
            local status=`cat "$task_path"`
            if [[ "$status" = 100 ]] || [[ -f "$result_path" ]]; then
                echo "progress:[$status/100]"
                break
            elif [[ "$status" -gt 0 ]]; then
                echo "progress:[$status/100]"
            elif [[ "$status" = '-1' ]]; then
                echo '文件下载失败' 1>&2
                return 10
            fi
        fi
        sleep 1
    done
    if [[ "$md5" != "" ]]; then
        local hisotry="$HOME/downloader/path/$md5"
        if [[ -f "$hisotry" ]]; then
            downloader_result=`cat "$hisotry"`
        else
            echo '下载完成，但文件MD5与预期的不一致' 1>&2
        fi
    else
        downloader_result=`cat $HOME/downloader/result/$task_id`
    fi
    [[ -f $downloader_result ]] && cp $downloader_result "$1"
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
if [[ -n $desc1 ]]; then
cat <<End
    <group>
        <text>
            <title>📢公告</title>
            <desc>`echo -e $desc1`</desc>
        </text>
    </group>
End
fi
}
