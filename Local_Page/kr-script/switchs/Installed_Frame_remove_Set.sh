#本脚本由　by Han | 情非得已c，编写
#应用于搞机助手上


Delete_Frame_File() {
    MODPATH="$Frame_Dir/$1"
    [[ ! -d $MODPATH ]] && abort "已检测到您格式化过data数据，找不到写入记录文件，无法卸载"$2"框架服务！"
    echo "- 开始卸载$2框架服务"
    Delete_prop
    [[ -d "$MODPATH/Original_file" ]] && cp -arf "$MODPATH/Original_file/system"/* "$system"
    sh $MODPATH/Write_Record.sh &>/dev/null
}

Delete_cache() {
    if [[ -d /data/system/package_cache ]]; then
        rm -rf /data/system/package_cache
    fi
}

if [[ $state = 0 ]]; then
    touch $Frame_Dir/$1/remove &>/dev/null
    [[ -f "$Frame_Dir/$1/uninstall.sh" ]] && sh "$Frame_Dir/$1/uninstall.sh" &>/dev/null
else
    rm -rf $Frame_Dir/$1/remove &>/dev/null
fi


[[ ! -w $GZai ]] && Mount_system
if [[ -f $Frame_Dir/riru-core/remove ]]; then
RANDOM_NAME_FILE="/data/adb/riru/random_name"
RANDOM_NAME=$(cat "$RANDOM_NAME_FILE")
    mv -f $system/lib/lib$RANDOM_NAME.so $system/lib/libmemtrack.so &>/dev/null
    mv -f $system/lib64/lib$RANDOM_NAME.so $system/lib64/libmemtrack.so &>/dev/null
    Delete_Frame_File riru-core "Riru（Riru - Code）"
    
elif [[ -f $Frame_Dir/riru_edxposed/remove ]]; then
    Delete_Frame_File riru_edxposed "EDXposed-YAHFA"

elif [[ -f $Frame_Dir/riru_edxposed_sandhook/remove ]]; then
    Delete_Frame_File riru_edxposed_sandhook "EDXposed-SandHook"

elif [[ -f $Frame_Dir/riru_storage_redirect/remove ]]; then
    Delete_Frame_File riru_storage_redirect "存储重定向增强模式"

elif [[ -f $Frame_Dir/AD-Hosts/remove ]]; then
    Delete_Frame_File AD-Hosts "AD Hosts"

elif [[ -f $Frame_Dir/Fluid-NG/remove ]]; then
    pm uninstall --user 0 com.fb.fluid &>/dev/null
    pm uninstall com.fb.fluid &>/dev/null
    Delete_cache

elif [[ -f $Frame_Dir/Gesture/remove ]]; then
    pm uninstall --user 0 com.omarea.gesture &>/dev/null
    pm uninstall com.omarea.gesture &>/dev/null
    Delete_cache

fi

    rm -rf "$Frame_Dir/$1" &>/dev/null
    rmdir -p "$Frame_Dir" &>/dev/null
    sleep 2