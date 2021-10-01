#本脚本由　by Han | 情非得已c，编写
#应用于搞机助手上


pm query-activities --brief com.miui.miwallpaper/com.miui.miwallpaper.activity.SuperWallpaperListActivity | grep 'No activities found'
if [[ $? -eq 0 ]]; then
    echo 0
else
    echo 1
fi
