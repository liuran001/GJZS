#本脚本由　by Han | 情非得已c，编写
#应用于搞机助手上


to_Module() {
    mask -vc
    mask $1
    Choice=1
    . $Load $1
    wait
    
    if [[ -f "$Download_File" ]]; then
        rm -rf $Module
        JC=`find $Modules_Dir -iname 'ThemeManager.apk'`
        [[ -n "$JC"  ]] && abort "已检测到相同类似主题模块，无法安装请先卸载后再来安装！"
        echo "- 正在安装${name}-$version（$versionCode）……"
        APK="$Module/system/app/ThemeManager/ThemeManager.apk"
        mkdir -p $Module/system/app/ThemeManager
        cp -f $Download_File $APK
        mktouch $Module/system/app/ThemeManager/oat/.replace
        
        
echo "id="$id"
name="$name"
version="$version"
versionCode="$versionCode"
author="$author"
description="$description"" >$Module_XinXi
            
echo '#!/system/bin/sh

rm -rf /data/system/package_cache/*/ThemeManager-*
rm -rf /data/system/package_cache/*/com.android.thememanager-*
rm -rf /data/system/theme' > $Module_us


echo '#!/system/bin/sh

sleep 30
chmod 711 /data/system/theme' >$Module_S2


        if [[ -f $APK ]]; then
            rm -rf /data/system/package_cache/*/ThemeManager-*
            rm -rf /data/system/package_cache/*/com.android.thememanager-*
            chmod 711 /data/system/theme
            set_perm_recursive $Module 0 0 0755 0644
            echo "- 「"$name"」Magisk模块创建完成，模块将在下次重启生效"
            CQ
        fi
    else
        abort "文件下载错误❌"
    fi
}

APK=`pm path "com.android.thememanager" | sed 's/package://'`
[[ "$APK" = /data/* ]] && abort -e "已检测到主题壁纸被安装在三方应用，无法安装，APK安装路径：$APK\n请先找到主题壁纸APK -->长按主题壁纸图标 -->点击应用信息 -->在最下面的中间点击卸载更新，然后再来安装本模块"
to_Module com.android.thememanager