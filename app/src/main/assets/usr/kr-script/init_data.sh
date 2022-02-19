Configuration=1970010101
Magisk_Warehouse_version=1970010101
App_Store_version=1970010101
Show_Compatibility_Mode=1
MIUI=0


case "$1" in

#应用
com.topjohnwu.magisk)
apk='com.topjohnwu.magisk'
name='Magisk'
version='256d7156-alpha'
versionCode='23018'
author='vvb2060 & John Wu'
description='Magisk Manager'
time='2022年1月24日'
    [[ $Choice = 1 ]] && Download -cos 'Magisk_256d7156-alpha.apk' "$1.apk" 10369556 534502af26e489fbb1986bb7d6f98aaf "$1.apk"
;;

Han.automatic.rescue)
apk='Han.automatic.rescue'
name='神仙自动救砖'
version='v2021090800'
versionCode='95'
author='by：Han | 情非得已c'
description='神仙自动救砖'
time='2021年9月12日'
    [[ $Choice = 1 ]] && Download -file 'APK/Han.automatic.rescue-v2021090800.apk' "$1.apk" 1680325 9b538f2ad50cd47bb35199acc615c02d "$1.apk"
;;

org.lsposed.manager)
apk='org.lsposed.manager'
name='LSPosed 模块管理器'
version='v1.6.5'
versionCode='6272'
author='LSPosed Developers'
description='LSPosed Xposed框架模块管理器【这是管理器，模块请前往Magisk模块仓库安装】'
apkfile="$PeiZhi_File/$apk-$versionCode.apk"
time='2021年12月18日'
    if [[ $Choice = 1 ]]; then
        [[ $SDK -lt 27 ]] && abort "！$name-$version（$versionCode）不支持安卓8.1.0以下系统"
        if [[ ! -s "$apkfile" ]]; then
            rm -rf "$PeiZhi_File/$apk-"*.apk
            . "$Load" riru_lsposed
            unzip -p "$Download_File" 'manager.apk' >$apkfile
        fi
    fi
    Download_File="$apkfile"
;;

rikka.riru)
apk='rikka.riru'
name='Riru'
version='25.4.4'
versionCode=426
author='Rikka  酷安@蓝莓味绿茶 '
description='显示Riru状态【最新版的riru已经移除了此app，此为25.4.4的旧版模块中提取】'
apkfile="$PeiZhi_File/$apk-$versionCode.apk"
time='2021年5月15日'
    if [[ $Choice = 1 ]]; then
        if [[ ! -s "$apkfile" ]]; then
            rm -rf "$PeiZhi_File/$apk-"*.apk
            Riru_version=3
            . "$Load" riru-core
            unzip -p "$Download_File" 'app.apk' >$apkfile
        fi
    fi
    Download_File="$apkfile"
;;

#模块
Automatic_brick_rescue)
id='Automatic_brick_rescue'
name='自动神仙救砖'
version='v2021081508'
versionCode=43
author='by：Han | 情非得已c & 快播内部工作人员'
description='用途：当刷入某模块后导致无法正常开机，自动触发已设置好的救砖操作（建议用应用仓库里面那个）'
time='2021年8月15日'
;;

riru_lsposed)
id='riru_lsposed'
name='Riru - LSPosed'
version='v1.6.5'
versionCode='6272'
author='LSPosed Developers'
description='一款基于Riru API开发的Xposed框架，支持运行在安卓8.1.0 ~ 12系统上。需要安装Riru v25.0.0或更高版本，Telegram: @LSPosed'
time='2021年12月18日'
    if [[ $Choice = 1 ]]; then
        mask -v
        if [[ $MAGISK_VER_CODE -ge 23000 ]]; then
             [[ $Choice = 1 ]] && Download -cos "LSPosed-v1.6.5-6272-riru-release.zip" "$1.zip" 2073642 c54751a0f312bb72c4669d212339a7fa "$1.zip"
        else
            echo "- 检测到Magisk版本在v23以下，无法安装最新版$version（$versionCode），开始安装v1.3.4（5501）版本"
            Download -file "Modules/LSPosed/LSPosed-v1.3.4-5501-release.zip" "$1.zip" 2189720 de39ec10f67b538fbdc60b7f0e6520f7 "$1.zip"
        fi
    fi
;;

riru_edxposed)
showapk='4.6.2-pre (46200)'
id='riru_edxposed'
name='Riru - EdXposed'
version='v0.5.2.2_4683-master'
versionCode='4683'
author='solohsu, MlgmXyysd'
description='一款基于Riru API开发的Xposed框架，支持运行在安卓8 ~ 11系统上。需要安装Riru v23或更高版本【请使用riru25.4.4及以下版本】，Telegram: @EdXposed'
time='2021年2月18日'
    [[ $Choice = 1 ]] && Riru_version=3 && Download -coding "21051601/modules/EdXposed-v0.5.2.2_4683-master-release.zip" "$1.zip" 3461516 71382a57c7e7861b4695d2089e5422a9 "$1.zip"
;;

riru_dreamland)
showapk='0.0.7(7)'
id='riru_dreamland'
name='Riru - Dreamland（梦境框架）'
author='canyie'
version='2.1_2100'
versionCode='2100'
description='一款基于Riru API开发的Xposed框架，支持运行在安卓 7.0 ~ 11，需要安装Riru v23或更高版本，Telegram：@DreamlandFramework, QQ群：949888394'
time='2021年10月4日'
    [[ $Choice = 1 ]] && Download -cos "magisk-dreamland-2100.zip" "$1.zip" 729692 a1f0560c33ae29b0d55f3b3d3968d9e4 "$1.zip"
;;

xposed)
id='xposed'
name='Xposed Framework（原始Xposed框架）'
version='v90-beta3'
versionCode='9030'
author='rovo89 & topjohnwu'
description='打包的官方Xposed框架 by @topjohnwu，支持安卓 5-8.1'
time='2021年3月24日'
    [[ $Choice = 1 ]] && Download -file "Modules/Xposed/xposed.zip" "$1.zip" 108675627 d083690c555fa59b5f29112fc1dbb0dc "$1.zip"
;;

MIUI-12_All_in_one)
MIUI=1
id='MIUI-12_All_in_one'
version='v1.12'
versionCode=12
name="MIUI 12多合一通用模块"
author='by：Han | 情非得已c'
description="$name"
time='2021年4月6日'
    [[ $Choice = 1 ]] && Download -coding "21051601/modules/$1.zip" "$1.zip" 1125623 6a76d73f76635d53395539e13c72af07 "$1.zip"
;;

MIUI_In_Common_Use)
MIUI=1
id='MIUI_In_Common_Use'
version='2019-08-17'
versionCode='1'
name="MIUI9 - MIUI10多合一通用模块"
author='by：Han | 情非得已c'
description="$name"
time='2019年8月17日'
;;

GJZS_Theme_Color)
MIUI=1
id='GJZS_Theme_Color'
version='v1'
versionCode='1'
name='自定义「搞机助手」主题配色'
author='by：Han | 情非得已c'
description="$name"
time='2020年6月15日'
;;

Game_BianShengQi)
MIUI=1
Show_Compatibility_Mode=0
id='Game_BianShengQi'
name='MIUI开发版游戏加速变声器'
version='v1'
versionCode='1'
author='淡淡的影寒'
description='工作原理：在prop内增加ro.vendor.audio.voice.change.support=true，打开游戏加速变声器功能'
time='2020年6月15日'
    [[ $Choice = 1 ]] && . ./Magisk_Module/$1.sh
;;

Xiaomi_Full_frame_rate)
MIUI=1
Show_Compatibility_Mode=0
id='Xiaomi_Full_frame_rate'
name='小米系列全局高刷'
version='v1.3'
versionCode='3'
author='by：Han | 情非得已c'
description='使用模块方式冻结电量和性能，让支持小米高刷新率的设备，全局使用高刷，需要把在设置里 -->显示 -->屏幕刷新率设置为最高刷新率'
time='2020年6月25日'
    [[ $Choice = 1 ]] && . ./Magisk_Module/$1.sh
;;

Magisk_Abnormal_Repair)
id='Magisk_Abnormal_Repair'
name='Magisk异常修复'
version='v1.2'
versionCode='3'
author='by：Han | 情非得已c'
description='修复进入Magisk时提示：Magisk 不支持安装为系统应用，请还原为用户应用。'
description2='修复进入Magisk时提示Running this app as a system app is not supported. Please revert the app to a user app.翻译：不支持将Magisk作为系统应用程序运行，请将该应用还原为用户应用'
time='2021年2月25日'
;;

Hide_system_ROOT)
Show_Compatibility_Mode=0
id='Hide_system_ROOT'
name='隐藏系统ROOT'
version='v1.6'
versionCode=6
author='by：Han | 情非得已c'
description='隐藏除Magisk以外的系统ROOT，只保留magisk su，因为系统ROOT的存在会让Magisk Hide失效，导致部分应用仍然会检测到ROOT，且部分机型会存在Magisk掉ROOT的情况，同时也还可以修复进入Magisk时提示
检测到不属于 Magisk 的 su 文件，请删除其他超级用户程序。其实说白了就是存在系统ROOT导致的'
time='2021年3月7日'
    [[ $Choice = 1 ]] && . ./Magisk_Module/$1.sh
;;

Volume_Adjustment)
id='Volume_Adjustment'
name='媒体音量级别调节'
version='v1.3'
versionCode='3'
author='by：Han | 情非得已c'
description='将默认的按下音量键15次后放大至最大音量，更改为自己喜欢的数值，我只在小米上测试OK，其它机型自己测试'
time='2020年12月12日'
;;

github-hosts)
Show_Compatibility_Mode=0
id='github-hosts'
name='解决Github网址打不开'
version='v2.0'
versionCode=7
author='by：Han | 情非得已c & 快播内部工作人员'
description='解决Github网址打不开，如果失效请再次安装本模块即可'
time='2021年8月19日'
    [[ $Choice = 1 ]] && . ./Magisk_Module/$1.sh

;;

lanzou-hosts)
Show_Compatibility_Mode=0
id='lanzou-hosts'
name='解决蓝奏云旧网址打不开'
version='v1'
versionCode=1
author='People11'
description='解决蓝奏云旧网址打不开'
time='2021年8月19日'
    [[ $Choice = 1 ]] && . ./Magisk_Module/$1.sh
;;

Freezing_system_app)
id='Freezing_system_app'
name='使用Magisk模块方式冻结系统应用'
version='v1'
versionCode='1'
author='by：Han | 情非得已c'
description="$name"
time='2020年8月9日'
;;

Convert_to_system_app)
id='Convert_to_system_app'
name='三方应用转系统应用'
version='v1.2'
versionCode='2'
author='by：Han | 情非得已c'
description='自定义方式使用模块方式将三方应用转为系统应用'
time='2020年8月20日'
;;

Remove_Temperature_Control)
id='Remove_Temperature_Control'
name='移除温控'
version='v2.1'
versionCode=12
author='People11'
description='以Magisk模块移除温控文件'
time='2021年10月4日'
;;

Clone_Configuration)
id=Clone_Configuration
name=克隆主用户EDXposed模块配置
version='v2021021402'
versionCode=2
author='by：Han | 情非得已c'
description='免双开EDXposed Manager和Xposed模块，使双开应用同步主用户Xposed模块配置'
time='2021年2月14日'
;;

wifi-bonding)
Show_Compatibility_Mode=0
id='wifi-bonding'
name='Wifi Bonding - 让Wi-Fi带宽提速（高通）'
version='1.14'
versionCode='15'
author='simonsmh'
description='Doubles your wi-fi bandwith by modifying WCNSS_qcom_cfg.ini（通过修改WCNSS_qcom_cfg.ini，让Wi-Fi带宽提速至最大）'
time='2020年12月13日'
    [[ $Choice = 1 ]] && . ./Magisk_Module/$1.sh
;;

Transition_Animation)
id='Transition_Animation'
name='过渡动画切换（不通用）'
version='v2020020300'
versionCode='1'
author='by：Han | 情非得已c'
description='原理：通过修改Android 系统，修改过渡动画。'
time='2020年6月15日'
    [[ $Choice = 1 ]] && Download -cos "Transition_Animation.zip" "$1.zip" 732022 c88194b23dc79665725d6aad47851faf "$1.zip"
;;

Model_Camouflage)
id='Model_Camouflage'
name='机型伪装'
version='v114514'
versionCode='114514'
author='People11'
description='原理：通过Magisk修改prop达到机型伪装。'
time='2021年11月14日'
;;

SELinux_OFF)
Show_Compatibility_Mode=0
id='SELinux_OFF'
name='关闭SELinux'
version='v1.3'
versionCode='3'
author='by：Han | 情非得已c'
description='在每次重启/开机时，自动关闭SELinux/宽容模式/Permissive，针对部分模块需要关闭SELinux才能正常开机，以及部分Xposed模块需要关闭才生效，除非你很清楚关闭SELinux后果，否则不推荐使用本模块'
time='2021年2月7日'
    [[ $Choice = 1 ]] && . ./Magisk_Module/$1.sh
;;

SELinux_ON)
Show_Compatibility_Mode=0
id='SELinux_ON'
name='开启SELinux'
version='v1.3'
versionCode='3'
author='by：Han | 情非得已c'
description='在每次重启/开机时，自动开启SELinux/严格模式/强制模式/Enforcing，针对部分官改ROM系统默认关闭SELinux'
time='2021年2月7日'
    [[ $Choice = 1 ]] && . ./Magisk_Module/$1.sh
;;

riru-core)
List='：
riru-core-v21.3(36).zip
'
id='riru-core'
name='Riru (Riru - Core)'
version='v26.1.3.r513.8e95115fd4'
versionCode=513
author='Rikka, yujincheng08'
description='提供一种将代码注入zygote进程的方法，所有以Riru开头的模块必刷模块【需要使用EdXposed模块的用户请使用25.4.4版本，不要更新】'
time='2021年11月7日'
if [[ $Riru_version -eq 1 ]]; then
    [[ $Choice = 1 ]] && Download -gh "RikkaApps/Riru/releases/download/v26.1.3/riru-v26.1.3.r513.8e95115fd4-release.zip" "$1.zip" 172118 39e9016e3042088439689c259c8dcfa5 "$1.zip"
elif [[ $Riru_version -eq 2 ]]; then
    #riru-core-21.3
    [[ $Choice = 1 ]] && Download -file "Modules/Riru/riru-core-v21.3.zip" "$1-v21.3.zip" 541223 6c395f29a2cc50ae4f4efdaf87f78ca3 "$1-v21.3.zip"
elif [[ $Riru_version -eq 3 ]]; then
    #riru-core-25.4.4
    [[ $Choice = 1 ]] && Download -file "Modules/Riru/riru-v25.4.4-release.zip" "$1-25.4.4.zip" 235467 cd0f5ef48c3da69997f0633d8d3d27b0 "$1-25.4.4.zip"
fi
;;

exit_sideload)
    Download_File="$PeiZhi_File/$1.zip"
;;

Card_Brush_Bag)
    Download_File="$PeiZhi_File/Card_Brush_Bag/$3.zip"
;;

MIUI)
    MIUI -file "Modules/MIUI1.4.7.zip" MIUI1.4.7.zip 6504587 ba44181b58d10929b7ae1fc3293dd659 MIUI
;;

Charging_Sound_Effect)
    versionCode=1
    [[ $Choice = 1 ]] && Download -file "Modules/Charging_Sound_Effect.zip" "$1.zip" 6297837 bb400cbb13333d3d68dc73dc4f6d3dee "$1.zip"
;;

BootAnimation_Screen1)
    BootAnimation_Screen1 -file "Modules/BootAnimation_Screen1.zip" "$1.zip" 10697488 8a69c474a8287108a1a79b01146349a7 "$1.zip" 18
;;

Zipsigner)
    Download -file "Other/Zipsigner-1.zip" "$1-1.zip" 5206525 8b75d8340b336f118d3c15db46b53cbb "$1-"
;;

payload_dumper-win64)
    [[ $Choice = 1 ]] && Download -file "Other/payload_dumper-win64.zip" "$1.zip" 6755703 20029a0740cba709789ad074949bf5fa "$1.zip"
;;

EdXposed_Manager_Repo)
    Download -cos "repo_cache.db" "repo_cache.db" 5951488 61e3c689b90ba063247519ac8583b3c8 "repo_cache.db"
;;

Installation_lion)
    version=3.7.5-miui
    versionCode=42
    [[ $Choice = 1 ]] && Download -coding "21051601/apks/$1.apk" "Installation_lion.apk" 1869340 865a0a9a40d289a36e9a8ee17bb6e774 "Installation_lion.apk"
;;

com.miui.miwallpaper)
    version='ALPHA-2.6.205-03082129-ogl'
    versionCode=206000205
    [[ $Choice = 1 ]] && Download -cos "com.miui.miwallpaper.apk" "$1.apk" 56406991 124a1dd155294d05827264f253ce860f "$1.apk"
;;

com.miui.miwallpaper.snowmountain)
    version='ALPHA-2.6.151-12171721-ogl'
    versionCode=206000151
    [[ $Choice = 1 ]] && Download -cos "com.miui.miwallpaper.snowmountain.apk" "$1.apk" 89837236 f5c971e0e6735ab653b4dd8f0bbbc6ac "$1.apk"
;;

Install_Applet)
    name=Applet
    versionCode=81
    Install_Applet2 -url "https://qqcn.coding.net/p/import-rt20/d/files/git/raw/master/Applet-81.zip" "$name.zip" 8341732 d0b98b504265f9766cd07c0762bfbf6a "$name" $versionCode
;;

binwalk)
    version=2.3.1
    Download -file "Other/binwalk.zip" "$1.zip" 39656863 023e3f4d48ecf496a67d283c071d3129 "$1.zip"
;;

Install_busybox)
    name="busybox_$Type"
    [[ $Type = arm ]] && Start_Install -url "https://qqcn.coding.net/p/import-rt20/d/files/git/raw/master/$name" "$name-selinux" 1452044 92a3d5c291124e5b8bd4d7b04c24362d "$name" 1.33.1 13310
    [[ $Type = arm64 ]] && Start_Install -url "https://qqcn.coding.net/p/import-rt20/d/files/git/raw/master/$name" "$name-selinux" 2066520 2340fc8c0f18462fc0dffe9e591c5c01 "$name" 1.33.1 13310
    [[ $Type = x86 ]] && Start_Install -url "https://qqcn.coding.net/p/import-rt20/d/files/git/raw/master/$name" "$name-selinux" 2094872 cd5fde5c345e711657709599f348e260 "$name" 1.33.1 13310
    [[ $Type = x86_64 ]] && Start_Install -url "https://qqcn.coding.net/p/import-rt20/d/files/git/raw/master/$name" "$name-selinux" 2222408 195292917f4c3a3815ed352cac3bda99 "$name" 1.33.1 13310
    [[ $Type = mips ]] && Start_Install -url "https://qqcn.coding.net/p/import-rt20/d/files/git/raw/master/$name" "$name" 1918732 7886ed84533e344c0ea0e87ff0578749 "$name" 1.33.1 13310
    [[ $Type = mips64 ]] && Start_Install -url "https://qqcn.coding.net/p/import-rt20/d/files/git/raw/master/$name" "$name" 1939440 c8c7311463e2999af63540c51628364e "$name" 1.33.1 13310
;;

*)
    abort "！未找到$1服务"
;;
esac
true
