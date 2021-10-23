abort() {
    echo "$@" 1>&2
    sleep 3
    exec exit 1
}


Script_Dir=$TMPDIR/Script_Dir
jian=`cat ~/downloader/path/* 2>/dev/null`
jian2=$Script_Dir/META-INF/com/google/android/update-binary

[[ ! -f "$jian" ]] && abort "！未下载文件"
echo "文件路径：$jian"

if [[ $1 = -apk ]]; then
    echo "- 开始安装搞机助手-CMD版.apk，如果未能重启搞机助手请手动重启"
    sleep 3
    pm uninstall $Package_name
    cp -f "$jian" "$TMP/$Package_name.apk"
    pm install -r "$TMP/$Package_name.apk"
    rm -f "$TMP/$Package_name.apk"
    $Have_ROOT && am start -S $Package_name/gjzs.online.SplashActivity
    exit 0
fi


echo "- 开始安装curl"
rm -rf $Script_Dir
mkdir -p $Script_Dir
unzip -oq "$jian" 'META-INF/com/google/android/update-binary' -d $Script_Dir

if [[ -f "$jian2" ]]; then
    sh "$jian2" $1 1 "$jian"
        if $Have_ROOT; then
            echo "- 已安装完成开始重启搞机助手"
            sleep 3
            am start -S $Package_name/gjzs.online.SplashActivity
        fi
else
    abort "！解压文件失败"
fi