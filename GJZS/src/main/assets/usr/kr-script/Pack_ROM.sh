#本脚本由　by Han | 情非得已c，编写
#应用于搞机助手上


[[ -z "$IMG" ]] && abort "！分区都不选打包空气？？？"
device=`getprop ro.product.device`
version=`getprop ro.build.version.incremental`
TMP=$Dir/$device-${version}-${Type}-by_Han_${Time}
[[ ! -d $TMP ]] && mkdir -p $TMP



if [[ $Type = Card_Brush ]]; then
    Script_Dir=$TMP/META-INF/com/google/android
    [[ ! -d $Script_Dir ]] && mkdir -p $Script_Dir
    Script="$TMP/META-INF/com/google/android/updater-script"
    ScriptB="$TMP/META-INF/com/google/android/update-binary"
    
    echo "- 已选择卡刷模式"

cat <<Han >$ScriptB
#!/sbin/sh
#by Han　|　情非得已c


ui_print() {
    echo "ui_print "\$@"" > /proc/self/fd/\$OUTFD
}

abort() {
    ui_print "\$@"
    sleep 3
    rm -rf /dev/Han.GJZS &>/dev/null
    exit 1
}


umask 022
OUTFD="\$2"
ZIPFILE="\$3"
mask=/dev/Han.GJZS/Magisk
img=/dev/Han.GJZS/img
device=\`getprop ro.product.device\`


Han
        if [[ $Verify = 1 ]]; then
            echo "- 已添加机型验证，别的机型无法刷入此包"
            echo
            echo
cat <<Han >>$ScriptB
if [[ \$device != "$device" ]]; then
    ui_print "此卡刷包只适配 \"$device\" 设备; 您的设备是：\$device"
    exit 1
fi

Han
        fi
cat <<Han >>$ScriptB
ui_print "- 本卡刷包由「搞机助手」打包而成"
ui_print " "
ui_print "- by Han　|　情非得已c"
ui_print " "
ui_print "- 当前设备：\$device"


rm -rf /dev/Han.GJZS
mkdir -p "\$img"
unzip -o "\$ZIPFILE" '*.img' -d "\$img" &>/dev/null
[[ \$? -ne 0 ]] && abort "！解压镜像.img文件失败，可能存储空间不足"
Han
        
        
        for i in $IMG; do
            e=${i##*/}
            echo "- 正在提取$e分区……"
            dd if="$i" of="$TMP/$e".img
cat <<Han >>$ScriptB
ui_print "- 正在刷写$e分区……"
dd if="\$img/$e.img" of="$i" &>/dev/null
[[ \$? -ne 0 ]] && abort "！刷写$e分区失败" || ui_print "- 正在刷写$e分区完成。"
Han
        done

                if [[ $ROOT = 1 ]]; then
                    Choice=1
                    echo "- 正在往卡刷包里添加Magisk……"
                    . $Load com.topjohnwu.magisk
                    cp -f $Download_File $TMP/Magisk.zip
                    version="$name-$version（$versionCode）".zip
cat <<Han >>$ScriptB
ui_print "- 开始安装 $version..."
ui_print "- Magisk作者： $author"
mkdir -p "\$mask"
unzip -oq "\$ZIPFILE" 'Magisk.zip' -d "\$mask" &>/dev/null
unzip -oq "\$mask/Magisk.zip" 'META-INF/com/google/android/update-binary' -d "\$mask"
sh "\$mask/META-INF/com/google/android/update-binary" dummy "\$OUTFD" "\$mask/Magisk.zip"
Han
                fi
echo 'rm -rf /dev/Han.GJZS &>/dev/null
exit 0' >>$ScriptB


elif [[ $Type = Wire_Brush ]]; then
    Script="$TMP/flash_all.sh"
    TMP2=$TMP/images
    [[ ! -d $TMP2 ]] && mkdir -p $TMP2
    echo "- 已选择线刷模式"
cat <<Han >$Script
#!/system/bin/sh

#by Han　|　情非得已c


abort() {
   echo "\$@"
   sleep 3
   exit 1
}


echo "- 本线刷包由「搞机助手」打包而成"
echo
echo "- by Han　|　情非得已c"
echo
Han

        if [[ $Verify = 1 ]]; then
            echo "- 已添加机型验证，别的机型无法刷入此包"
            echo
            echo
cat <<Han >>$Script
fastboot getvar product 2>&1 | grep "^product: *$device$"
    if [ \$? -ne 0 ] ; then echo "您的设备不是$device，无法刷入"; exit 1; fi

Han
        fi
            for i in $IMG; do
                e=${i##*/}
                echo "- 正在提取$e分区……"
                dd if="$i" of="$TMP/$e".img
cat <<Han >>$Script
echo "- 正在刷写$e分区……"
fastboot flash $e \`dirname \$0\`/images/${e}.img
[[ \$? -ne 0 ]] && abort "！刷写$e分区失败"
echo
Han
            done

cat <<Han >>$Script
echo "- 正在重启手机"
fastboot reboot
echo "- 线刷完成"
echo "- 用时$SECONDS秒"
Han
fi

    echo
    echo "- 开始打包ROM为zip格式……"
    File="${TMP}.zip"
    cd $TMP
    zip -r "$File" ./*
        if [[ $? = 0 ]]; then
            echo "打包成功"
            rm -r $TMP
        else
            rm -f ${TMP}.zip
            error "！自动打包失败！！！"
            abort "！请前往$TMP目录里用其它压缩软件，压缩格式选zip格式，打包$TMP目录里的所有文件"
        fi
            if [[ $Type = Card_Brush ]]; then
                echo "- 警告：卡刷时不要勾选「zip刷机包签名校验」否则会无法刷入"
            fi
