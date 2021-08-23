#本脚本由　by Han | 情非得已c，编写
#应用于搞机助手上


mask -vc
[[ $? -ne 0 ]] && exit 1

Log=$Data_Dir/MIUI_Module.log

[[ -f $Log ]] && rm -f $Log
while read i
do
eval echo $i=\$$i >>$Log
done<<Han
ChongQi
Installation_plan
Export_Directory
Theme_plan
NotificationBar_UI
Gesture_Background
Gesture_Return
BatteryIcon
Toast
Antitouch
Weather_AD
Cloud_service_AD
Music_AD
Game_Rank
Game_Acceleration_AD
Hide_All
Hide_HD
Replace_HD
Hide_4G
Data_Arrow
Hide_WiFi
Hide_Bluetooth
Hide_Alarm_Clock
Hide_Mute
Hide_Vibration
Hide_GPS
Hide_VPN
Hide_No_SIM
Hide_ErJi
Hide_WiFi_ReDian
Hide_Volte_No_Service
Hide_Quick_Charging
Hide_WuRao
Hide_Flight_Mode
Hide_Notify_more
Past_days
Negative_One_Screen
Negative_One_Screen_New
XiP_NongLi
Home_Background
Lock_Background
TouchSlop
Time12
Time24
Statusbar_Start
Statusbar_End
Battery_Digit_Start
Battery_Digit_End
Battery_Digit_Top
Battery_Digit_Size
Battery_Digit_Color
Battery_Digit_power_save_Color
G3
G4
H
FengKuai
BaiBian
Forced_Expansion
Notification_Bar_Background
FengKuai_BeiJing
Notification_Bar_Fillet
FengKuai_hight
LiangDuXiaJuLi
Brightness_hight
LiangDuShangJuLi
Brightness_Fillet
Brightness_Adjusted
Brightness_Background
quick_settings_num_X
quick_settings_num_Y
Hide_icon
Hide_icon_text
Home_X
Home_Y
Folder_Preview_width
Folder_Preview_height
Folder_X
Home_icon_width
Home_icon_height
icon_title_text
icon_text_size
Han


MIUI() {
lu=$TMPDIR/system/media/theme/default
lu2=$Modules_Dir/MIUI_In_Common_Use
lu3=$TMPDIR/system/priv-app/DownloadProviderUi
lu4=$lu/com.miui.cloudservice
lu5=$lu/com.miui.weather2
lu6=$lu/com.android.systemui
lu7=$lu/com.miui.aod
lu8=$lu/com.miui.player
lu9=$lu/com.miui.securitycenter
lu10=$lu/framework-res.zip
lu11=$lu/com.miui.home
[[ -n $Export_Directory ]] && lu12=`dirname $Export_Directory`
lu13=$TMPDIR/Pictures
lu14=$TMPDIR/tmp/RES/res/drawable-xxhdpi
lu15=$lu/wallpaper
lu16=$TMPDIR/tmp/Hide_icon/res/drawable-xxhdpi
lu17=$lu/icons.zip
jian=$TMPDIR/DownloadProviderUi/DownloadProviderUi.apk
YiAZ=$TMPDIR/module.prop
Theme_Mo=/system/media/theme/default/
Theme_3=/data/system/theme/
Check_Theme0=`ls -l $Theme_Mo | grep ^- | wc -l`
Check_Theme3=`ls -l $Theme_3 | grep ^- | wc -l`
Theme_File=$TMPDIR/tmp/Theme_File
Time=`date '+%F_%R'`

#检查文件
Download "$@"
[[ $? -ne 0 ]] && echo "下载文件出错❌" && exit 1
zipFile=$Download_File


rm -rf $TMPDIR $lu2 &>/dev/null
mkdir -p $TMPDIR

echo "开始复制配置文件$File_Name"
[[ -f $zipFile ]] && cp -rf "$zipFile" $TMPDIR &>/dev/null

unzip -oq "$zipFile" -d $TMPDIR

XML_T() {
echo "<?xml version='1.0' encoding='utf-8' standalone='yes' ?>
<MIUI_Theme_Values>" >$TMPDIR/theme_values.xml
}
XML_W() {
echo "</MIUI_Theme_Values>" >>$TMPDIR/theme_values.xml
}
BeiJing() {
[[ ! -d $lu ]] && mkdir -p $lu
cd $TMPDIR/Background/$1
zip -rq $lu6 ./*
}
FanHui() {
[[ ! -d $lu ]] && mkdir -p $lu
cd $TMPDIR/Return/$1
zip -rq $lu6 ./*
}
DianChi() {
[[ ! -d $lu ]] && mkdir -p $lu
cd $TMPDIR/BatteryIcon/$1
# && cp -rf "./res/raw-440dpi-v4" "./res/raw-xxhdpi-v4"
zip -rq $lu6 ./*
}
TiHuanHD() {
[[ ! -d $lu ]] && mkdir -p $lu
cd $TMPDIR/VoLTE && cp -rf "./res/drawable-xxhdpi" "./res/drawable-xxhdpi-v4"
zip -rq $lu6 ./*
}
ZhuangTaiLan() {
[[ ! -d $lu ]] && mkdir -p $lu
cd $TMPDIR/NotificationBar_UI/$1 && cp -rf ./* $lu
}

FangChu() {
[[ ! -d $lu ]] && mkdir -p $lu
cd $TMPDIR/Antitouch
zip -rq $lu6 ./*
}
JiaoTou() {
[[ ! -d $lu ]] && mkdir -p $lu
cd $TMPDIR/Data_Arrow
zip -rq $lu6 ./*
}
FuYiP() {
[[ ! -d $lu ]] && mkdir -p $lu
cd $TMPDIR/Negative_One_Screen
zip -rq $lu11 ./*
}
YinCang() {
[[ ! -d $lu ]] && mkdir -p $lu
[[ ! -d $lu14 ]] && mkdir -p $lu14
for i in $*; do
cp -rf $lu13/A.png $lu14/$i
done
cd $TMPDIR/tmp/RES
zip -rq $lu6 ./*
rm -rf $TMPDIR/tmp/RES/*
}
YinCang_icon() {
[[ ! -d $lu ]] && mkdir -p $lu
[[ ! -d $lu16 ]] && mkdir -p $lu16
for i in `pm list package`; do
cp -rf $lu13/A.png $lu16/${i/package:/}.png
done
cd $TMPDIR/tmp/Hide_icon
zip -rq $lu17 ./*
rm -rf $TMPDIR/tmp/Hide_icon/*
}
HuanTu() {
[[ ! -d $lu ]] && mkdir -p $lu
[[ ! -d $lu14 ]] && mkdir -p $lu14
cp -rf $lu13/$1 $lu14/$2
cd $TMPDIR/tmp/RES
zip -rq $lu6 ./*
rm -rf $TMPDIR/tmp/RES/*
}
ZDY_HuanTu() {
[[ ! -d $lu ]] && mkdir -p $lu
[[ ! -d $lu14 ]] && mkdir -p $lu14
cp -rf $1 $lu14/$2
cd $TMPDIR/tmp/RES
zip -rq $lu6 ./*
rm -rf $TMPDIR/tmp/RES/*
}
ZDY_HuanTu2() {
[[ ! -d $lu ]] && mkdir -p $lu
[[ ! -d $lu15 ]] && mkdir -p $lu15
cp -rf $1 $lu15/$2
}
TuSi() {
[[ ! -d $lu ]] && mkdir -p $lu
cd $TMPDIR/Toast/$1
zip -rq $lu10 ./*
}
JieYa_Theme() {
[[ ! -d $Theme_File ]] && mkdir -p $Theme_File
unzip -oq $lu/$1 'theme_values.xml' -d $Theme_File
if [[ -f $Theme_File/theme_values.xml ]]; then
echo "正在合并主题配置文件"
cat $Theme_File/theme_values.xml | sed 's#</MIUI_Theme_Values>##' | sed -n '3,$p' >>$TMPDIR/theme_values.xml
rm -rf $Theme_File/*
else
echo "当前应用的第三方主题配置文件里没有theme_values.xml文件，合并出错！"
fi
}


#
if [[ $Theme_plan == 1 ]]; then
[[ ! -d $lu ]] && mkdir -p $lu
echo "开始执行合并方案修改，注：在当前应用的主题基础上修改，已搞机助手修改的优先生效！"
if [[ $Check_Theme3 -ge 1 ]]; then
Merge_Theme=true
echo "已检测到您使用了第三方主题，开始从第三方主题上修改"
for o in `find $Theme_3 -type f`;do
cp -f $o $lu
done
elif [[ $Check_Theme0 -ge 1 ]]; then
Merge_Theme=true
echo "您没有使用第三方主题，开始使用从默认主题上修改"
for o in `find $Theme_Mo -type f`;do
cp -f $o $lu
done

fi
elif [[ $Theme_plan == 0 ]]; then
Merge_Theme=false
echo "已选择不合并主题方案修改，注：如果搞机助手不支持的修改的，剩下的没改的就全是系统默认的"
fi

       if [[ $NotificationBar_UI == Native ]]; then
   ZhuangTaiLan Native
         echo "您选择了下拉通知栏和状态栏UI为原生样式"
    echo -n "[下拉通知栏和状态栏UI为原生样式];" >>$YiAZ
       elif [[ $NotificationBar_UI == 0 ]]; then
       echo "您选择了默认下拉通知栏样式"
       fi

        if [[ "$Gesture_Background" == "Cai" ]]; then
                echo "您选择了安装彩虹炫彩背景"
BeiJing Cai
echo -n "[彩虹炫彩背景];" >>$YiAZ

       elif [[ "$Gesture_Background" == "Lan" ]]; then
            echo "您选择了安装蓝色炫彩背景"
BeiJing Lan
echo -n "[蓝色炫彩背景];" >>$YiAZ
       elif [[ "$Gesture_Background" == "Fen" ]]; then
            echo "您选择了安装粉色炫彩背景"
BeiJing Fen
echo -n "[粉色炫彩背景];" >>$YiAZ
       elif [[ "$Gesture_Background" == "Hong" ]]; then
            echo "您选择了安装红色炫彩背景"
BeiJing Hong
echo -n "[红色炫彩背景];" >>$YiAZ
       elif [[ "$Gesture_Background" == "Cheng" ]]; then
            echo "您选择了安装橙色炫彩背景"
BeiJing Cheng
echo -n "[橙色炫彩背景];" >>$YiAZ
         elif [[ "$Gesture_Background" == "Lv" ]]; then
            echo "您选择了安装酷安绿背景"
BeiJing Lv
echo -n "[酷安绿背景];" >>$YiAZ
          elif [[ "$Gesture_Background" == "Qing" ]]; then
            echo "您选择了安装青色炫彩背景"
BeiJing Qing
echo -n "[青色炫彩背景];" >>$YiAZ
      elif [[ "$Gesture_Background" == "Zi" ]]; then
            echo "您选择了安装紫色炫彩背景"
BeiJing Zi
echo -n "[紫色炫彩背景];" >>$YiAZ
      elif [[ "$Gesture_Background" == "ChunHong" ]]; then
            echo "您选择了安装纯红背景"
BeiJing ChunHong
echo -n "[纯红背景];" >>$YiAZ
      elif [[ "$Gesture_Background" == "ChunHuang" ]]; then
            echo "您选择了安装纯黄背景"
BeiJing ChunHuang
echo -n "[纯黄背景];" >>$YiAZ
       elif [[ "$Gesture_Background" == "ChunZi" ]]; then
            echo "您选择了安装纯紫背景"
BeiJing ChunZi
echo -n "[纯紫背景];" >>$YiAZ
      elif [[ "$Gesture_Background" == "CaiSe" ]]; then
            echo "您选择了安装彩色背景"
BeiJing CaiSe
echo -n "[彩色背景];" >>$YiAZ
     elif [[ "$Gesture_Background" == "TouMing" ]]; then
            echo "您选择了安装透明无背景"
BeiJing TouMing
echo -n "[透明无背景];" >>$YiAZ
     elif [[ $Gesture_Background == 0 ]]; then
            echo "您选择了默认手势背景"
        fi

        if [[ "$Gesture_Return" == "HuaJi" ]]; then
            echo "您选择了安装滑稽表情返回特效"
            FanHui HuaJi
echo -n "[滑稽表情返回特效];" >>$YiAZ
        elif [[ "$Gesture_Return" == "SYHuaJi" ]]; then
            echo "您选择了安装受虐滑稽表情返回特效"
            FanHui SYHuaJi
echo -n "[受虐滑稽表情返回特效];" >>$YiAZ
         elif [[ "$Gesture_Return" == "XiaoKu" ]]; then
            echo "您选择了安装笑哭表情返回特效"
            FanHui XiaoKu
echo -n "[笑哭表情返回特效];" >>$YiAZ
         elif [[ "$Gesture_Return" == "XieYanXiao" ]]; then
            echo "您选择了安装斜眼笑表情返回特效"
            FanHui XieYanXiao
echo -n "[斜眼笑表情返回特效];" >>$YiAZ
       elif [[ "$Gesture_Return" == "Hong" ]]; then
            echo "您选择了安装红色返回特效"
            FanHui Hong
echo -n "[红色返回特效];" >>$YiAZ
      elif [[ "$Gesture_Return" == "Zi" ]]; then
            echo "您选择了安装紫色返回特效"
            FanHui Zi
    elif [[ "$Gesture_Return" == "TouMing" ]]; then
            echo "您选择了安装透明无返回特效"
echo -n "[透明无返回特效];" >>$YiAZ
      elif [[ "$Gesture_Return" == "0" ]]; then
            echo "您选择了默认返回特效"
       fi

       if [[ $BatteryIcon == Cai ]]; then
       echo "您选择了彩虹电池图标"
       echo -n "[彩虹电池图标];" >>$YiAZ
       DianChi Cai
       elif [[ $BatteryIcon == Lan ]]; then
       echo "您选择了蓝色电池图标"
    echo -n "[蓝色电池图标];" >>$YiAZ
       DianChi Lan
       elif [[ $BatteryIcon == Lv ]]; then
       echo "您选择了绿色电池图标"
    echo -n "[绿色电池图标];" >>$YiAZ
       DianChi Lv
       elif [[ $BatteryIcon == TouMing ]]; then
       echo "您选择了透明电池图标"
    echo -n "[透明电池图标];" >>$YiAZ
       DianChi TouMing
       elif [[ $BatteryIcon == BaiFenBi ]]; then
       echo "您选择了竖型电池自带百分比"
    echo -n "[竖型电池自带百分比];" >>$YiAZ
       DianChi BaiFenBi
      BFB=1
       elif [[ $BatteryIcon == WaiXian ]]; then
       echo "您选择了竖型电池自带电量外显"
    echo -n "[竖型电池自带电量外显];" >>$YiAZ
       DianChi WaiXian
     WX=1
       elif [[ $BatteryIcon == 0 ]]; then
       echo "您选择了默认电池图标"
    fi
    
       if [[ $Toast == BiliBili ]]; then
TuSi BiliBili
    echo "您选择了B站Toast"
    echo -n "[B站Toast];" >>$YiAZ
       elif [[ $Toast == BiliBili2 ]]; then
TuSi BiliBili2
    echo "您选择了B站Toast_2"
    echo -n "[B站Toast_2];" >>$YiAZ
       elif [[ $Toast == DianShi ]]; then
TuSi DianShi
    echo "您选择了电视机Toast"
    echo -n "[电视机Toast];" >>$YiAZ
       elif [[ $Toast == 0 ]]; then
       echo "您选择了默认Toast"
       fi
       
if [[ $DownloadProviderUi == 1 ]]; then
echo "已选择去除下载管理热榜以及VIP下载"
[[ ! -d $lu3 ]] && mkdir -p $lu3
cp -rf -rf $jian $lu3
echo -n "[下载管理热榜以及VIP下载];" >>$YiAZ
fi

if [[ $Antitouch == 1 ]]; then
FangChu
echo "去除防误触白条"
echo -n "[去除防误触白条];" >>$YiAZ
fi

if [[ $Weather_AD == 1 ]]; then
echo "已去除天气预报广告"
echo -n "[已去除天气预报广告];" >>$YiAZ
[[ ! -d $lu ]] && mkdir -p $lu
XML_T
	echo '<dimen name="ad_card_item_adbomen_big_image_height">0dp</dimen>' >>$TMPDIR/theme_values.xml
XML_W
zip -jq $lu5 $TMPDIR/theme_values.xml
fi

if [[ $Cloud_service_AD == 1 ]]; then
[[ ! -d $lu ]] && mkdir -p $lu
echo "已去除小米云服务广告"
echo -n "[已去除小米云服务广告];" >>$YiAZ
XML_T
	echo '<dimen name="micloud_banner_height">0dp</dimen>' >>$TMPDIR/theme_values.xml
XML_W
zip -jq $lu4 $TMPDIR/theme_values.xml &>/dev/null
fi

if [[ $Music_AD == 1 ]]; then
echo "已去除音乐专辑广告"
echo -n "[已去除音乐专辑广告];" >>$YiAZ
[[ ! -d $lu ]] && mkdir -p $lu
XML_T
echo '<dimen name="nowplaying_ad_floating_content">0dp</dimen>
<dimen name="nowplaying_ad_floating_margin_width">0dp</dimen>
<dimen name="nowplaying_ad_floating_margin_top">0dp</dimen>
<dimen name="nowplaying_ad_floating_margin_height">0dp</dimen>
<dimen name="nowplaying_ad_floating_icon_size">0dp</dimen>
<dimen name="local_music_ad_item_height">0dp</dimen>
<dimen name="local_music_item_ad_height">0dp</dimen>
<dimen name="local_music_item_ad_play_description_right">0dp</dimen>
<dimen name="local_music_item_ad_right">0dp</dimen>
<dimen name="ad_close_height">0dp</dimen>
<dimen name="ad_close_width">0dp</dimen>' >>$TMPDIR/theme_values.xml
XML_W
cd $TMPDIR
zip -jq $lu8 $TMPDIR/theme_values.xml
fi

if [[ $Game_Rank == 1 || $Game_Acceleration_AD == 1 ]]; then
echo "已去除游戏加速排行"
echo -n "[已去除游戏加速排行];" >>$YiAZ
[[ ! -d $lu ]] && mkdir -p $lu
XML_T
[[ $Game_Rank ]] && echo '<bool name="config_lock_screen_traffic_purchase_enabled">false</bool>
<bool name="display_applock_Ads">false</bool>
<bool name="display_antivirus_Ads">false</bool>
<bool name="display_gamebooster_Ads">false</bool>
<bool name="display_gamebooster_xunyou">false</bool>' >>$TMPDIR/theme_values.xml
[[ $Game_Acceleration_AD ]] && echo '<bool name="display_gamebooster_Ads">false</bool>
<bool name="display_gamebooster_xunyou">false</bool>
<bool name="display_applock_Ads">false</bool>' >>$TMPDIR/theme_values.xml && echo "已去除游戏加速网络提速界面" && echo -n "[已去除天气预报广告去除游戏加速网络提速界面];" >>$YiAZ
XML_W
zip -jq $lu9 $TMPDIR/theme_values.xml
fi

if [[ $Data_Arrow == 1 ]]; then
echo "已隐藏数据传输图标"
echo -n "[已隐藏数据传输图标];" >>$YiAZ
JiaoTou
fi

if [[ $Hide_WiFi == 1 ]]; then
echo "已隐藏WiFi图标"
echo -n "[已隐藏WiFi图标];" >>$YiAZ
YinCang stat_sys_wifi_signal_0.png stat_sys_wifi_signal_0_darkmode.png stat_sys_wifi_signal_1.png stat_sys_wifi_signal_1_darkmode.png stat_sys_wifi_signal_2.png stat_sys_wifi_signal_2_darkmode.png stat_sys_wifi_signal_3.png stat_sys_wifi_signal_3_darkmode.png stat_sys_wifi_signal_4.png stat_sys_wifi_signal_4_darkmode.png stat_sys_wifi_signal_null.png stat_sys_wifi_signal_null_darkmode.png
fi


if [[ $Hide_Bluetooth == 1 ]]; then
echo "已隐藏蓝牙图标"
echo -n "[已隐藏蓝牙图标];" >>$YiAZ
YinCang stat_sys_data_bluetooth.png stat_sys_data_bluetooth_darkmode.png stat_sys_data_bluetooth_connected.png stat_sys_data_bluetooth_connected_darkmode.png
fi

if [[ $Hide_Alarm_Clock == 1 ]]; then
echo "已隐藏闹钟图标"
echo -n "[已隐藏闹钟图标];" >>$YiAZ
YinCang stat_sys_alarm.png stat_sys_alarm_darkmode.png
fi

if [[ $Hide_Mute == 1 ]]; then
echo "已隐藏静音图标"
echo -n "[已隐藏静音图标];" >>$YiAZ
YinCang stat_sys_ringer_silent_darkmode.png stat_sys_ringer_silent_darkmode.png
fi

if [[ $Hide_Vibration == 1 ]]; then
echo "已隐藏振动图标"
echo -n "[已隐藏振动图标];" >>$YiAZ
YinCang stat_sys_ringer_vibrate.png stat_sys_ringer_vibrate_darkmode.png
fi

if [[ $Hide_GPS == 1 ]]; then
echo "已隐藏GPS图标"
echo -n "[已隐藏GPS图标];" >>$YiAZ
YinCang stat_sys_gps_on.png stat_sys_gps_on_darkmode.png
fi

if [[ $Hide_VPN == 1 ]]; then
echo "已隐藏VPN图标"
echo -n "[已隐藏VPN图标];" >>$YiAZ
YinCang stat_sys_vpn.png stat_sys_vpn_darkmode.png
fi

if [[ $Hide_No_SIM == 1 ]]; then
echo "已隐藏无SIM卡图标"
echo -n "[已隐藏无SIM卡图标];" >>$YiAZ
YinCang stat_sys_no_sim.png stat_sys_no_sim_darkmode.png
fi

if [[ $Hide_ErJi == 1 ]]; then
echo "已隐藏耳机图标"
echo -n "[已隐藏耳机图标];" >>$YiAZ
YinCang stat_sys_headset.png stat_sys_headset_darkmode.png stat_sys_headset_without_mic.png stat_sys_headset_without_mic_darkmode.png
fi

if [[ $Hide_WiFi_ReDian == 1 ]]; then
echo "已隐藏WiFi热点图标"
echo -n "[已隐藏WiFi热点图标];" >>$YiAZ
YinCang stat_sys_wifi_ap_on.png stat_sys_wifi_ap_on_darkmode.png
fi

if [[ $Hide_Volte_No_Service == 1 ]]; then
echo "已隐藏Volte无服务图标"
echo -n "[已隐藏Volte无服务图标];" >>$YiAZ
YinCang stat_sys_volte_no_service.png stat_sys_volte_no_service_darkmode.png
fi

if [[ $Hide_Quick_Charging == 1 ]]; then
echo "已隐藏快充图标"
echo -n "[已隐藏快充图标];" >>$YiAZ
YinCang stat_sys_quick_charging.png stat_sys_quick_charging_darkmode.png
fi

if [[ $Hide_WuRao == 1 ]]; then
echo "已隐藏勿扰模式图标"
echo -n "[已隐藏勿扰模式图标];" >>$YiAZ
YinCang stat_sys_quiet_mode.png stat_sys_quiet_mode_darkmode.png
fi

if [[ $Hide_Flight_Mode == 1 ]]; then
echo "已隐藏飞行模式图标"
echo -n "[已隐藏飞行模式图标];" >>$YiAZ
YinCang stat_sys_signal_flightmode.png stat_sys_signal_flightmode_darkmode.png
fi

if [[ $Hide_Notify_more == 1 ]]; then
echo "已隐藏更多通知的3个点图标"
echo -n "[已隐藏更多通知的3个点图标];" >>$YiAZ
YinCang stat_notify_more.png stat_notify_more_darkmode.png
fi

if [[ $Replace_HD == 1 ]]; then
echo "已替换HD图标为VoLTE"
echo -n "[已替换HD图标为VoLTE];" >>$YiAZ
TiHuanHD
fi

if [[ $Negative_One_Screen == 1 ]]; then
FuYiP
echo "已安装负一屏全透明（旧版）"
echo -n "[负一屏全透明（旧版）];" >>$YiAZ
fi

if [[ $XiP_NongLi == 1 ]]; then
echo "已安装息屏农历"
echo -n "[息屏农历];" >>$YiAZ
[[ ! -d $lu ]] && mkdir -p $lu
XML_T
echo '<string name="status_bar_clock_date_format">M月d日 N月e E</string>
<string name="status_bar_clock_date_format_12">M月d日 N月e EEaa</string>' >>$TMPDIR/theme_values.xml
XML_W
zip -jq $lu7 $TMPDIR/theme_values.xml
fi

if [[ -n $TouchSlop ]]; then
echo "游戏触摸优化为$TouchSlop"
echo -n "[游戏触摸优化为"$TouchSlopTouchSlop"];" >>$YiAZ
[[ ! -d $lu ]] && mkdir -p $lu
XML_T
echo "<dimen name=\"config_viewConfigurationTouchSlop\">"$TouchSlop"dp</dimen>" >>$TMPDIR/theme_values.xml
XML_W
zip -jq $lu10 $TMPDIR/theme_values.xml
fi

[[ -n $Home_Background ]] && ZDY_HuanTu2 $Home_Background default_wallpaper.jpg && printf "已定义桌面背景图路径为\n$Home_Background"
[[ -n $Lock_Background ]] && ZDY_HuanTu2 $Lock_Background default_lock_wallpaper.jpg && printf "已定义锁屏背景图路径为\n$Lock_Background"

if [[ $FengKuai == 1 && $FengKuai_BeiJing == 0 ]]; then
echo "已安装通知栏分块且默认背景"
echo -n "[已安装通知栏分块且默认背景;" >>$YiAZ
HuanTu MoRen.png notification_item_bg_n.9.png
elif [[ $FengKuai == 1 && $FengKuai_BeiJing == 1 ]]; then
echo "已安装通知栏分块且半透明背景"
echo -n "[已安装通知栏分块且默认背景;" >>$YiAZ
HuanTu BanTou.png notification_item_bg_n.9.png
elif [[ $FengKuai == 1 && $FengKuai_BeiJing == 2 ]]; then
echo "已安装通知栏分块且全透明背景"
echo -n "[已安装通知栏分块且默认背景;" >>$YiAZ
HuanTu A.png notification_item_bg_n.9.png
fi

if [[ $Hide_icon == 1 ]]; then
echo "开始隐藏桌面全部图标……"
echo "[已隐藏桌面应用程序图标];" >>$YiAZ
YinCang_icon
fi

[[ -n $Notification_Bar_Background ]] && ZDY_HuanTu $Notification_Bar_Background notification_panel_window_bg.9.png && printf "已定义通知栏下拉背景图路径为\n$Notification_Bar_Background"

if [[  -n $Home_X || -n $Home_Y || -n $Folder_X || -n $Folder_Preview_width || -n $Folder_Preview_height || -n $Home_icon_width || -n $Home_icon_height || -n $icon_text_size || -n $icon_title_text || $Negative_One_Screen_New == 1 || $Hide_icon_text == 1 || $Merge_Theme ]]; then
XML_T
[[ $Hide_icon_text == 1 ]] && echo '<dimen name="workspace_icon_text_size">0dp</dimen>' >>$TMPDIR/theme_values.xml && echo -n "[已隐藏桌面应用程序名称];" >>$YiAZ && echo "已隐藏桌面应用程序名称"
[[ $Negative_One_Screen_New == 1 ]] && echo '<dimen name="assist_bg_header_height"package="com.miui.personalassistant">10000dp</dimen>
<color name="card_content_bg"package="com.miui.personalassistant">#00FFFFFF</color>' >>$TMPDIR/theme_values.xml && echo -n "[负一屏背景透明（新版）];" >>$YiAZ && echo "已安装负一屏背景透明（新版）"
[[ -n $Home_X ]] && echo "<integer name=\"config_cell_count_x\">"$Home_X"</integer>" >>$TMPDIR/theme_values.xml && echo -n "[桌面图标布局X="$Home_X"];" >>$YiAZ
[[ -n $Home_Y ]] && echo "<integer name=\"config_cell_count_y\">"$Home_Y"</integer>" >>$TMPDIR/theme_values.xml && echo -n "[Y="$Home_Y"];" >>$YiAZ && echo "桌面图标布局已改为X="$Home_X"Y=="$Home_Y""
[[ -n $Folder_X ]] && echo "<integer name=\"config_folder_columns_count\">"$Folder_X"</integer>" >>$TMPDIR/theme_values.xml && echo -n "[文件夹图标横向图标个数"$Folder_X"];" >>$YiAZ && echo "文件夹图标横向图标个数已改为"$Folder_X""
[[ -n $Folder_Preview_width ]] && echo "<dimen name=\"folder_preview_width\">"$Folder_Preview_width"dp</dimen>" >>$TMPDIR/theme_values.xml && echo -n "[文件夹预览图标大小宽度"$Folder_Preview_width"dp];" >>$YiAZ && echo "文件夹预览图标大小宽度已改为"$Folder_Preview_width"dp"
[[ -n $Folder_Preview_height ]] && echo "<dimen name=\"folder_preview_height\">"$Folder_Preview_height"dp</dimen>" >>$TMPDIR/theme_values.xml && echo -n "[文件夹预览图标大小高度"$Folder_Preview_height"dp];" >>$YiAZ && echo "文件夹预览图标大小高度已改为"$Folder_Preview_height"dp"
[[ -n $Home_icon_width ]] && echo "<dimen name=\"config_icon_width\">"$Home_icon_width"dp</dimen>" >>$TMPDIR/theme_values.xml && echo -n "[图标大小宽度"$Home_icon_width"dp];" >>$YiAZ && echo "图标大小宽度已改为"$Home_icon_width"dp"
[[ -n $Home_icon_height ]] && echo "<dimen name=\"config_icon_height\">"$Home_icon_height"dp</dimen>" >>$TMPDIR/theme_values.xml && echo -n "[图标大小高度"$Home_icon_height"dp];" >>$YiAZ && echo "图标大小高度已改为"$Home_icon_height"dp"
[[ -n $icon_text_size ]] && echo "<dimen name=\"workspace_icon_text_size\">"$icon_text_size"dp</dimen>" >>$TMPDIR/theme_values.xml && echo -n "[图标下面应用名称大小"$icon_text_size"dp];" >>$YiAZ && echo "图标下面应用名称大小已改为"$icon_text_size"dp"
[[ -n $icon_title_text ]] && echo "<color name=\"icon_title_text\">"$icon_title_text"</color>" >>$TMPDIR/theme_values.xml && echo -n "[图标下面应用名称颜色"$icon_title_text"dp];" >>$YiAZ && echo "图标下面应用名称颜色已改为"$icon_title_text"dp];"
$Merge_Theme && JieYa_Theme com.miui.home
XML_W
cd $TMPDIR
[[ ! -d $lu ]] && mkdir -p $lu
zip -jq $lu11 $TMPDIR/theme_values.xml
fi

if [[ $WX == 1 || $BFB == 1 || $Past_days == 1 || Hide_All == 1 || $Hide_HD == 1 || $Hide_4G == 1 || -n $StatusBar_size || -n $Time12 || -n $Time24 || -n $Statusbar_Start || -n $Statusbar_End || -n $Battery_Digit_Start || -n $Battery_Digit_End || -n $Battery_Digit_Top || -n $Battery_Digit_Size || -n $Battery_Digit_Color || -n $Battery_Digit_power_save_Color || -n $quick_settings_num_X || -n $quick_settings_num_Y || -n $Time_Start || -n $G3 ||  -n $G4 || $FengKuai == 1 || -n $Notification_Bar_Fillet || -n $FengKuai_hight || $BaiBian == 1 || $Forced_Expansion == 1 || -n $LiangDuXiaJuLi || -n $Brightness_hight || -n $LiangDuShangJuLi || -n $Brightness_Fillet || -n $Brightness_Adjusted || -n $Brightness_Background || $Merge_Theme || $NotificationBar_UI == Native ]]; then
XML_T
[[ $Hide_All == 1 ]] && echo '<dimen name="status_bar_system_icons_height">0dp</dimen>' >>$TMPDIR/theme_values.xml && echo "已隐藏状态栏所有图标（不包括锁屏状态栏）" && echo -n "[隐藏状态栏所有图标（不包括锁屏状态栏）];" >>$YiAZ
if [[ $WX == 1 ]]; then
echo '<dimen name="statusbar_battery_digit_padding_start">12dp</dimen>
<dimen name="statusbar_battery_digit_size">15dp</dimen>
<dimen name="statusbar_battery_digit_padding_top">2dp</dimen>' >>$TMPDIR/theme_values.xml
elif [[ $BFB == 1 ]]; then
echo '<dimen name="statusbar_battery_digit_padding_start">5dp</dimen>
<dimen name="statusbar_battery_digit_size">15dp</dimen>
<dimen name="statusbar_battery_digit_padding_top">2dp</dimen>' >>$TMPDIR/theme_values.xml
fi
[[ $Past_days == 1 ]] && echo '<string name="status_bar_clock_date_format">y/M/d E  N月e  y年已经过了D天</string>
<string name="status_bar_clock_date_format_12">y/M/d E  N月e  aa  y年已经过了D天</string>' >>$TMPDIR/theme_values.xml && echo "已安装通知栏下拉显示今年已过多少天" && echo -n "[通知栏下拉显示今年已过多少天];" >>$YiAZ
[[ $Hide_HD == 1 ]] && echo '<bool name="status_bar_hide_volte">true</bool>' >>$TMPDIR/theme_values.xml && echo "已隐藏HD图标" && echo -n "[已隐藏HD图标];" >>$YiAZ
[[ $Hide_4G == 1 ]] && echo '<bool name="config_show4GForLTE">false</bool>' >>$TMPDIR/theme_values.xml && echo "已隐藏4G图标" && echo -n "[已隐藏4G图标];" >>$YiAZ
[[ -n $StatusBar_size ]] && echo "<dimen name=\"status_bar_clock_size\">"$StatusBar_size"dp</dimen>" >>$TMPDIR/theme_values.xml && echo "已修改状态栏字体大小"$StatusBar_size"dp" && echo -n "[已修改状态栏字体大小"$StatusBar_size"dp];" >>$YiAZ
[[ -n $Time12 ]] && echo "<string name=\"fmt_time_12hour_minute_pm\" package=\"miui\">"$Time12"</string>" >>$TMPDIR/theme_values.xml
[[ -n $Time24 ]] && echo "<string name=\"fmt_time_24hour_minute\" package=\"miui\">"$Time24"</string>" >>$TMPDIR/theme_values.xml
[[ -n $Statusbar_Start ]] && echo "<dimen name=\"statusbar_padding_start\">"$Statusbar_Start"dp</dimen>" >>$TMPDIR/theme_values.xml && echo "状态栏时间距离左边缘距离已改为"$Statusbar_Start"dp" && echo -n "[状态栏时间距离左边缘距离已改为"$Statusbar_Start"dp];" >>$YiAZ
[[ -n $Statusbar_End ]] && echo "<dimen name=\"statusbar_padding_end\">"$Statusbar_End"dp</dimen>" >>$TMPDIR/theme_values.xml && echo "状态栏电池距离左边缘距离已改为"$Statusbar_Start"dp" && echo -n "[状态栏电池距离右边缘距离已改为"$Statusbar_End"dp];" >>$YiAZ
[[ -n $Battery_Digit_Start ]] && sed -i '/statusbar_battery_digit_padding_start/d' $TMPDIR/theme_values.xml && echo "<dimen name=\"statusbar_battery_digit_padding_start\">"$Battery_Digit_Start"dp</dimen>" >>$TMPDIR/theme_values.xml && echo "状态栏自定义电池数字右移距离已改为"$Battery_Digit_Start"dp" && echo -n "[电池数字右移距离已改为"$Battery_Digit_Start"dp];" >>$YiAZ
[[ -n $Battery_Digit_End ]] && echo "<dimen name=\"statusbar_battery_digit_padding_end\">"$Battery_Digit_End"dp</dimen>" >>$TMPDIR/theme_values.xml && echo "状态栏电池数字左移距离已改为"$Battery_Digit_End"dp" && echo -n "[电池数字左移距离已改为"$Battery_Digit_End"dp];" >>$YiAZ
[[ -n $Battery_Digit_Top ]] && sed -i '/statusbar_battery_digit_padding_top/d' $TMPDIR/theme_values.xml && echo "<dimen name=\"statusbar_battery_digit_padding_top\">"$Battery_Digit_Top"dp</dimen>" >>$TMPDIR/theme_values.xml && echo "状态栏电池数字下移距离已改为"$Battery_Digit_Top"dp" && echo -n "[电池数字下移距离已改为"$Battery_Digit_Top"dp];" >>$YiAZ
[[ -n $Battery_Digit_Size ]] && sed -i '/statusbar_battery_digit_size/d' $TMPDIR/theme_values.xml && echo "<dimen name=\"statusbar_battery_digit_size\">"$Battery_Digit_Size"dp</dimen>" >>$TMPDIR/theme_values.xml && echo "状态栏电池数字大小已改为"$Battery_Digit_Size"dp" && echo -n "[电池数字大小已改为"$Battery_Digit_Size"dp];" >>$YiAZ
[[ -n $Battery_Digit_Color ]] && echo "<color name=\"status_bar_battery_digit_textColor\">#"$Battery_Digit_Color"</color>
<color name=\"status_bar_battery_digit_textColor_darkmode\">#"$Battery_Digit_Color"</color>" >>$TMPDIR/theme_values.xml && echo "状态栏电池数字颜色已改为$Battery_Digit_Color" && echo -n "[电池数字颜色已改为"$Battery_Digit_Color"];" >>$YiAZ
[[ -n $Battery_Digit_power_save_Color ]] && echo "<color name=\"status_bar_battery_power_save_digit_textColor\">#"$Battery_Digit_power_save_Color"</color>
<color name=\"status_bar_battery_power_save_digit_textColor_darkmode\">#"$Battery_Digit_power_save_Color"</color>" >>$TMPDIR/theme_values.xml && echo "状态栏省电模式电池数字颜色已改为$Battery_Digit_Color" && echo -n "[省电模式电池数字颜色已改为"$Battery_Digit_Color"];" >>$YiAZ
[[ -n $quick_settings_num_X ]] && echo "<integer name=\"quick_settings_num_columns\">"$quick_settings_num_X"</integer>" >>$TMPDIR/theme_values.xml && echo "下拉状态栏横着的图标个数已修改为$quick_settings_num_X个" && echo -n "[下拉状态栏横着的图标个数已修改为"$quick_settings_num_X"个];" >>$YiAZ
[[ -n $quick_settings_num_Y ]] && echo "<integer name=\"quick_settings_num_rows\">"$quick_settings_num_Y"</integer>" >>$TMPDIR/theme_values.xml && echo "下拉状态栏竖着的图标行数已修改为$quick_settings_num_Y行" && echo -n "[下拉状态栏横着的图标行数已修改为"$quick_settings_num_Y"行];" >>$YiAZ
[[ -n $Time_Start ]] && echo "<dimen name=\"statusbar_padding_start\">"$Time_Start"dp</dimen>" >>$TMPDIR/theme_values.xml && echo "状态栏时间距离左边缘距离已改为$Time_Start" && echo -n "[状态栏时间距离左边缘距离已改为"$Time_Start"dp];" >>$YiAZ
if [[ -n $G3 || -n $G4 ]]; then
[[ -n $G3 ]] && echo "已修改3G图标为$G3" && echo -n "[已修改3G图标为$G3]" >>$YiAZ
[[ -n $G4 ]] && echo "已修改4G图标为$G4" && echo -n "[已修改4G图标为$G4];" >>$YiAZ
if [[ $SDK == 27 ]]; then
echo "<string-array name=\"data_type_name_default\">" >>$TMPDIR/theme_values.xml
elif [[ $SDK == 28 || $SDK == 29 ]]; then
echo "<string-array name=\"data_network_type_name_default\">" >>$TMPDIR/theme_values.xml
fi
echo "<item></item>" >>$TMPDIR/theme_values.xml
echo "<item></item>" >>$TMPDIR/theme_values.xml
echo "<item>E</item>" >>$TMPDIR/theme_values.xml
echo "<item>"${G3:=3G}"</item>" >>$TMPDIR/theme_values.xml
echo "<item>"${H:=H}"</item>" >>$TMPDIR/theme_values.xml
echo "<item>"${H:=H}"+</item>" >>$TMPDIR/theme_values.xml
echo "<item>"${G4:=4G}"</item>" >>$TMPDIR/theme_values.xml
echo "<item>"${G4:=4G}"+</item>" >>$TMPDIR/theme_values.xml
echo "</string-array>" >>$TMPDIR/theme_values.xml
fi
[[ $FengKuai == 1 ]] && echo '<dimen name="notification_divider_height">6dp</dimen>
<color name="notification_panel_background">#00000000</color>
<dimen name="qs_panel_expand_indicator_width">0dp</dimen>' >>$TMPDIR/theme_values.xml
[[ -n $Notification_Bar_Fillet ]] && echo "<dimen name=\"notification_stack_scroller_bg_radius\">"$Notification_Bar_Fillet"dp</dimen>" >>$TMPDIR/theme_values.xml && echo "通知栏信息圆角已改为${Notification_Bar_Fillet}dp" && echo "[通知栏信息圆角已改为${Notification_Bar_Fillet}dp];" >>$YiAZ
[[ -n $FengKuai_hight ]] && sed -i '/notification_divider_height/d' $TMPDIR/theme_values.xml && echo "<dimen name=\"notification_divider_height\">"$FengKuai_hight"dp</dimen>" >>$TMPDIR/theme_values.xml && echo "分块距离已改为$FengKuai_hight" && echo "[分块距离已改为$FengKuai_hight];" >>$YiAZ
[[ $BaiBian == 1 ]] && echo '<dimen name="notification_custom_view_margin_end">0dp</dimen>
<dimen name="notification_custom_view_margin_start">0dp</dimen>
<dimen name="notification_row_extra_padding">0dp</dimen>
<dimen name="notification_stack_scroller_top_bottom_padding">0dp</dimen>
<dimen name="notification_custom_view_corner_radius">0dp</dimen>' >>$TMPDIR/theme_values.xml && echo "[通知栏去白边];" >>$YiAZ && echo "已安装通知栏去白边"
[[ $Forced_Expansion == 1 ]] && echo '<dimen name="notification_min_height_increased">133.6dp</dimen>
<dimen name="notification_min_height_legacy">133.6dp</dimen>' >>$TMPDIR/theme_values.xml && echo "[通知栏强制展开];" >>$YiAZ && echo "已安装通知栏强制展开"
[[ -n $LiangDuXiaJuLi ]] && echo "<dimen name=\"qs_panel_expand_indicator_height\">${LiangDuXiaJuLi}dp</dimen>" >>$TMPDIR/theme_values.xml && echo "[亮度条与通知栏距离已改为${LiangDuXiaJuLi}dp];" >>$YiAZ && echo "亮度条与通知栏距离已改为${LiangDuXiaJuLi}dp"
[[  -n $Brightness_hight ]] && echo "<dimen name=\"qs_brightness_dialog_height\">${Brightness_hight}dp</dimen>" >>$TMPDIR/theme_values.xml && echo "[亮度条高度已改为${Brightness_hight}dp];" >>$YiAZ && echo "亮度条高度已改为${Brightness_hight}dp"
[[  -n $LiangDuShangJuLi ]] && echo "<dimen name=\"qs_brightness_top_margin\">${LiangDuShangJuLi}dp</dimen>" >>$TMPDIR/theme_values.xml && echo "[亮度条与快捷开关距离已改为${LiangDuShangJuLi}dp];" >>$YiAZ && echo "亮度条与快捷开关距离已改为${LiangDuShangJuLi}dp;"
[[  -n $Brightness_Fillet ]] && echo "<dimen name=\"panel_content_corner_radius\">${Brightness_Fillet}dp</dimen>" >>$TMPDIR/theme_values.xml && echo "[亮度条圆角已改为${Brightness_Fillet}dp];" >>$YiAZ && echo "亮度条圆角已改为${Brightness_Fillet}dp"
[[  -n $Brightness_Adjusted ]] && echo "<color name=\"qs_brightness_progress_color\">${Brightness_Adjusted}</color>" >>$TMPDIR/theme_values.xml && echo "[亮度条已调节颜色已改为${Brightness_Adjusted}];" >>$YiAZ && echo "亮度条已调节颜色已改为${Brightness_Adjusted}"
[[  -n $Brightness_Background ]] && echo "<color name=\"qs_brightness_background_color\">${Brightness_Background}</color>" >>$TMPDIR/theme_values.xml && echo "[亮度条未调节背景色已改为${Brightness_Background}];" >>$YiAZ && echo "亮度条未调节背景色已改为${Brightness_Background}"
$Merge_Theme && JieYa_Theme com.android.systemui
[[ $NotificationBar_UI == Native ]] && JieYa_Theme com.android.systemui
XML_W
[[ ! -d $lu ]] && mkdir -p $lu
zip -jq $lu6 $TMPDIR/theme_values.xml
fi
[[ -f $lu10 ]] && mv -f $lu/{framework-res.zip,framework-res}
[[ -f $lu17 ]] && mv -f $lu/{icons.zip,icons}

if [[ $Installation_plan == Magisk ]]; then
echo "您已选择了方案①Magisk挂载方案"
echo "即将安装……"
echo "Powered by Magisk (@topjohnwu)"
MODPATH=$Modules_Dir/MIUI_In_Common_Use
rm -rf $MODPATH
mkdir $MODPATH
cp -rf $TMPDIR/system $MODPATH
cp -f $TMPDIR/module.prop $MODPATH
ui_print "----------------------------"
echo "安装完成"
echo "由于您选择的Magisk挂载方案，所以必须再重启后，然后去个性化主题里应用一遍默认主题才会生效"
CQ
elif [[ $Installation_plan == mtz ]]; then
echo "您已选择了方案②打包成.mtz主题"
[[ -n $Export_Directory && ! -d $lu12 ]] && echo "输入目录不存在开始创建" && mkdir -p $lu12 && echo "创建成功，开始打包…………" || [[ -n $Export_Directory && -d $lu12 ]] && echo "输入的路径目录存在，开始打包…………" || [[ -z $Export_Directory ]] && echo "您没有自定义输出路径，将会导出到默认路径"
cd $lu
zip -rq ${Export_Directory:=$GJZS/搞机助手"$Time"}.mtz ./*
cd $TMPDIR/mtz
zip -rq ${Export_Directory:=$GJZS/搞机助手"$Time"}.mtz ./*
echo -e "文件已打包到\n${Export_Directory:=$GJZS/搞机助手"$Time"}.mtz"
elif [[ $Installation_plan == Automatic ]]; then
echo "您已选择了方案③全自动化方案，自动应用生效"
fi

return 1



am start -n com.android.thememanager/com.android.thememanager.activity.ThemeTabActivity


if [[ $Screenshots == 1 ]]; then
[[ ! -d $lu ]] && mkdir -p $lu
cp -rf $jian6 $lu
echo "已选择安装秒截图、突破MIUI限制，移除卡米、高级电源菜单"
if [[ $Version == "8.1.0" && $SDK == 27 ]]; then
echo "秒截图、突破MIUI限制，移除卡米已自动启用安卓8.1方案"
echo -n "[秒截图、突破MIUI限制，移除卡米，高级电源菜单];" >>$YiAZ
cp -rf $jian5 $lu4
elif [[ $Version == "9" && $SDK == 28 ]]; then
echo "秒截图、突破MIUI限制，移除卡米已自动启用安卓9方案"
echo -n "[秒截图、突破MIUI限制，移除卡米，高级电源菜单];" >>$YiAZ
cp -rf $jian7 $lu4
elif [[ $Version == "10" && $SDK == 29 ]]; then
echo "秒截图、突破MIUI限制，移除卡米已自动启用安卓10方案"
echo -n "[秒截图、突破MIUI限制，移除卡米，高级电源菜单];" >>$YiAZ
cp -rf $jian $lu4
else
echo "安装失败，您的安卓版本不是安卓8.1.0，安卓9，安卓10"
fi
fi


echo -e "严重警告⚠！！！不要把我的$z搞机助手专用配置文件去Magisk里或者rec里刷入！\n严重警告⚠！！！不要把我的$z搞机助手专用配置文件去Magisk里或者rec里刷入！\n严重警告⚠！！！不要把我的$z搞机助手专用配置文件去Magisk里或者rec里刷入！"
rm -rf $TMPDIR $lu2 &>/dev/null
downloaddir="Download download Quark/Download QQBrowser/其他 UCDownloads kbrowser_fast/download ADM 360Browser/download 360LiteBrowser/download"
for i in $downloaddir; do
mkdir -p $TMPDIR && cp -rf $SDdir/$i/$2 $TMPDIR &>/dev/null
done
if [[ -f $zipFile ]]; then
echo "$z配置文件存在即将安装……"
else
echo "您还没有下载MIUI通用配置文件，无法继续安装"
sleep 1
echo -e "配置文件使用说明：支持识别常用下载路径，无需你手动移动，也就是说下载完后再启用［搞机助手］来重新继续个性化选择安装\n原理通过主题代码实现！不修改系统重要APK，所以通用小米全机型全MIUI版本全安卓版本可用"
echo "正在前往蓝奏云下载$2，倒计时开始……"
for i in $(seq 5 -1 1); do
echo $i
sleep 1
done
echo "即将跳转"
	am start -a android.intent.action.VIEW -d https://www.lanzous.com/b880553 >/dev/null 2>/dev/null
sleep 3
	exit
fi

}

. $Load MIUI