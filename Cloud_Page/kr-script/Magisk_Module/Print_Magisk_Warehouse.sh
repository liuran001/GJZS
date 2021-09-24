#本脚本由　by Han | 情非得已c，编写
#应用于搞机助手上


chuli() {
    echo "$@" | sed -e 's/\&/\&#38;/g' -e 's/\"/\&#34;/g' -e 's/</\&#60;/g' -e 's/>/\&#62;/g'
}


start_xml() {
cat <<Han
<?xml version="1.0" encoding="UTF-8" ?>
<group>
    <text>
        <slices>
            <slice size="18" color="#FFFF0000">已云端上架了$H个Magisk模块</slice>
        </slices>
    </text>
    <text>
        <slices>
            <slice size="16" color="#FF9C27B0">本功能为云端收集模块，模块出现的任何问题请联系作者，如果你有好的模块想分享，或者你是模块作者，可私信我云端上架分享大家一起享用，如果模块无法安装请尝试开关兼容模式</slice>
            <slice break="true"></slice>
            <slice break="true"></slice>
            <slice size="16" color="#FF9C27B0">免责申明：&#x000A;一旦使用了本页功能，出现的一切后果请自行承担风险，与本人无关</slice>
        </slices>
    </text>
</group>

<group>
<!-- START -->
    <action auto-off="true" interruptible="false" reload="true">
        <title>刷新模块信息</title>
        <summary>清除已缓存的在线仓库信息，强制刷新数据以及刷新模块变动过后的信息</summary>
        <set>. ./Magisk_Module/Print_Magisk_Warehouse.sh -s</set>
    </action>
<!-- END -->
</group>

Han
}


title() {
cat <<Han
<group>
<!-- START -->
    <text>
        <slices>
            <slice size="14" color="#FFFF0000">$1</slice>
        </slices>
    </text>
<!-- END -->
Han
}


p() {
    . "$Load" "$1"
    name=`chuli "$name"`
    version=`chuli "$version"`
    author=`chuli "$author"`
    description=`chuli "$description"`

    case "$2" in
    -y)
        user_version2=`grep_prop version "$Modules_Dir/$1/module.prop"`
        user_versionCode2=`grep_prop versionCode "$Modules_Dir/$1/module.prop"`
        user_version=`chuli $user_version2`
        user_versionCode=`chuli $user_versionCode2`
        desc="版本：$version&#x000A;版本号：$versionCode&#x000A;已安装：$user_version（$user_versionCode）&#x000A;作者：$author&#x000A;描述：$description&#x000A;更新于：$time"
    ;;
    
    *)
        desc="版本：$version&#x000A;版本号：$versionCode&#x000A;作者：$author&#x000A;描述：$description&#x000A;更新于：$time"
    ;;
    esac
        if [[ "$MIUI" = 1 ]]; then
           [[ $Check_Ui_miui -ne 1 ]] && Remove=$((Remove+1)) && return 0
        fi


case "$1" in
znzl)
cat <<Han
<!-- START -->
    <page before-load=". \$Load $1 -d" config-sh=". \$Pages/Intelligent_Assistant.xml">
        <title>$name</title>
        <desc>$desc</desc>
    </page>
<!-- END -->
Han
;;

Automatic_brick_rescue)
cat <<Han
<!-- START -->
    <action interruptible="false">
        <title>$name</title>
        <desc>$desc</desc>
        <set>. ./Magisk_Module/Automatic_brick_rescue.sh $1</set>
        <params>
            <param name="a" value="前言：&#x000A;本模块的目的很明确在无法开机时禁用其它所有模块尝试是否能够正常开机，如果禁用所有模块都无法开机的话，那肯定是有的模块在刷入时对系统某些文件做了直接修改，这种情况下，自动神仙救砖是无法自动救砖的！" readonly="readonly"/>
            <param name="Clean" title="&#x000A;"label="①　尝试一次最后的挣扎？" desc="用途：刷入一些替换系统apk模块后，导致无法开机问题去清除系统包名缓存数据，同时为有的模块可能需要关闭SELinux才可以开机去关闭SELinux" type="checkbox" value-sh="grep_prop Clean \$Data_Dir/Automatic_brick_rescue.log || echo 1"/>
            <param name="Cache" title="当上面勾选时才可以设置重启第几次时执行方案①" type="seekbar" max="9" min="2" value-sh="grep_prop Cache \$Data_Dir/Automatic_brick_rescue.log || echo 2"/>
            <param name="Frequency" title="&#x000A;&#x000A;②　再重启多少次后仍无法开机强制自动救砖" desc="注：如果方案①勾选时，设置的值必须比上面设置的值大，如果方案①没有勾选可把这里改为最小值2" type="seekbar" max="9" min="2" value-sh="grep_prop Frequency \$Data_Dir/Automatic_brick_rescue.log || echo 3"/>
            <param name="Compulsory_Rescue" title="设置强制自动救砖操作" desc="用途：如果重启几次后或无限在第一屏重启几次，还是未能开机强制救砖要执行的操作。" options-sh="cat ./Magisk_Module/Automatic_brick_rescue_Options2.sh || echo Disable_and_recovery" value-sh="grep_prop Compulsory_Rescue \$Data_Dir/Automatic_brick_rescue.log || echo Disable_and_recovery" required="true"/>
            <param name="Set_Time" title="&#x000A;&#x000A;③　第二屏等待时间，时间单位：分钟" desc="给手机限定正常开机时间或者卡在第二屏时间过久，超过了设置的时间无法开机时就进行自动救砖操作。&#x000A;特别警告：请根据自己手机正常开机时间去设置适当的值，如果设置的比正常开机短会造成无法开机的后果，如果手机一直卡在第一屏方案③会无法生效，只有方案①②才会生效" type="number" required="true" value-sh="grep_prop Set_Time \$Data_Dir/Automatic_brick_rescue.log || echo 2.5"/>
            <param name="OTA" title="&#x000A;" label="开启OTA支持" desc="开启此选项后当手机进行系统更新后首次开机会将上面设置的第二屏等待时间修改为15分钟（你升完系统开个机不可能比15分钟还久吧），正常启动后会还原为上方设置（实验性功能，不保证可用）" type="checkbox" value-sh="grep_prop OTA \$Data_Dir/Automatic_brick_rescue.log || echo 1"/>
            <param name="DPI" title="&#x000A;" label="开启屏幕DPI锁定" desc="开启此选项后会将刷入时DPI记录，并在每次开机后检测DPI是否与记录值相同，如果不同将会在开机后还原屏幕DPI（每次修改DPI后都需要重刷此模块刷新记录值）（实验性功能，不保证可用）" type="checkbox" value-sh="grep_prop DPI \$Data_Dir/Automatic_brick_rescue.log || echo 0"/>
            <param name="size" title="&#x000A;" label="开启屏幕分辨率锁定" desc="开启此选项后会将刷入时屏幕分辨率记录，并在每次开机后检测屏幕分辨率是否与记录值相同，如果不同将会在开机后还原屏幕分辨率（每次修改屏幕分辨率后都需要重刷此模块刷新记录值）（实验性功能，不保证可用）" type="checkbox" value-sh="grep_prop size \$Data_Dir/Automatic_brick_rescue.log || echo 0"/>
            <param name="Pattern" title="设置自动救砖操作" options-sh="cat ./Magisk_Module/Automatic_brick_rescue_Options3.sh" value-sh="grep_prop Pattern \$Data_Dir/Automatic_brick_rescue.log || echo 'Disable'" required="true"/>
        </params>
    </action> 
<!-- END -->
Han
;;

Transition_Animation)
cat <<Han
<!-- START -->
    <action interruptible="false">
        <title>$name</title>
        <desc>$desc</desc>
        <set>. ./Magisk_Module/Transition_Animation.sh $1</set>
        <params>
            <param name="ChongQi" label="是否刷入成功自动重启系统生效" type="switch" />
            <param name="XuanZe" title="请选择动画：" desc="动画名字暂时不知道写啥" options-sh="cat ./Magisk_Module/Transition_Animation_Option.sh" required="true"/>
        </params>
    </action>
<!-- END -->
Han
;;

MIUI-Advanced_power_supply)
cat <<Han
<!-- START -->
    <action interruptible="false">
        <title>$name</title>
        <desc>$desc</desc>
        <set>sh \$install_MOD \${Compatible:=0} 1 None 1 $1</set>
        <params>
            <param name="ChongQi" label="是否刷入成功自动重启系统生效" type="switch" />
            <param name="Style" title="请选择图标样式：" options-sh="printf '1\n2'" required="true"/>
        </params>
    </action>
<!-- END -->
Han
;;

Freezing_system_app)
cat <<Han
<!-- START -->
    <action interruptible="false">
        <title>$name</title>
        <desc>$desc</desc>
        <set>. ./Magisk_Module/Freezing_system_app.sh $1</set>
            <param name="ChongQi" label="是否刷入成功自动重启系统生效" desc="选择Magisk挂载方案时生效" type="switch" />
            <param name="package" type="packages" multiple="true" options-sh=". ./Magisk_Module/Freezing_system_applist.sh" value-sh="[[ -f &#34;\$Data_Dir/Freezing_system_applist.log&#34; ]] &#38;&#38; cat &#34;\$Data_Dir/Freezing_system_applist.log&#34;"/>
            <param name="package2" title="也可以输入包名，多个包名用键盘上的回车换行或者空格隔开即可" ></param>
    </action>
<!-- END -->
Han
;;

Convert_to_system_app)
cat <<Han
<!-- START -->
    <action interruptible="false">
        <title>$name</title>
        <desc>$desc</desc>
        <set>. ./Magisk_Module/Convert_to_system_app.sh $1</set>
            <param name="ChongQi" label="是否刷入成功自动重启系统生效" type="switch" />
            <param name="Retain" label="保留上次已转换成功应用" type="checkbox" value="1" visible="[[ -s \$Data_Dir/Convert_to_system_app.log ]] &#38;&#38; echo 1 || echo 0"/>
            <param name="Location" label="安装目录" options-sh="printf 'app|/system/app\npriv-app|/system/priv-app'" desc="放在/system/priv-app下的应用为系统核心应用，拥有极高的系统权限。/system/app下的应用权限相对较低。"/>
            <param name="package" label="选择要转换的应用" type="app" multiple="true" options-sh=". ./Get_Package_Name-3.sh" value-sh="[[ -f &#34;\$Data_Dir/Convert_to_system_app.log&#34; ]] &#38;&#38; cat &#34;\$Data_Dir/Convert_to_system_app.log&#34;" />
            <param name="Delete" label="删除已转换应用" type="app" multiple="true" options-sh="[[ -f &#34;\$Data_Dir/Convert_to_system_app.log&#34; ]] &#38;&#38; cat &#34;\$Data_Dir/Convert_to_system_app.log&#34;" visible="[[ -s \$Data_Dir/Convert_to_system_app.log ]] &#38;&#38; echo 1 || echo 0" />
    </action>
<!-- END -->
Han
;;

Volume_Adjustment)
cat <<Han
<!-- START -->
    <action interruptible="false">
        <title>$name</title>
        <desc>$desc</desc>
        <set>. ./Magisk_Module/Volume_Adjustment.sh $1</set>
        <params>
            <param name="ChongQi" label="是否刷入成功自动重启系统生效" type="switch" />
            <param name="Rank1" title="防止你很皮，限制输入3-100范围的值" type="int" max="100" min="3" required="0" maxlength="3" />
            <param name="Rank2" title="你也可以选择滑动方案调整" desc="只有当上方输入框没有填写数值时，滑动修改才会生效！" max="100" min="3" type="seekbar" />
        </params>
    </action>
<!-- END -->
Han
;;

Remove_Temperature_Control)
cat <<Han
<!-- START -->
    <action interruptible="false">
        <title>$name</title>
        <desc>$desc</desc>
        <set>. ./Magisk_Module/Remove_Temperature_Control.sh Remove_Temperature_Control</set>
        <params>
            <param name="ChongQi" label="是否刷入成功自动重启系统生效" type="switch" />
            <param name="thermal" label="选择要移除的温控文件" multiple="true" options-sh=". ./Magisk_Module/Remove_Temperature_Control_Options.sh" value-sh=". ./Magisk_Module/Remove_Temperature_Control_Options.sh -d" />
        </params>
    </action>
<!-- END -->
Han
;;

Model_Camouflage)
cat <<Han
<!-- START -->
    <action interruptible="false">
        <title>$name</title>
        <desc>$desc</desc>
        <set>. ./Magisk_Module/Model_Camouflage.sh Model_Camouflage</set>
        <params>
            <param name="a" value="前言：改机型由于参数与原机型参数不同，会伴随着各种bug的例如护眼模式消失，部分机型还指纹不正常等……emmmmm总之就是不完美" readonly="readonly" />
            <param name="ChongQi" label="是否刷入成功自动重启系统生效" type="switch" />
            <param name="Device" label="选择机型模板" options-sh="cat ./Magisk_Module/Model_Camouflage_Option.sh" required="true"/>
            <param name="a1" value="只有当上面选择自定义下面才可以填写生效，然后在下面4个选项里个性化填写，即可制作Magisk模块，支持空格输入。" readonly="readonly" />
            <param name="brand" title="请输入你要伪装的手机品牌" />
            <param name="model" title="输入你要伪装的手机型号" />
            <param name="device" title="请输入你要伪装的手机设备代号" />
            <param name="version" title="请输入你要伪装的版本号，例如MIUI设备的开发版版本号格式是：9.9.3" />
        </params>
    </action>
<!-- END -->
Han
;;

Show_touch)
cat <<Han
<!-- START -->
    <action interruptible="false">
        <title>$name</title>
        <desc>$desc</desc>
        <set>. ./Magisk_Module/Show_touch_install.sh</set>
        <params>
            <param name="ChongQi" label="是否刷入成功自动重启系统生效" type="switch" value-sh="grep_prop ChongQi \$Data_Dir/Show_touch_Option.log"/>
            <param name="Show_touch_Option" title="请选择触摸点" options-sh="cat ./Magisk_Module/Show_touch_Option.log" value-sh="grep_prop Show_touch_Option \$Data_Dir/Show_touch_Option.log" required="true"/>
        </params>
    </action>    
<!-- END -->
Han
;;

MIUI-12_All_in_one)
cat <<Han
<!-- START -->
    <action interruptible="false">
        <title>$name</title>
        <desc>$desc</desc>
        <set>. ./Magisk_Module/MIUI/MIUI-12_All_in_one.sh</set>
        <params>
            <param name="ChongQi" label="是否刷入成功自动重启系统生效" desc="选择Magisk挂载方案时生效" type="checkbox" value-sh="grep_prop ChongQi \$Data_Dir/MIUI-12_All_in_one.log"/>
            <param name="Installation_plan" title="请选择安装方案" desc="选择方案①时如果重启未生效记得应用一遍默认主题即可" options-sh=". ./Magisk_Module/MIUI/Installation_plan.sh" value-sh="grep_prop Installation_plan \$Data_Dir/MIUI-12_All_in_one.log" required="true"/>
            <param name="Export_Directory" title="选择方案②时还可以自定义导出路径和名称，.mtz后缀无需输入" value-sh="grep_prop Export_Directory \$Data_Dir/MIUI-12_All_in_one.log"/>
            <param name="Theme_plan" title="请选择主题安装方案" options-sh="printf '0|不合并主题\n1|合并主题修改（在当前应用主题基础上进行修改）'" value-sh="grep_prop Theme_plan \$Data_Dir/MIUI-12_All_in_one.log" required="true"/>
            <param name="x" value="请开始个性化选择" readonly="readonly" />
            <param name="Gesture_Background" title="请选择手势边缘背景" options-sh="cat ./Magisk_Module/MIUI/Background_Options.log" value-sh="grep_prop Gesture_Background \$Data_Dir/MIUI-12_All_in_one.log" required="true"/>
            <param name="Gesture_Return" title="请选择手势返回特效" options-sh="cat ./Magisk_Module/MIUI/Return_Options.log" value-sh="grep_prop Gesture_Return \$Data_Dir/MIUI-12_All_in_one.log" required="true"/>
            <param name="XiaoBaiTiao" label="小白条沉浸？" type="checkbox" value-sh="grep_prop XiaoBaiTiao \$Data_Dir/MIUI-12_All_in_one.log"/>
            <param name="bt_bottom" label="小白条高度" placeholder="默认：6.0" type="number" value-sh="grep_prop bt_bottom \$Data_Dir/MIUI-12_All_in_one.log"/>
            <param name="bt_width" label="小白条宽度" placeholder="默认：145.0" type="number" value-sh="grep_prop bt_width \$Data_Dir/MIUI-12_All_in_one.log"/>
            <param name="bt_radius" label="小白条粗细" placeholder="默认：1.8499756" type="number" value-sh="grep_prop bt_radius \$Data_Dir/MIUI-12_All_in_one.log"/>
            <param name="jphch_height" title="键盘呼出后离底部高度" placeholder="默认：48" type="number" value-sh="grep_prop jphch_height \$Data_Dir/MIUI-12_All_in_one.log"/>
            <param name="x3" value="桌面自定义系列（留空为默认）" readonly="readonly" />
            <param name="Hide_icon_text" label="隐藏桌面应用程序名称" type="bool" value-sh="grep_prop Hide_icon_text \$Data_Dir/MIUI-12_All_in_one.log" />
            <param name="Home_icon" label="桌面图标风格" options-sh="printf '0|默认\nhide|隐藏所有图标\nys|使用应用原始图标'" value-sh="grep_prop Home_icon \$Data_Dir/MIUI-12_All_in_one.log" />
            <param name="Home_X" title="自定义桌面X布局" desc="X代表横着的图标个数（直接输入数字即可）" placeholder="5" type="int" value-sh="grep_prop Home_X \$Data_Dir/MIUI-12_All_in_one.log" />
            <param name="Home_Y" title="自定义桌面Y布局" desc="Y代表竖着的图标个数（直接输入数字即可）" placeholder="6" type="int" value-sh="grep_prop Home_Y \$Data_Dir/MIUI-12_All_in_one.log" />
            <param name="Home_icon_width" title="自定义桌面图标宽度dp(输入数字即可可以有小数点)" type="number" value-sh="grep_prop Home_icon_width \$Data_Dir/MIUI-12_All_in_one.log" />
            <param name="Home_icon_height" title="自定义桌面图标高度dp(输入数字即可可以有小数点)" type="number" value-sh="grep_prop Home_icon_height \$Data_Dir/MIUI-12_All_in_one.log" />
            <param name="Folder_Preview_width" title="自定义桌面文件夹预览图标大小宽度" desc="(输入数字即可可以有小数点)" type="number" value-sh="grep_prop Folder_Preview_width \$Data_Dir/MIUI-12_All_in_one.log" />
            <param name="Folder_Preview_height" title="自定义桌面文件夹预览图标大小高度" desc="(输入数字即可可以有小数点)" type="number" value-sh="grep_prop Folder_Preview_height \$Data_Dir/MIUI-12_All_in_one.log" />
            <param name="Folder_X" title="自定义桌面文件夹图标横着的图标个数（直接输入数字即可）" type="int" placeholder="3" value-sh="grep_prop Folder_X \$Data_Dir/MIUI-12_All_in_one.log" />
            <param name="Folder_vertical_spacing" title="自定义文件夹内的图标上下间距（直接输入数字即可）" type="int" placeholder="1" value-sh="grep_prop Folder_vertical_spacing \$Data_Dir/MIUI-12_All_in_one.log" />
            <param name="icon_title_text" title="自定义桌面图标下面应用名称颜色（输入#AARRGGBB十六进制颜色即可）" type="color" value-sh="grep_prop icon_title_text \$Data_Dir/MIUI-12_All_in_one.log" />
            <param name="icon_title_text_dark" title="自定义桌面图标下面应用名称在深色模式下颜色（输入#AARRGGBB十六进制颜色即可）" type="color" value-sh="grep_prop icon_title_text_dark \$Data_Dir/MIUI-12_All_in_one.log" />
            <param name="icon_text_size" title="自定义桌面图标下面应用名称字体大小dp(输入数字即可可以有小数点)" type="number" placeholder="推荐10~20+" value-sh="grep_prop icon_text_size \$Data_Dir/MIUI-12_All_in_one.log" />
            <param name="Home_Background" label="桌面图片" desc="选择制作成Magisk模块时不生效" type="file" editable="true" value-sh="grep_prop Home_Background $Data_Dir/MIUI-12_All_in_one.log" />
            <param name="Lock_Background" label="锁屏图片" type="file" editable="true" value-sh="grep_prop Lock_Background $Data_Dir/MIUI-12_All_in_one.log" />
            <param name="qs_Background" title="自定义新版控制中心背景图片" type="file" editable="true" value-sh="grep_prop qs_Background $Data_Dir/MIUI-12_All_in_one.log" />
        </params>
    </action>    
<!-- END -->
Han
;;

com.android.thememanager)
cat <<Han
<!-- START -->
    <action interruptible="false">
        <title>$name</title>
        <desc>$desc</desc>
        <set>. ./Magisk_Module/MIUI/MIUI_Theme_to_Module.sh</set>
        <params>
            <param name="ChongQi" label="是否刷入成功自动重启系统生效" type="switch" />
        </params>
    </action>
<!-- END -->
Han
;;

MIUI_In_Common_Use)
cat <<Han
<!-- START -->
    <action interruptible="false" confirm="true" >
        <title>$name</title>
        <desc>$desc</desc>
        <set>. ./Magisk_Module/MIUI/MIUI_Module.sh</set>
        <params>
            <param name="ChongQi" label="是否刷入成功自动重启系统生效" type="bool" />
            <param name="Installation_plan" title="请选择安装方案" desc="选择方案①时如果重启未生效记得应用一遍默认主题即可" options-sh=". ./Magisk_Module/MIUI/Installation_plan.sh" value-sh="grep_prop Installation_plan \$Data_Dir/MIUI_Module.log" />
            <param name="Export_Directory" label="选择方案②时还可以自定义导出路径和名称，.mtz后缀无需输入" value-sh="grep_prop Export_Directory $Data_Dir/MIUI_Module.log" />
            <param name="a" value-sh="echo 请输入你要提取到的绝对路径包括名称！默认留空提取路径为内部储存目录下Han.GJZS目录里（也就是\$GJZS）如果你输入的路径不存在会自动帮您创建该目录。［已支持带空格和带符号路径］" readonly="readonly" />
            <param name="Theme_plan" title="请选择主题安装方案" options-sh="printf '0|不合并主题\n1|合并主题修改（在当前应用主题基础上进行修改）'" value-sh="grep_prop Theme_plan \$Data_Dir/MIUI_Module.log" />
            <param name="x" value="请开始个性化选择" readonly="readonly" />
            <param name="NotificationBar_UI" title="请选择下拉通知栏样式和状态栏样式" options-sh=". ./Magisk_Module/MIUI/NotificationBar_UI.sh" value-sh="grep_prop NotificationBar_UI \$Data_Dir/MIUI_Module.log" />
            <param name="Gesture_Background" title="请选择手势边缘背景" options-sh=". ./Magisk_Module/MIUI/Gesture_Background.sh" value-sh="grep_prop Gesture_Background \$Data_Dir/MIUI_Module.log" />
            <param name="Gesture_Return" title="请选择手势返回特效" options-sh=". ./Magisk_Module/MIUI/Gesture_Return.sh" value-sh="grep_prop Gesture_Return \$Data_Dir/MIUI_Module.log" />
            <param name="BatteryIcon" title="请选择电池图标样式" options-sh=". ./Magisk_Module/MIUI/BatteryIcon.sh" value-sh="grep_prop BatteryIcon \$Data_Dir/MIUI_Module.log" />
            <param name="Toast" title="请选择toast样式" options-sh=". ./Magisk_Module/MIUI/Toast_Select.sh" value-sh="grep_prop Toast \$Data_Dir/MIUI_Module.log" />
            <param name="Antitouch" label="去除防误触白条" type="bool" value-sh="grep_prop Antitouch \$Data_Dir/MIUI_Module.log" />
            <param name="Weather_AD" label="去除天气预报广告" type="bool" value-sh="grep_prop Weather_AD \$Data_Dir/MIUI_Module.log" />
            <param name="Cloud_service_AD" label="去除小米云服务广告" type="bool" value-sh="grep_prop Cloud_service_AD \$Data_Dir/MIUI_Module.log" />
            <param name="Music_AD" label="去除音乐专辑广告" type="bool" value-sh="grep_prop Music_AD \$Data_Dir/MIUI_Module.log" />
            <param name="Game_Rank" label="去除游戏加速排行" type="bool" value-sh="grep_prop Game_Rank \$Data_Dir/MIUI_Module.log" />
            <param name="Game_Acceleration_AD" label="去除游戏加速网络提速界面" type="bool" value-sh="grep_prop Game_Acceleration_AD \$Data_Dir/MIUI_Module.log" />
            <param name="Hide_All" label="隐藏状态栏全部图标（不包括锁屏）" type="bool" value-sh="grep_prop Hide_All \$Data_Dir/MIUI_Module.log" />
            <param name="Hide_HD" label="隐藏HD" type="bool" value-sh="grep_prop Hide_HD \$Data_Dir/MIUI_Module.log" />
            <param name="Replace_HD" label="HD图标替换为VoLTE" type="bool" value-sh="grep_prop Replace_HD \$Data_Dir/MIUI_Module.log" />
            <param name="Hide_4G" label="隐藏4G" desc="隐藏4G下方自定义4G会无效" type="bool" value-sh="grep_prop Hide_4G \$Data_Dir/MIUI_Module.log" />
            <param name="Data_Arrow" label="隐藏数据传输图标" type="bool" value-sh="grep_prop Data_Arrow \$Data_Dir/MIUI_Module.log" />
            <param name="Hide_WiFi" label="隐藏WiFi图标" type="bool" value-sh="grep_prop Hide_WiFi \$Data_Dir/MIUI_Module.log" />
            <param name="Hide_Bluetooth" label="隐藏蓝牙图标" type="bool" value-sh="grep_prop Hide_Bluetooth \$Data_Dir/MIUI_Module.log" />
            <param name="Hide_Alarm_Clock" label="隐藏闹钟图标" type="bool" value-sh="grep_prop Hide_Alarm_Clock \$Data_Dir/MIUI_Module.log" />
            <param name="Hide_Mute" label="隐藏静音图标" type="bool" value-sh="grep_prop Hide_Mute \$Data_Dir/MIUI_Module.log" />
            <param name="Hide_Vibration" label="隐藏振动图标" type="bool" value-sh="grep_prop Hide_Vibration \$Data_Dir/MIUI_Module.log" />
            <param name="Hide_GPS" label="隐藏GPS图标" type="bool" value-sh="grep_prop Hide_GPS \$Data_Dir/MIUI_Module.log" />
            <param name="Hide_VPN" label="隐藏VPN图标" type="bool" value-sh="grep_prop Hide_VPN \$Data_Dir/MIUI_Module.log" />
            <param name="Hide_No_SIM" label="隐藏无SIM图标" type="bool" value-sh="grep_prop Hide_No_SIM \$Data_Dir/MIUI_Module.log" />
            <param name="Hide_ErJi" label="隐藏耳机图标" type="bool" value-sh="grep_prop Hide_ErJi \$Data_Dir/MIUI_Module.log" />
            <param name="Hide_WiFi_ReDian" label="隐藏WiFi热点图标" type="bool" value-sh="grep_prop Hide_WiFi_ReDian \$Data_Dir/MIUI_Module.log" />
            <param name="Hide_Volte_No_Service" label="隐藏VOLTE无服务图标" type="bool" value-sh="grep_prop Hide_Volte_No_Service \$Data_Dir/MIUI_Module.log" />
            <param name="Hide_Quick_Charging" label="隐藏快充图标" type="bool" value-sh="grep_prop Hide_Quick_Charging \$Data_Dir/MIUI_Module.log" />
            <param name="Hide_WuRao" label="隐藏勿扰模式图标" type="bool" value-sh="grep_prop Hide_WuRao \$Data_Dir/MIUI_Module.log" />
            <param name="Hide_Flight_Mode" label="隐藏飞行模式图标" type="bool" value-sh="grep_prop Hide_Flight_Mode \$Data_Dir/MIUI_Module.log" />
            <param name="Hide_Notify_more" label="隐藏更多通知的3个点图标" type="bool" value-sh="grep_prop Hide_Notify_more \$Data_Dir/MIUI_Module.log" />
            <param name="Past_days" label="通知栏下拉显示今年已过多少天" type="bool" value-sh="grep_prop Past_days \$Data_Dir/MIUI_Module.log" />
            <param name="Negative_One_Screen" label="负一屏透明（旧版）" type="bool" value-sh="grep_prop Negative_One_Screen \$Data_Dir/MIUI_Module.log" />
            <param name="Negative_One_Screen_New" label="负一屏背景透明（新版）" type="bool" value-sh="grep_prop Negative_One_Screen_New \$Data_Dir/MIUI_Module.log" />
            <param name="XiP_NongLi" label="息屏农历" type="bool" value-sh="grep_prop XiP_NongLi \$Data_Dir/MIUI_Module.log" />
            <param name="x1" value="下面还为您做了自定义功能，请在下面进行更深入的自定义（留空为默认）" readonly="readonly" />
            <param name="Home_Background" label="自定义桌面背景图片" type="file" editable="true" value-sh="grep_prop Home_Background \$Data_Dir/MIUI_Module.log" />
            <param name="Lock_Background" label="自定义锁屏背景图片" type="file" editable="true" value-sh="grep_prop Lock_Background \$Data_Dir/MIUI_Module.log" />
            <param name="TouchSlop" title="自定义游戏触摸优化" desc="推介输入3，具体自己调试默认为8（直接输入数字即可）" type="int" value-sh="grep_prop TouchSlop \$Data_Dir/MIUI_Module.log" />
            <param name="Time12" title="自定义状态栏12小时时间格式，默认aaHH:mm" desc="E星期、y年，M月，d日，N农历某月，e农历某天，H小时，m分钟，aa上午晚上等（支持空格）" value-sh="grep_prop Time12 \$Data_Dir/MIUI_Module.log" />
            <param name="Time24" title="自定义状态栏24小时时间格式，默认HH:mm" desc="E星期、y年，M月，d日，N农历某月，e农历某天，H小时，m分钟，（支持空格）" value-sh="grep_prop Time24 \$Data_Dir/MIUI_Module.log" />
            <param name="Statusbar_Start" title="自定义状态栏时间与左边距距离［负数为相反调整］（例如：-20）" desc="输入数字过大会使时间居中(输入数字即可可以有小数点)" type="number" value-sh="grep_prop Statusbar_Start \$Data_Dir/MIUI_Module.log" />
            <param name="Statusbar_End" title="自定义状态栏电池与右边距距离［负数为相反调整］（例如：-20）" desc="输入数字过大会使电池图标居中(输入数字即可可以有小数点)" type="number" value-sh="grep_prop Statusbar_End \$Data_Dir/MIUI_Module.log" />
            <param name="Battery_Digit_Start" title="自定义电池数字右移" desc="推介42(输入数字即可可以有小数点)" type="number" value-sh="grep_prop Battery_Digit_Start \$Data_Dir/MIUI_Module.log" />
            <param name="Battery_Digit_End" title="自定义电池数字左移" desc="推介42(输入数字即可可以有小数点)例如当设置电池数字左移时电池右边有空位就把电池距离右边缘距离填写［-10］" type="number" value-sh="grep_prop Battery_Digit_End \$Data_Dir/MIUI_Module.log" />
            <param name="Battery_Digit_Top" title="自定义电池数字下移" desc="推介：2(输入数字即可可以有小数点)" type="number" value-sh="grep_prop Battery_Digit_Top \$Data_Dir/MIUI_Module.log" />
            <param name="Battery_Digit_Size" title="自定义电池数字大小" desc="推介：14(输入数字即可可以有小数点)" type="number" value-sh="grep_prop Battery_Digit_Size \$Data_Dir/MIUI_Module.log" />
            <param name="Battery_Digit_Color" title="自定义电池数字颜色" desc="（输入#AARRGGBB十六进制颜色即可）" type="color" value-sh="grep_prop Battery_Digit_Color \$Data_Dir/MIUI_Module.log" />
            <param name="Battery_Digit_power_save_Color" title="自定义省电模式电池数字颜色" desc="（输入#AARRGGBB十六进制颜色即可）" type="color" value-sh="grep_prop Battery_Digit_power_save_Color \$Data_Dir/MIUI_Module.log" />
            <param name="G3" title="自定义3G网络标识" value-sh="grep_prop G3 \$Data_Dir/MIUI_Module.log" />
            <param name="G4" title="自定义4G网络标识" value-sh="grep_prop G4 \$Data_Dir/MIUI_Module.log" />
            <param name="H" title="自定义H网络标识" value-sh="grep_prop H \$Data_Dir/MIUI_Module.log" />
            <param name="x2" value="下拉通知栏自定义系列（留空为默认）" readonly="readonly" />
            <param name="FengKuai" label="通知栏分块" type="bool" value-sh="grep_prop FengKuai \$Data_Dir/MIUI_Module.log" />
            <param name="BaiBian" label="通知栏去白边" type="bool" value-sh="grep_prop BaiBian \$Data_Dir/MIUI_Module.log" />
            <param name="Forced_Expansion" label="强制展开" type="bool" value-sh="grep_prop Forced_Expansion \$Data_Dir/MIUI_Module.log" />
            <param name="Notification_Bar_Background" title="自定义通知栏背景图" type="file" editable="true" value-sh="grep_prop Notification_Bar_Background \$Data_Dir/MIUI_Module.log" />
            <param name="FengKuai_BeiJing" title="通知栏分块背景" options-sh="printf '0|默认\n1|半透明\n2|全透明'" type="bool" value-sh="grep_prop FengKuai_BeiJing \$Data_Dir/MIUI_Module.log" />
            <param name="Notification_Bar_Fillet" title="通知栏信息圆角" desc="(输入数字即可可以有小数点)" type="number" value-sh="grep_prop Notification_Bar_Fillet \$Data_Dir/MIUI_Module.log" />
            <param name="FengKuai_hight" title="分块距离调节" desc="(输入数字即可可以有小数点)" type="number" value-sh="grep_prop FengKuai_hight \$Data_Dir/MIUI_Module.log" />
            <param name="LiangDuXiaJuLi" title="亮度条与通知栏距离调节" desc="(输入数字即可可以有小数点)" type="number" value-sh="grep_prop LiangDuXiaJuLi \$Data_Dir/MIUI_Module.log" />
            <param name="Brightness_hight" title="亮度条高度调节" desc="(输入数字即可可以有小数点)" type="number" value-sh="grep_prop Brightness_hight \$Data_Dir/MIUI_Module.log" />
            <param name="LiangDuShangJuLi" title="亮度条与快捷开关距离调节" desc="(输入数字即可可以有小数点)" type="number" value-sh="grep_prop LiangDuShangJuLi \$Data_Dir/MIUI_Module.log" />
            <param name="Brightness_Fillet" title="亮度条圆角调节" desc="(输入数字即可可以有小数点)" type="number" value-sh="grep_prop Brightness_Fillet \$Data_Dir/MIUI_Module.log" />
            <param name="Brightness_Adjusted" title="亮度条已调节颜色" desc="（输入#AARRGGBB十六进制颜色即可）" type="color" value-sh="grep_prop Brightness_Adjusted \$Data_Dir/MIUI_Module.log" />
            <param name="Brightness_Background" title="亮度条未调节背景颜色" desc="（输入#AARRGGBB十六进制颜色即可）" type="color" value-sh="grep_prop Brightness_Background \$Data_Dir/MIUI_Module.log" />
            <param name="quick_settings_num_X" title="自定义下拉状态栏横着的图标个数" desc="如果未展开时没生效旋转一下横屏后再锁定竖屏就可以了（直接输入数字即可）" type="int" value-sh="grep_prop quick_settings_num_X \$Data_Dir/MIUI_Module.log" />
            <param name="quick_settings_num_Y" title="自定义下拉状态栏竖着的图标行数" desc="（直接输入数字即可）" type="int" value-sh="grep_prop quick_settings_num_Y \$Data_Dir/MIUI_Module.log" />
            <param name="x3" value="桌面自定义系列（留空为默认）" readonly="readonly" />
            <param name="Hide_icon" label="隐藏桌面图标" type="bool" value-sh="grep_prop Hide_icon \$Data_Dir/MIUI_Module.log" />
            <param name="Hide_icon_text" label="隐藏桌面应用程序名称" type="bool" value-sh="grep_prop Hide_icon_text \$Data_Dir/MIUI_Module.log" />
            <param name="Home_X" title="自定义桌面X布局" desc="X代表横着的图标个数（直接输入数字即可）" type="int" value-sh="grep_prop Home_X \$Data_Dir/MIUI_Module.log" />
            <param name="Home_Y" title="自定义桌面Y布局" desc="Y代表竖着的图标个数（直接输入数字即可）" type="int" value-sh="grep_prop Home_Y \$Data_Dir/MIUI_Module.log" />
            <param name="Folder_Preview_width" title="自定义桌面文件夹预览图标大小宽度" desc="(输入数字即可可以有小数点)" type="number" value-sh="grep_prop Folder_Preview_width \$Data_Dir/MIUI_Module.log" />
            <param name="Folder_Preview_height" title="自定义桌面文件夹预览图标大小高度" desc="(输入数字即可可以有小数点)" type="number" value-sh="grep_prop Folder_Preview_height \$Data_Dir/MIUI_Module.log" />
            <param name="Folder_X" title="自定义桌面文件夹图标横着的图标个数（直接输入数字即可）" type="int" value-sh="grep_prop Folder_X \$Data_Dir/MIUI_Module.log" />
            <param name="Home_icon_width" title="自定义桌面图标宽度dp(输入数字即可可以有小数点)" type="number" value-sh="grep_prop Home_icon_width \$Data_Dir/MIUI_Module.log" />
            <param name="Home_icon_height" title="自定义桌面图标高度dp(输入数字即可可以有小数点)" type="number" value-sh="grep_prop Home_icon_height \$Data_Dir/MIUI_Module.log" />
            <param name="icon_title_text" title="自定义桌面图标下面应用名称颜色（输入#AARRGGBB十六进制颜色即可）" type="color" value-sh="grep_prop icon_title_text \$Data_Dir/MIUI_Module.log" />
            <param name="icon_text_size" title="自定义桌面图标下面应用名称字体大小dp(输入数字即可可以有小数点)" type="number" value-sh="grep_prop icon_text_size \$Data_Dir/MIUI_Module.log" />
        </params>
    </action>
<!-- END -->
Han
;;

GJZS_Theme_Color)
cat <<Han
<!-- START -->
    <action interruptible="false">
        <title>$name</title>
        <desc>$desc</desc>
        <set>. ./Magisk_Module/MIUI/GJZS_Theme_Color.sh GJZS_Theme_Color</set>
            <param name="ChongQi" label="是否刷入成功自动重启系统生效" type="switch" />
            <param name="x" value="无论手动输入Hex颜色代码还是使用调色板，颜色格式必须为：#AARRGGBB" readonly="readonly" />
            <param name="x2" value="LOGO" readonly="readonly" />
            <param name="logo_type" label="LOGO风格类型" options-sh="printf 'LSP|LSP风格\nmi|小米200W风格\nCustom|默认'" value-sh="grep_prop logo_type \$Data_Dir/GJZS_Theme_Color.log"/>
            <param name="logo_background" label="logo背景颜色" value-sh="grep_prop logo_background \$Data_Dir/GJZS_Theme_Color.log" type="color" />
            <param name="logo_left" label="logo G字母颜色" value-sh="grep_prop logo_left \$Data_Dir/GJZS_Theme_Color.log" type="color" />
            <param name="logo_right" label="logo J字母颜色" value-sh="grep_prop logo_right \$Data_Dir/GJZS_Theme_Color.log" type="color" />
            <param name="logo_background_data" title="logo背景数据" desc="该数据内容为矢量图的android:pathData数据" placeholder="M0,0h4100v4100h-4100z" value-sh="grep_prop logo_background_data \$Data_Dir/GJZS_Theme_Color.log" />
            <param name="kr_shortcut_logo" title="自定义快捷方式图标" type="file" value-sh="grep_prop kr_shortcut_logo \$Data_Dir/GJZS_Theme_Color.log" />
            <param name="x3" value="其它" readonly="readonly" />
            <param name="colorAccent" label="软件全局颜色" value-sh="grep_prop colorAccent \$Data_Dir/GJZS_Theme_Color.log" type="color" />
            <param name="log_basic" label="脚本日志颜色" value-sh="grep_prop log_basic \$Data_Dir/GJZS_Theme_Color.log" type="color" />
            <param name="log_error" label="脚本执行错误颜色" value-sh="grep_prop log_error \$Data_Dir/GJZS_Theme_Color.log" type="color" />
            <param name="log_end" label="脚本运行结束颜色" value-sh="grep_prop log_end \$Data_Dir/GJZS_Theme_Color.log" type="color" />
            <param name="params_view_bg" label="脚本执行字体背景底色" value-sh="grep_prop params_view_bg \$Data_Dir/GJZS_Theme_Color.log" type="color" />
            <param name="a" value="使用说明：第一次使用会制作为Magisk模块，需要重启才能生效&#x000A;&#x000A;第二次无需重启可以直接修改生效&#x000A;注释：小米默认主题强制填充白色做为图标背景，只有无界才是使用原应用图标" readonly="readonly" />
    </action>
<!-- END -->
Han
;;

Magisk_Abnormal_Repair)
cat <<Han
<!-- START -->
    <action interruptible="false">
        <title>$name</title>
        <desc>$desc</desc>
        <set>. ./Magisk_Module/Magisk_Abnormal_Repair.sh $1</set>
        <params>
            <param name="ChongQi" label="是否刷完模块自动重启系统" type="switch" value="1"/>
            <param name="Magisk_Manager" title="设置Magisk Manger包名" placeholder="自动识别请留空" value-sh="cat $Data_Dir/Magisk_Manager_Package_name.log"/>
        </params>
    </action>
<!-- END -->
Han
;;

# Hide_system_ROOT)
# mask
# which -a su | grep -vq ^"$MAGISKTMP"/su$
# [[ $? -ne 0 ]] && return 0
# ;;&

kfmark)
cat <<Han
<!-- START -->
    <action interruptible="false">
        <title>$name</title>
        <desc>$desc</desc>
        <set>. ./Magisk_Module/Activate_KFMark_Permanent.sh $1</set>
        <params>
            <param name="ChongQi" label="是否刷入成功自动重启系统生效" type="switch" />
        </params>
    </action>
<!-- END -->
Han
;;

com.fb.fluid|com.omarea.gesture)
cat <<Han
<!-- START -->
    <action interruptible="false">
        <title>$name</title>
        <desc>$desc</desc>
        <set>. ./Magisk_Module/Convert_to_a_system_apk.sh $1</set>
        <params>
            <param name="ChongQi" label="是否刷入成功自动重启系统生效" type="switch" />
            <param name="Type" label="请选择安装类型" options-sh="printf 'data|仅安装试用（不安装为系统应用）\n0|安装Magisk版 $name（安装为系统应用）'" />
        </params>
    </action>
<!-- END -->
Han
;;

Clone_Configuration)
cat <<Han
<!-- START -->
    <action interruptible="false">
        <title>$name</title>
        <desc>$desc</desc>
        <set>. ./Magisk_Module/Clone_Configuration.sh $1</set>
        <params>
            <param name="ChongQi" label="是否刷入成功自动重启系统生效" type="switch" />
            <param name="Immediately" label="是否免重启立即生效" desc="如果部分模块不生效，请重启手机" type="switch" value="1"/>
            <param name="user" label="选择用户" options-sh="ls /data/user | grep -v 0" value-sh="ls /data/user | grep -v 0" multiple="true" required="true"/>
        </params>
    </action>
<!-- END -->
Han
;;

riru-core)
cat <<Han
<!-- START -->
    <action interruptible="false">
        <title>$name</title>
        <desc>$desc</desc>
        <set>. ./Magisk_Module/Riru_Installer.sh 1</set>
        <params>
            <param name="ChongQi" label="是否刷入成功自动重启系统生效" type="switch" />
            <param name="Error" label="不显示模块里的错误信息" desc="注释：该错误信息log来自模块里，关闭状态时会显示完整日志等于Magisk的保存日志功能。" type="switch" value="1" />
            <param name="Compatible" label="使用兼容模式（兼容旧模块）" desc="注：该「兼容模式」需要模块作者遵守Magisk Modules开发指南规定，不更改update-binary脚本" type="switch" visible="echo $Show_Compatibility_Mode" />
            <param name="Riru_Manger" label="是否安装Riru管理器，显示Riru状态" desc="最新版Riru已经去除此管理器，此为25.4.4的老版本" type="switch" />
           <param name="old_Riru_version" label="是否安装Riru-v25.4.4版本" desc="部分模块（如EdXposed）不支持最新版Riru，需要开启此功能安装旧版" type="switch" />
        </params>
    </action>
<!-- END -->
Han
;;

riru_edxposed)
[[ $SDK -lt 26 ]] && Remove=$((Remove+1)) && return 0
cat <<Han
<!-- START -->
    <action interruptible="false">
        <title>$name</title>
        <desc>$desc</desc>
        <set>. ./Magisk_Module/EdXposed_Installer.sh</set>
        <params>
            <param name="ChongQi" label="是否刷入成功自动重启系统生效" type="switch" />
            <param name="Error" label="不显示模块里的错误信息" desc="注释：该错误信息log来自模块里，关闭状态时会显示完整日志等于Magisk的保存日志功能。" type="switch" value="1" />
            <param name="Compatible" label="使用兼容模式（兼容旧模块）" desc="注：该「兼容模式」需要模块作者遵守Magisk Modules开发指南规定，不更改update-binary脚本" type="switch" visible="echo $Show_Compatibility_Mode" />
            <param name="SELinux_OFF" label="是否关闭SELinux？" desc="打开此开关为关闭SELinux，要不要关SELinux看设备而定，极少设备不关SELinux可能卡开机" type="switch" />
            <param name="edxpapk" label="安装EdXposed Manager" desc="是否安装EdXposed Manager-$showapk.apk进行XP模块管理，尽量不要取消勾选，否则有可能出现：框架未正确安装" type="switch" value="1" />
            <param name="Riru_version" label="安装Riru（Riru - Core）" desc="如果没有安装Riru（Riru - Core）模块，请不要取消勾选，否则$name不会生效" type="switch" value="1" />
            <param name="Riru_Manger" label="是否安装Riru管理器，显示Riru状态" type="switch" />
            <param name="a1" value="YAHFA和SandHook已合并成一个zip文件，可从EDXposed Manager设置里的框架选项里，打开「使用 SandHook 后端」开关即可" readonly="readonly" />
            <param name="a2" value="某些情况下您的设备可能会在安装 EdXposed 过后变得无法正常启动&#x000A;&#x000A;如果您先前从未听说过「软变砖」或「无限重启」, 又或者您不知道如何从这些情况中恢复手机，那么请不要安装或使用 EdXposed ！无论如何, 都强烈建议您做好近期的数据备份&#x000A;&#x000A;一旦使用了功能则代表您已阅读风险，出现的一切后果，请自行承担风险，与本人无关。" readonly="readonly" />
        </params>
    </action>
<!-- END -->
Han
;;

riru_lsposed)
[[ $SDK -lt 27 ]] && Remove=$((Remove+1)) && return 0
cat <<Han
<!-- START -->
    <action interruptible="false">
        <title>$name</title>
        <desc>$desc</desc>
        <set>. ./Magisk_Module/riru_lsposed_Installer.sh</set>
        <params>
            <param name="ChongQi" label="是否刷入成功自动重启系统生效" type="switch" />
            <param name="Error" label="不显示模块里的错误信息" desc="注释：该错误信息log来自模块里，关闭状态时会显示完整日志等于Magisk的保存日志功能。" type="switch" value="1" />
            <param name="Compatible" label="使用兼容模式（兼容旧模块）" desc="注：该「兼容模式」需要模块作者遵守Magisk Modules开发指南规定，不更改update-binary脚本" type="switch" visible="echo $Show_Compatibility_Mode" />
            <param name="SELinux_OFF" label="是否关闭SELinux？" desc="打开此开关为关闭SELinux，要不要关SELinux看设备而定，极少设备不关SELinux可能卡开机" type="switch" />
            <param name="Riru_version" label="安装Riru（Riru - Core）" desc="如果没有安装Riru（Riru - Core）模块，请不要取消勾选，否则$name不会生效" type="switch" value="1" />
            <param name="Riru_Manger" label="是否安装Riru管理器，显示Riru状态" type="switch" />
            <param name="a" value="如果在重启后LSPosed Manager里仍然提示未安装框架，可在附加功能区一键激活即可" readonly="readonly" />
            <param name="a2" value="某些情况下您的设备可能会在安装 LSPosed 过后变得无法正常启动&#x000A;&#x000A;如果您先前从未听说过「软变砖」或「无限重启」, 又或者您不知道如何从这些情况中恢复手机，那么请不要安装或使用 LSPosed ！无论如何, 都强烈建议您做好近期的数据备份&#x000A;&#x000A;一旦使用了功能则代表您已阅读风险，出现的一切后果，请自行承担风险，与本人无关。" readonly="readonly" />
        </params>
    </action>
<!-- END -->
Han
;;

riru_dreamland)
[[ $SDK -lt 24 ]] && Remove=$((Remove+1)) && return 0
cat <<Han
<!-- START -->
    <action interruptible="false">
        <title>$name</title>
        <desc>$desc</desc>
        <set>. ./Magisk_Module/riru_dreamland_Installer.sh</set>
        <params>
            <param name="ChongQi" label="是否刷入成功自动重启系统生效" type="switch" />
            <param name="Error" label="不显示模块里的错误信息" desc="注释：该错误信息log来自模块里，关闭状态时会显示完整日志等于Magisk的保存日志功能。" type="switch" value="1" />
            <param name="Compatible" label="使用兼容模式（兼容旧模块）" desc="注：该「兼容模式」需要模块作者遵守Magisk Modules开发指南规定，不更改update-binary脚本" type="switch" visible="echo $Show_Compatibility_Mode" />
            <param name="SELinux_OFF" label="是否关闭SELinux？" desc="打开此开关为关闭SELinux，要不要关SELinux看设备而定，极少设备不关SELinux可能卡开机" type="switch" />
            <param name="mjxpapk" label="安装梦境" desc="是否安装梦境-$showapk.apk进行XP模块管理" type="switch" value="1" />
            <param name="Riru_version" label="安装Riru（Riru - Core）" desc="如果没有安装Riru（Riru - Core）模块，请不要取消勾选，否则$name不会生效" type="switch" value="1" />
            <param name="Riru_Manger" label="是否安装Riru管理器，显示Riru状态" type="switch" />
            <param name="a2" value="某些情况下您的设备可能会在安装 Riru-Dreamland 过后变得无法正常启动&#x000A;&#x000A;如果您先前从未听说过「软变砖」或「无限重启」, 又或者您不知道如何从这些情况中恢复手机，那么请不要安装或使用 Riru-Dreamland ！无论如何, 都强烈建议您做好近期的数据备份&#x000A;&#x000A;一旦使用了功能则代表您已阅读风险，出现的一切后果，请自行承担风险，与本人无关。" readonly="readonly" />
        </params>
    </action>
<!-- END -->
Han
;;

xposed)
[[ $SDK -gt 27 ]] && Remove=$((Remove+1)) && return 0
;;&

taichi)
cat <<Han
<!-- START -->
    <action interruptible="false">
        <title>$name</title>
        <desc>$desc</desc>
        <set>. ./Magisk_Module/install_taichi.sh $1</set>
        <params>
            <param name="ChongQi" label="是否刷入成功自动重启系统生效" type="switch" />
            <param name="exp" label="是否自动安装太极-$expversion.apk" type="switch" />
            <param name="Error" label="不显示模块里的错误信息" desc="注释：该错误信息log来自模块里，关闭状态时会显示完整日志等于Magisk的保存日志功能。" type="switch" value="1" />
            <param name="Compatible" label="使用兼容模式（兼容旧模块）" desc="注：该「兼容模式」需要模块作者遵守Magisk Modules开发指南规定，不更改update-binary脚本" type="switch" visible="echo $Show_Compatibility_Mode" />
        </params>
    </action>
<!-- END -->
Han
;;

*)
cat <<Han
<!-- START -->
    <action interruptible="false">
        <title>$name</title>
        <desc>$desc</desc>
        <set>sh \$install_MOD \${Compatible:=0} \$Error None 1 $1</set>
        <params>
            <param name="ChongQi" label="是否刷入成功自动重启系统生效" type="switch" />
            <param name="Error" label="不显示模块里的错误信息" desc="注释：该错误信息log来自模块里，关闭状态时会显示完整日志等于Magisk的保存日志功能。" type="switch" value="1" />
            <param name="Compatible" label="使用兼容模式（兼容旧模块）" desc="注：该「兼容模式」需要模块作者遵守Magisk Modules开发指南规定，不更改update-binary脚本" type="switch" visible="echo $Show_Compatibility_Mode" />
        </params>
    </action>
<!-- END -->
Han
;;
esac
}

end() {
   echo -e '</group>\n'
}



###
xml="$Pages/Magisk_Warehouse.xml"
File="$Data_Dir/Magisk_Warehouse_version.log"
[[ -f $File ]] && user_version=`cat $File` || user_version=0
eval `sed -n 2p $Load`

if [[ $1 = -s ]]; then
    echo "正在刷新页面信息状态，请骚等……"
elif [[ ! -f $xml ]]; then
    :
elif [[ $user_version = $Magisk_Warehouse_version ]]; then
    exit 0
fi

exec 1>$xml
Check_Ui_miui=`. $ShellScript/support/Check_Ui_miui.sh`
MOD_ID=($(sed -n 's/^id=//p' $Load | tr -d \'))

H=0
Remove=0
for i in ${MOD_ID[@]}; do
H=$(($H+1))
        if [[ -d $Modules_Dir/$i ]]; then
            install_id[$H]=$i
            mask "$i"
            user_versionCode="$versionCode"
            . "$Load" "$i"
            Cloud_versionCode="$versionCode"
            [[ "$user_versionCode" -lt "$Cloud_versionCode" ]] && update_id[$H]=$i && unset install_id[$H]
        else
            noinstall_id[$H]=$i
        fi
done


echo $Magisk_Warehouse_version >$File
start_xml
if [[ -n ${update_id[@]} ]]; then
    title "有更新（${#update_id[@]}）"
    for i in ${update_id[@]}; do
        p "$i" -y
    done
    end
fi
    if [[ -n ${install_id[@]} ]]; then
        title "已安装（${#install_id[@]}）"
        for o in ${install_id[@]}; do
            p "$o" -y
        done
        end
    fi
        if [[ -n ${noinstall_id[@]} ]]; then
            title "未安装（$((${#noinstall_id[@]}-Remove))）"
            for p in ${noinstall_id[@]}; do
                p "$p"
            done
            end
        fi
            if [[ $H = 0 ]]; then
                title "未找到云端数据"
                end
                exit 1
            fi
            sed -i "5c\            <slice size=\"18\" color=\"#FFFF0000\">已云端上架了$((H-Remove))个Magisk模块</slice>" $xml &>/dev/null
            exit 0
