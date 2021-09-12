#本脚本由　by Han | 情非得已c，编写
#应用于搞机助手上


mask -v
. $Load com.topjohnwu.magisk

#if [ "$MAGISK_VER" = "$version" ]; then
#	echo "已是最新版本：$MAGISK_VER($MAGISK_VER_CODE)"
#else
#	echo "已检测到更新！最新版本为：$version($versionCode)"
#fi 
if [[ "$MAGISK_VER_CODE" -lt "$versionCode" ]]; then
    echo "已检测到更新！最新版本为：$version($versionCode)"
elif [[ "$MAGISK_VER_CODE" -ge "$versionCode" ]]; then
    echo "已是最新版本：$MAGISK_VER($MAGISK_VER_CODE)"
fi

echo "做这个功能只是为了方便某些用户使用Magisk Manager下载缓慢且会下载失败"
