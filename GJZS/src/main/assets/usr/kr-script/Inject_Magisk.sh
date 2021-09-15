##本脚本由　by Han | 情非得已c，编写
#应用于搞机助手上


Check_Magisk() {
    unzip -l "$File" $1 | grep -q $1
    return $?
}


if [[ -z "$File" ]]; then
    abort "请选择文件路径不可为空哦﻿⊙∀⊙！"
elif [[ ! -f "$File" ]]; then
    abort "\"${File}\"文件不存在无法此功能！"
fi

if ! Check_Magisk META-INF/com/google/android/updater-script; then
    error "！ 查看未知的压缩内部文件"
    unzip -l "$File" 1>&2
    sleep 2
    echo
    echo
    abort "！未从卡刷里找到META-INF/com/google/android/updater-script脚本文件，无法注入，请确保您选择的是卡刷包文件"
fi


echo "正在往卡刷包里添加Magisk"

File1=${File%.*}
File2=${File##*.}
File3="${File1}_and_Magisk.$File2"
Script=$Script_Dir/META-INF/com/google/android/updater-script

[[ -d $Script_Dir ]] && rm -rf $Script_Dir &>/dev/null
mkdir -p $Script_Dir/Han.GJZS


if [[ $Option2 = 1 ]]; then
    [[ ! -f "$Magisk_File" ]] && abort "自定义的$Magisk_File 文件不存在无法注入！"
    cp -f "$Magisk_File" $Script_Dir/Han.GJZS/Magisk.zip
    unzip -oq "$Magisk_File" 'common/util_functions.sh' -d $Script_Dir
    MAGISK_VER=`grep_prop MAGISK_VER $Script_Dir/common/util_functions.sh`
    MAGISK_VER=`echo $MAGISK_VER | tr -d \"`
    MAGISK_VER_CODE=`grep_prop MAGISK_VER_CODE $Script_Dir/common/util_functions.sh`
    rm -rf $Script_Dir/common
    version="Magisk-$MAGISK_VER-($MAGISK_VER_CODE)".zip
else
    Choice=1
    . $Load com.topjohnwu.magisk
    cp -f "$Download_File" $Script_Dir/Han.GJZS/Magisk.zip
    version="$name-$version($versionCode).zip"
fi

unzip -oq $File 'META-INF/com/google/android/updater-script' -d $Script_Dir

if ! Check_Magisk Han.GJZS/Magisk.zip; then
cat <<Han >>$Script
ui_print("- 开始安装 $version...");
ui_print("- 由「搞机助手」一键注入");
run_program("/sbin/mkdir", "-p", "/tmp/Han.GJZS");
package_extract_file("Han.GJZS/Magisk.zip", "/tmp/Han.GJZS/Magisk.zip");
run_program("/sbin/unzip", "-oq", "/tmp/Han.GJZS/Magisk.zip", "META-INF/com/google/android/update-binary", "-d", "/tmp/Han.GJZS");
run_program("/sbin/sh", "/tmp/Han.GJZS/META-INF/com/google/android/update-binary", "dummy", "1", "/tmp/Han.GJZS/Magisk.zip");
Han
fi


cd $Script_Dir
if [[ $Option = 0 ]]; then
    echo "已选择保留源文件……"
    cp -f "$File" "$File3"
    echo
    echo "开始打包……"
    zip -rq "$File3" ./*
    if [[ $? = 0 ]]; then
        echo "文件已保存到：$File3"
    else
        error "注入失败"
    fi
elif [[ $Option = 1 ]]; then
    echo "已选择不保留源文件……"
    echo
    echo "开始打包……"
    zip -rq "$File" ./*
    if [[ $? = 0 ]]; then
        echo "文件已保存到：$File"
    else
        error "注入失败"
    fi
fi

rm -rf $Script_Dir
