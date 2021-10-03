#本脚本由　by Han | 情非得已c，编写
#应用于搞机助手上


Theme() {

XR() {
cat <<Han >>$xml2
<color name="$1">$2</color>
Han
    echo -n "[$3=$2]; " >>$Module_XinXi
}

[[ -d $Dir ]] && rm -rf $Dir &>/dev/null
[[ ! -d $Dir ]] && mkdir -p $Dir
Splash="${Splash:="$Splash2"}"


    if [[ -d $Module ]]; then
        rm -rf $Module
        mkdir -p $Module/$Theme_Mo
    else
        mkdir -p $Module/$Theme_Mo
    fi
    
printf "id=$1
name=自定义搞机助手主题配色
version=$Version_Name
versionCode=$Version_code
author=by：Han | 情非得已c
description=用途：自定义「搞机助手」主题：" >$Module_XinXi

cat <<Han >$xml1
<?xml version="1.0" encoding="utf-8"?>
<MIUI_Theme_Values>
Han

cat <<Han >$xml3
</MIUI_Theme_Values>
Han

if [[ $logo_type = LSP ]]; then
cat <<Han >>$xml2
<color name="logo_background">#FF000000</color>
<color name="logo_left">#FFFFFFFF</color>
<color name="logo_right">#FFF19A23</color>
<string name="logo_background">M2.45,2106c0.48,-359.25 4.35,-657.86 60.74,-953.62 113.43,-595 465.3,-966.18 1061.38,-1070 614.26,-107 1236.33,-108 1850.87,3.24 605.48,109.55 956.15,495.35 1051.4,1092.05 93.53,585.88 98.11,1179 -5,1764C3911.43,3568.68 3557.21,3915.85 2920,4023.49c-603,101.86 -1213.27,99.76 -1815.28,-8.27C500.69,3906.83 131.4,3483.58 46,2857.69 9.24,2588 0,2317.4 2.45,2106Z</string>
Han
elif [[ $logo_type = mi ]]; then
cat <<Han >>$xml2
<color name="logo_background">#FFFF6727</color>
<color name="logo_left">#FFFFFFFF</color>
<color name="logo_right">#FFFFFFFF</color>
<string name="logo_background">M2.45,2106c0.48,-359.25 4.35,-657.86 60.74,-953.62 113.43,-595 465.3,-966.18 1061.38,-1070 614.26,-107 1236.33,-108 1850.87,3.24 605.48,109.55 956.15,495.35 1051.4,1092.05 93.53,585.88 98.11,1179 -5,1764C3911.43,3568.68 3557.21,3915.85 2920,4023.49c-603,101.86 -1213.27,99.76 -1815.28,-8.27C500.69,3906.83 131.4,3483.58 46,2857.69 9.24,2588 0,2317.4 2.45,2106Z</string>
Han
fi
    [[ -n $logo_background ]] && XR logo_background $logo_background logo背景颜色
    [[ -n $logo_left ]] && XR colorAccent $logo_left 'logo G字母颜色'
    [[ -n $logo_right ]] && XR colorAccent $logo_right 'logo J字母颜色'
    [[ -n $colorAccent ]] && XR colorAccent $colorAccent 软件全局颜色
    [[ -n $log_basic ]] && XR kr_shell_log_basic $log_basic 脚本日志颜色
    [[ -n $log_error ]] && XR kr_shell_log_error $log_error 脚本执行错误颜色
    [[ -n $log_end ]] && XR kr_shell_log_end $log_end 脚本运行结束颜色
    [[ -n $Background_Transparency ]] && XR Background_Transparency $Background_Transparency 透明度
    [[ -n $Wave ]] && XR Wave $Wave 波浪颜色

sort -u $xml2 -o $xml2
cat $xml1 $xml2 $xml3 >$Dir/theme_values.xml
rm -f $xml1 $xml2 $xml3
mkdir -p $Dir/nightmode
cp -f $Dir/theme_values.xml $Dir/nightmode/theme_values.xml

if [[ -f "$kr_shortcut_logo" ]]; then
    echo "- 选择的$kr_shortcut_logo图片存在开始设置为快捷方式图标"
    mkdir -p `dirname $shortcut_logo`
    cp -f "$kr_shortcut_logo" $shortcut_logo
else
    [[ -n "$kr_shortcut_logo" ]] && error "- $kr_shortcut_logo图片文件不存在无法设置为快捷方式图标"
fi
    # if [[ -f "$Splash" ]]; then
        # echo "- 选择的`basename ${Splash}`图片存在开始设置为底图"
        # mkdir -p "$Dir/res/drawable"
        # cp "$Splash" "$Dir/res/drawable/splash.png"
        # echo -n "[背景图片=`basename ${Splash}`]; " >>$Module_XinXi
    # else
        # error "- $Splash图片文件不错哦﻿⊙∀⊙！"
    # fi
    
            if [[ -d $Dir ]]; then
                cd $Dir
                echo "- 开始压缩……"
                zip -r Han.GJZS ./*
            fi
}


mask $1

Theme_Mo=/system/media/theme/default
Dir=$TMPDIR/theme
xml1=$Dir/xml1
xml2=$Dir/xml2
xml3=$Dir/xml3
Log=$Data_Dir/GJZS_Theme_Color.log
Module_File="$Module/$Theme_Mo/Han.GJZS"
shortcut_logo=$Dir/res/drawable/kr_shortcut_logo.png

[[ -f $Log ]] && rm $Log
while read i
do
eval echo $i=\$$i >>$Log
done<<Han
ChongQi
logo_type
logo_background
logo_left
logo_right
logo_background_data
kr_shortcut_logo
colorAccent
log_basic
log_error
log_end
params_view_bg
Han


if [[ -f $Module_File ]]; then
    if [[ -f $Module_Update ]]; then
        abort "- 已经创建了模块请先重启手机再来配置"
    fi
        echo "- 已创建过模块开始执行直接生效"
        Theme $1
        mv -f $Dir/Han.GJZS "$Module_File"
        set_perm "$Module_File" 0 0 0644
        cp -fp "$Module_File" $Theme_Mo/Han.GJZS
        echo "- 即将在2秒后重启「搞机助手」"
        error "- 桌面图标需要应用一遍当前主题才会生效"
        sleep 2
        am start -S $Package_name/gjzs.online.SplashActivity
else
    mask -vc    
    Theme $1
    
    cp -f $Dir/Han.GJZS $Module_File
    touch $Module_Update
    set_perm_recursive $Module 0 0 0755 0644
    
    [[ -d $Module ]] && echo "- 自定义搞机助手主题配色模块已创建成功，模块将在重启后生效，重启一次后以后无需每次重启，可以直接修改生效"
    
    CQ
fi

rm -rf $Dir
