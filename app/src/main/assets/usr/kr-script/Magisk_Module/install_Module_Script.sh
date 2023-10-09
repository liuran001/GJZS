#本脚本由　by Han | 情非得已c，编写
#应用于搞机助手上
#$1定义是否使用兼容模式
#$2定义屏蔽错误显示
#$3定义文件
#$4定义是否下载
#$5定义传给配置文件的$1变量


. $Core

# START:KernelSU
if [[ $Magisk_Type = ksu ]]; then
    echo '检测到 KernelSU，执行标准模块安装方式'
    echo '注意：目前 KernelSU 为实验性支持，可能存在未知问题'
    echo '---'
    ZIPFILE="$3"
    $Ksud module install "$ZIPFILE"
    echo '---'
    echo '安装线程退出'
    exit 0
fi
# END:KernelSU

# Magisk
if [[ $1 = -Do_Not_Check ]]; then
    shift
    mask
else
    mask -vc
fi
[[ $? -ne 0 ]] && exit 1


Compatible="$1"
Error="$2"
ZIPFILE="$3"
Choice="$4"
Download_ID="$5"
TMPDIR=/dev/tmp
INSTALLER=$TMPDIR
AUTOMOUNT=false
SKIPMOUNT=false
PROPFILE=false
POSTFSDATA=false
LATESTARTSERVICE=false
PERSISTDIR=$MAGISKTMP/.magisk/mirror/persist
PATH="$PATH:$MAGISKTMP/.magisk/busybox"


copy_sepolicy_rules() {
    # Remove all existing rule folders
    rm -rf /data/unencrypted/magisk /cache/magisk /metadata/magisk /persist/magisk /mnt/vendor/persist/magisk
    
    # Find current active RULESDIR
    local RULESDIR
    local active_dir=$MAGISKTMP/.magisk/mirror/sepolicy.rules
        if [ -L $active_dir ]; then
            RULESDIR=$(readlink $active_dir)
        elif [ -d /data/unencrypted ] && ! grep ' /data ' /proc/mounts | grep -qE 'dm-|f2fs'; then
            RULESDIR=/data/unencrypted/magisk
        elif grep -q ' /cache ' /proc/mounts; then
            RULESDIR=/cache/magisk
        elif grep -q ' /metadata ' /proc/mounts; then
            RULESDIR=/metadata/magisk
        elif grep -q ' /persist ' /proc/mounts; then
            RULESDIR=/persist/magisk
        elif grep -q ' /mnt/vendor/persist ' /proc/mounts; then
            RULESDIR=/mnt/vendor/persist/magisk
        else
            return
        fi
        
        # Copy all enabled sepolicy.rule
        spr='/data/adb/modules*/*/sepolicy.rule'
        [[ $Magisk_Type = lite ]] && spr='/data/adb/lite_modules*/*/sepolicy.rule'
	    for r in $spr; do
    	    [ -f "$r" ] || continue
        	local MODDIR=${r%/*}
        	[ -f $MODDIR/disable ] && continue
        	[ -f $MODDIR/remove ] && continue
        	local MODNAME=${MODDIR##*/}
        	mkdir -p $RULESDIR/$MODNAME
        	cp -f $r $RULESDIR/$MODNAME/sepolicy.rule
    	done
}

dummy() {
    rm -rf $Script_Dir &>/dev/null
    mkdir -p $Script_Dir
    unzip -p "$ZIPFILE" 'META-INF/com/google/android/update-binary' &>$jian
    echo "- 正在安装「$M」……"
        if [[ -s $jian ]]; then
            sh $jian dummy 1 "$ZIPFILE"
        else
            if [[ $Error = 1 ]]; then
                exec 2>&3
                exec 3>&-
            fi
            abort "！未找到update-binary文件，无法刷入"
        fi
        rm -rf $Script_Dir &>/dev/null
}


if [[ $Choice -eq 1 ]]; then
    . $Load $Download_ID
    ZIPFILE="$Download_File"
fi
    M=${ZIPFILE##*/}
    [[ ! -f "$ZIPFILE" ]] && abort "！$ZIPFILE 文件不存在无法刷入"
    unzip -p "$ZIPFILE" 'META-INF/com/google/android/updater-script' | fgrep '#MAGISK' &>/dev/null || abort "「$M」不是Magisk模块.zip！无法刷入"
    
    if [[ $Error = 1 ]]; then
        exec 3>&2
        exec 2>/dev/null
    fi
        if [[ $Compatible -eq 1 ]]; then
            echo "- 正在已「兼容模式」安装「$M」……"
            . $ShellScript/Geek/util_functions.sh
            rm -rf "$TMPDIR"
            mkdir -p "$TMPDIR"
            unzip -oq "$ZIPFILE" "module.prop" -d $TMPDIR
                if [[ -f $TMPDIR/module.prop ]]; then
                    MODDIRNAME=modules
                    [[ $Magisk_Type = lite ]] && MODDIRNAME=lite_modules
                    MODULEROOT=/data/adb/${MODDIRNAME}_update
                    MODID=`grep_prop id $TMPDIR/module.prop`
                    MODNAME=`grep_prop name $TMPDIR/module.prop`
                    MODAUTH=`grep_prop author $TMPDIR/module.prop`
                    MODPATH="$MODULEROOT/$MODID"
                    MODPATH0="$Modules_Dir/$MODID"
                    echo "- 模块被安装在：$MODPATH0"
                    echo "- 模块名称：$MODNAME"
                    echo "- 模块作者：$MODAUTH"
                else
                    echo -e "\n！温馨提示：「$M 」未找到module.prop文件\n---------------------------------------------------------\n\n"
                fi
                    if [[ -n $MODID ]]; then
                        rm -rf "$MODPATH"
                        mkdir -p "$MODPATH"
                    fi
            
            Installation_script() {
                unzip -l "$ZIPFILE" $1 | grep -q $1
                return $?
            }
            
            print_modname() {
              ui_print "*************************"
              ui_print "- Powered by Magisk"
              ui_print "*************************"
            }
            
            
            mount_partitions
            api_level_arch_detect
            
            [[ -n $MODNAME ]] && echo "- - 正在安装「$MODNAME」"
            if Installation_script install.sh; then
                A=1
                echo "- 开始解压install.sh安装脚本"
                unzip -ojq "$ZIPFILE" install.sh uninstall.sh 'common/*' -d $TMPDIR &>/dev/null
            elif Installation_script config.sh; then
                A=1
                echo "- 开始解压config.sh安装脚本"
                unzip -oq "$ZIPFILE" config.sh uninstall.sh 'common/*' -d $TMPDIR &>/dev/null
                unzip -oq "$ZIPFILE" 'system/*' -d $MODPATH  &>/dev/null
                [[ -f $TMPDIR/config.sh ]] && mv -f $TMPDIR/config.sh $TMPDIR/install.sh
                [[ -n `ls $TMPDIR/common` ]] && mv -f $TMPDIR/common/* $TMPDIR
            fi
                    if [[ $A = 1 ]]; then
                         . $TMPDIR/install.sh
                         
                         print_modname
                         on_install
                         
                         [ -f $TMPDIR/uninstall.sh ] && cp -af $TMPDIR/uninstall.sh $MODPATH/uninstall.sh
                         { $AUTOMOUNT && touch $MODPATH/auto_mount; } || { $SKIPMOUNT && touch $MODPATH/skip_mount; }
                         $PROPFILE && cp -af $TMPDIR/system.prop $MODPATH/system.prop
                         cp -af $TMPDIR/module.prop $MODPATH/module.prop
                         $POSTFSDATA && cp -af $TMPDIR/post-fs-data.sh $MODPATH/post-fs-data.sh
                         $LATESTARTSERVICE && cp -af $TMPDIR/service.sh $MODPATH/service.sh
                         
                         ui_print "- 开始设置权限"
                         set_permissions
                         
                    elif Installation_script customize.sh; then
                        print_modname
                        echo "- 开始解压customize.sh安装脚本"
                        unzip -oq "$ZIPFILE" customize.sh -d $MODPATH  &>/dev/null
            
                            if ! grep -q '^SKIPUNZIP=1$' $MODPATH/customize.sh 2>/dev/null; then
                                ui_print "- 提取模块文件"
                                unzip -oq "$ZIPFILE" -x 'META-INF/*' -d $MODPATH  &>/dev/null
                            fi
                        [ -f $MODPATH/customize.sh ] && . $MODPATH/customize.sh
                    else
                        echo "- 未找到安装脚本，已自动关闭兼容模式开始安装"
                        dummy
                    fi
            
                            for TARGET in $REPLACE; do
                                ui_print "- 更换目标: $TARGET"
                                mktouch $MODPATH$TARGET/.replace
                            done
            
                                if [[ -f $MODPATH/sepolicy.rule ]]; then
                                    ui_print "- 安装自定义Sepolicy补丁"
                                    copy_sepolicy_rules
                                fi
            rm -rf \
            $MODPATH/system/placeholder $MODPATH/customize.sh \
            $MODPATH/README.md $MODPATH/.git* $TMPDIR &>/dev/null
            
            mktouch "$MODPATH0/update"
            cp -f "$MODPATH/module.prop" "$MODPATH0/module.prop"
            ui_print -e "\n- $MODNAME模块安装完成。"
        else
            dummy
        fi
        echo "THE END"
        CQ
        exit 0
