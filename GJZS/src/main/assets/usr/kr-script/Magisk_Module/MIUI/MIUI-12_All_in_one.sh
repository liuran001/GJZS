#本脚本由　by Han | 情非得已c，编写
#应用于搞机助手上


echo >"$Data_Dir/MIUI-12_All_in_one.log"
while read i
do
eval echo $i=\$$i >>"$Data_Dir/MIUI-12_All_in_one.log"
done<<Han
ChongQi
Installation_plan
Export_Directory
Theme_plan
Gesture_Background
Gesture_Return
XiaoBaiTiao
bt_bottom
bt_width
bt_radius
jphch_height
Hide_icon_text
Home_icon
Home_X
Home_Y
Home_icon_width
Home_icon_height
Folder_Preview_width
Folder_Preview_height
Folder_X
Folder_vertical_spacing
icon_title_text
icon_title_text_dark
icon_text_size
Home_Background
Lock_Background
qs_Background
Han


Choice=1
. $Load MIUI-12_All_in_one
Download_File=$Download_File

[[ ! -f $Download_File ]] && abort "下载文件出错❌"

Remove_suffix() {
    mv -f "$1".zip "$1"
}

Clean() {
    rm -rf $1 &>/dev/null
    mkdir -p $1
}

yasuo() {
    [[ -f "$1" ]] && mv -f "$1" "$1".zip
    cd "$tlu4" || abort "！打包失败"
    zip -rq "$1".zip ./*
    Remove_suffix "$1"
    Clean $tlu4
}

JieYa_Theme() {
    echo "- 正在合并$1主题配置文件"
    local File=$lu/$1
    unzip -p $File 'theme_values.xml' 2>/dev/null | sed '/<\/MIUI_Theme_Values>/d' &>$tf
    fgrep -q '?xml version=' $tf || XML_T
}

XML_T() {
    echo '<?xml version="1.0" encoding="utf-8" standalone="yes"?>
<MIUI_Theme_Values>' >$tf
}

XML_W() {
    echo "</MIUI_Theme_Values>" >>$tf
    mkdir $tlu4/nightmode
    cp -f $tf $tf2
}



lu=$Script_Dir/system/media/theme/default

jian=$lu/framework-res
jian2=$lu/com.miui.home
jian3=$lu/com.android.systemui
jian4=$lu/icons

# tlu=$Script_Dir/XiaoBaiTiao
tlu2=$Script_Dir/Return
tlu3=$Script_Dir/Background
tlu4=$Script_Dir/tmp
tlu5=$tlu4/res/drawable
tlu6=$tlu4/res/drawable-440dpi-v4
tlu7=$tlu4/res/drawable-xhdpi-v4
tlu8=$tlu4/res/drawable-xxhdpi-v4
tlu9=$Script_Dir/icons

tmt=$Script_Dir/Pictures/A.png

tf=$tlu4/theme_values.xml
tf2=$tlu4/nightmode/theme_values.xml
tf6=$Script_Dir/module.prop

Theme_Mo=/system/media/theme/default/
Theme_3=/data/system/theme/


rm -rf $Script_Dir
Clean $lu
Clean $tlu4
echo "- 开始解压配置文件$File_Name"
unzip -oq "$Download_File" -d $Script_Dir

if [[ $Theme_plan == 1 ]]; then
    Check_Theme0=`ls -l $Theme_Mo | grep ^- | wc -l`
    Check_Theme3=`ls -l $Theme_3 | grep ^- | wc -l`
    echo "- 开始执行合并方案修改，注：在当前应用的主题基础上修改，已搞机助手修改的优先生效！"
    if [[ $Check_Theme3 -ge 1 ]]; then
        Merge_Theme=true
        echo "- 已检测到您使用了第三方主题，开始从第三方主题上修改"
        for o in `find $Theme_3 -type f`;do
            cp -f $o $lu
        done
    elif [[ $Check_Theme0 -ge 1 ]]; then
        Merge_Theme=true
        echo "- 您没有使用第三方主题，开始使用从默认主题上修改"
        for o in `find $Theme_Mo -type f`;do
            cp -f $o $lu
        done
    fi
elif [[ $Theme_plan == 0 ]]; then
    Merge_Theme=false
    echo "- 已选择不合并主题方案修改，注：如果搞机助手不支持的修改的，剩下的没改的就全是系统默认的"
fi



printf "id=$id
version=$version
versionCode=$versionCode
name=$name
author=$author
description=已安装：" >$tf6


if [[ $XiaoBaiTiao -eq 1 ]]; then
    [[ -z $jphch_height ]] && jphch_height=16
    echo "- 已选择小白条沉浸"
    echo -n '小白条沉浸，' >>$tf6
    $Merge_Theme && JieYa_Theme framework-res || XML_T
cat <<Han >>$tf
<dimen name="navigation_bar_height">0dp</dimen>
<dimen name="navigation_bar_height_landscape">0dp</dimen>
<dimen name="navigation_bar_frame_height">${jphch_height}dp</dimen>
Han
    XML_W
    yasuo $jian
fi


y=false
if [[ -n $bt_bottom || -n $bt_width || -n $bt_radius ]]; then
    y=true
    [[ -n $bt_bottom ]] && echo -n "小白条高度$bt_bottom，" >>$tf6
    [[ -n $bt_width ]] && echo -n "小白条宽度$bt_width，" >>$tf6
    [[ -n $bt_radius ]] && echo -n "小白条粗细$bt_radius，" >>$tf6
    $Merge_Theme && JieYa_Theme com.android.systemui || XML_T
cat <<Han >>$tf
<dimen name="navigation_handle_bottom">${bt_bottom}dp</dimen>
<dimen name="navigation_home_handle_width">${bt_width}dp</dimen>
<dimen name="navigation_handle_radius">${bt_radius}dp</dimen>
Han
    XML_W
    [[ -z $bt_bottom ]] && sed -i '/navigation_handle_bottom/d' $tf
    [[ -z $bt_width ]] && sed -i '/navigation_home_handle_width/d' $tf
    [[ -z $bt_radius ]] && sed -i '/navigation_handle_radius/d' $tf
fi
    if [[ -f "$qs_Background" ]]; then
        y=true
        mkdir -p $tlu4/res/drawable-xxhdpi
        cp -f "$qs_Background" $tlu4/res/drawable-xxhdpi/qs_control_bg.9.png
    fi
        $y && yasuo $jian3
        
        
        y=false
        if [[ $Gesture_Return = 0 ]]; then
            y=false
        else
            y=true
            echo "- 开始安装边缘手势返回特效"
            echo -n '边缘手势返回特效，' >>$tf6
            for i in $tlu5 $tlu6 $tlu7 $tlu8; do
                mkdir -p $i
                cp -f $tlu2/$Gesture_Return/gesture_back_arrow.png $i/gesture_back_arrow.webp
            done
        fi
            if [[ $Gesture_Background = 0 ]]; then
                y=false
            else
                y=true
                echo "- 开始安装边缘手势背景特效"
                echo -n '边缘手势背景特效，' >>$tf6
                for o in $tlu5 $tlu6 $tlu7 $tlu8; do
                    mkdir -p $o
                    cp -f $tlu3/$Gesture_Background/gesture_back_background.png $o/gesture_back_background.webp
                done
            fi
                    if [[ $Hide_icon_text -eq 1 || -n $Home_X || -n $Home_Y || -n $Folder_vertical_spacing || -n $Folder_Preview_width || -n $Folder_Preview_height || -n $Folder_X || -n $Home_icon_width || -n $Home_icon_height || -n $icon_title_text || -n $icon_text_size || -n $icon_title_text_dark ]]; then
                        y=true
                        XML_T
                        [[ -n $Home_X ]] && echo "<integer name=\"config_cell_count_x\">"$Home_X"</integer>" >>$tf && echo -n "桌面图标布局X="$Home_X"，" >>$tf6
                        [[ -n $Home_Y ]] && echo "<integer name=\"config_cell_count_y\">"$Home_Y"</integer>" >>$tf && echo -n "Y="$Home_Y"" >>$tf6 && echo "桌面图标布局已改为"$Home_X"X"$Home_Y""
                        [[ -n $Home_icon_width ]] && echo "<dimen name=\"config_icon_height\">"$Home_icon_width"dp</dimen>" >>$tf && echo -n "图标大小宽度"$Home_icon_width"dp，" >>$tf6 && echo "图标大小宽度已改为"$Home_icon_width"dp"
                        [[ -n $Home_icon_height ]] && echo "<dimen name=\"config_icon_height\">"$Home_icon_height"dp</dimen>" >>$tf && echo -n "图标大小高度"$Home_icon_height"dp，" >>$tf6 && echo "图标大小高度已改为"$Home_icon_height"dp"
                        [[ -n $Folder_X ]] && echo "<integer name=\"config_folder_columns_count\">"$Folder_X"</integer>" >>$tf && echo -n "文件夹图标横向图标个数"$Folder_X"，" >>$tf6 && echo "文件夹图标横向图标个数已改为"$Folder_X""
                        [[ -n $Folder_vertical_spacing ]] && echo "<integer name=\"folder_item_vertical_spacing\">"$Folder_vertical_spacing"</integer>" >>$tf && echo -n "文件夹内的图标上下间距"$Folder_vertical_spacing"，" >>$tf6 && echo "文件夹内的图标上下间距"$Folder_vertical_spacing""
                        [[ -n $Folder_Preview_width ]] && echo "<dimen name=\"folder_preview_width\">"$Folder_Preview_width"dp</dimen>" >>$tf && echo -n "文件夹预览图标大小宽度"$Folder_Preview_width"dp，" >>$tf6 && echo "文件夹预览图标大小宽度已改为"$Folder_Preview_width"dp"
                        [[ -n $Folder_Preview_height ]] && echo "<dimen name=\"folder_preview_height\">"$Folder_Preview_height"dp</dimen>" >>$tf && echo -n "文件夹预览图标大小高度"$Folder_Preview_height"dp，" >>$tf6 && echo "文件夹预览图标大小高度已改为"$Folder_Preview_height"dp"
                        [[ -n $icon_text_size ]] && echo "<dimen name=\"workspace_icon_text_size\">"$icon_text_size"dp</dimen>" >>$tf && echo -n "图标下面应用名称大小"$icon_text_size"dp，" >>$tf6 && echo "图标下面应用名称大小已改为"$icon_text_size"dp"
                        [[ -n $icon_title_text ]] && echo "<color name=\"icon_title_text\">"$icon_title_text"</color>" >>$tf && echo -n "图标下面应用名称颜色"$icon_title_text"dp，" >>$tf6 && echo "图标下面应用名称颜色已改为"$icon_title_text"dp"
                        [[ -n $icon_title_text_dark ]] && echo "<color name=\"icon_title_text_dark\">"$icon_title_text_dark"</color>" >>$tf && echo -n "图标下面应用名称在深色模式下颜色"$icon_title_text"dp，" >>$tf6 && echo "图标下面应用名称在深色模式下颜色"$icon_title_text"dp"
                        [[ $Hide_icon_text == 1 ]] && echo '<dimen name="workspace_icon_text_size">0dp</dimen>' >>$tf && echo -n "已隐藏桌面应用程序名称，" >>$tf6 && echo "已隐藏桌面应用程序名称"
                        XML_W
                    fi
                        $y && yasuo $jian2


if [[ $Home_icon = ys ]]; then
    cp -f $tlu9 $jian4 && echo "已选择使用APK原始图标，" | tee -a $tf6
elif [[ $Home_icon = hide ]]; then
    echo "已选择隐藏桌面图标，" | tee -a $tf6
    mkdir -p $tlu4/res/drawable-xxhdpi
    for i in `pm list package`; do
        cp -rf $tmt $tlu4/res/drawable-xxhdpi/${i/package:/}.png
    done
        yasuo $jian4
fi


echo
if [[ $Installation_plan == Magisk ]]; then
    mask -vc
    MODPATH=$Modules_Dir/$id
    Module_XinXi=$MODPATH/module.prop
    [[ -f "$Lock_Background" ]] && cp -f "$Lock_Background" $lu/lock_wallpaper && echo "- 已自定义了锁屏图片，因为默认桌面壁纸在android.apk里所以跳过了自定义桌面壁纸"
    echo "- 您已选择了方案①Magisk挂载方案"
    echo "Powered by Magisk (@topjohnwu)"
    rm -rf $MODPATH
    mkdir -p $MODPATH
    cp -rf $Script_Dir/system $MODPATH
    cp -f $tf6 $Module_XinXi
    ui_print "----------------------------"
    echo "- 安装完成"
    echo "- 由于您选择的Magisk挂载方案，所以需要重启才生效"
    CQ
elif [[ $Installation_plan == mtz ]]; then
    [[ -f "$Home_Background" ||  -f "$Lock_Background" ]] && mkdir -p $lu/wallpaper
    [[ -f "$Home_Background" ]] && cp -f "$Home_Background" $lu/wallpaper/default_wallpaper.jpg
    [[ -f "$Lock_Background" ]] && cp -f "$Lock_Background" $lu/wallpaper/default_lock_wallpaper.jpg
    [[ -n $Export_Directory ]] && lu2=`dirname $Export_Directory`
    echo "- 您已选择了方案②打包成.mtz主题"
    [[ -n $Export_Directory && ! -d $lu2 ]] && echo "输入目录不存在开始创建" && mkdir -p $lu2 && echo "- 创建目录成功，开始打包…………" || [[ -z $Export_Directory ]] && echo "- 您没有自定义输出路径，将会导出到默认路径"
    cp -rf $Script_Dir/mtz/* $lu
    File=${Export_Directory:=$GJZS/MIUI12多合一主题-"$Time"}.mtz
    cd $lu
    zip -rq "$File" ./*
    echo -e "- 文件已打包到\n$File"
fi

rm -rf $Script_Dir
