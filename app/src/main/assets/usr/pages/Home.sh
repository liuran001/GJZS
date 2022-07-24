show=true
if [[ -f $Load ]]; then
if [[ -f ~/offline || -f ~/offline2 ]]; then
	show1=0
else
	if [[ $Version_code -lt $New_Code ]]; then
        title="发现新版本$New_Version（$New_Code）"
        show1=1
    else
        show1=0
	fi
fi
elif [[ ! -f $Core ]]; then
    title="初始化功能失败"
elif [[ ! -f $Load ]]; then
    title="初始化配置失败"
fi

    if $LOCKEDED; then
        visible=1
    else
        visible=0
    fi

cat <<Han
<?xml version="1.0" encoding="utf-8"?>
<resource dir="file:///android_asset/Configuration_File" />
<group>
Han


if $LOCKED; then
cat <<Han
    <text visible="echo $visible">
        <slices>
            <slice size="18" color="#FFFF0000">未能获取到ROOT权限，能用啥功能自己去玩吧</slice>
        </slices>
    </text>
Han
fi

cat <<Han
    <text visible="echo $show1">
        <slices>
            <slice bold="true" size="20" align="center" break="true">$title</slice>
        </slices>
    </text>
</group>
Han

if $show; then
cat <<Han

<group title="搜索">
    <action reload="true" auto-off="true" interruptible="false">
        <title>搜索本页功能</title>
        <params>
            <param name="Content" title="输入你要搜索的功能标题，不区分大小写" required="true" />
        </params>
        <set>. ./Search_Content.sh \$Pages</set>
    </action>
    <page title="搜索结果" config-sh="cat \$Pages/Search_Results.xml" visible="[[ \`wc -l 2>/dev/null &#60; \$Pages/Search_Results.xml\` -gt 13 ]] &#38;&#38; echo 1 || echo 0"/>
<!-- START -->
    <action confirm="true" interruptible="false" visible="[[ \`wc -l 2>/dev/null &#60; \$Pages/Search_Results.xml\` -gt 13 ]] &#38;&#38; echo 1 || echo 0">
        <title>清除搜索结果</title>
        <set>rm -f $Pages/Search_Results.xml $Pages/ADB/Search_Results.xml; echo 将在下次打开搞机助手时生效</set>
    </action>
<!-- END -->
</group>
<group title="功能区">
    <pages>
    <page title="OTG功能区" config-sh="\$Pages/OTG.xml" />
        <page title="Magisk专区" config-sh="cat \$Pages/Magisk.xml" />
        <page title="Magisk模块仓库" before-load=". \$ShellScript/Magisk_Module/Print_Magisk_Warehouse.sh" config-sh="cat \$Pages/Magisk_Warehouse.xml" locked="$LOCKED" />
        <page title="应用/Xposed仓库" before-load=". \$ShellScript/Print_App_Store.sh" config-sh="cat \$Pages/App_Store.xml" />
        <page title="LSPosed模块管理" config-sh="cat \$Pages/LSPosed.xml" visible="[[ -d /data/adb/lspd ]] &#38;&#38; echo 1 || echo 0" />
        <page title="开机页面专区" config-sh="cat \$Pages/Boot_Animation.xml" locked="$LOCKED" />
        <page title="MIUI专区" config-sh="cat \$Pages/MIUI.xml" visible="sh ./support/Check_Ui_miui.sh" />
        <page title="极客专区" config-sh="cat \$Pages/Geek.xml" locked="$LOCKED" visible="[[ -n \`which magisk\` ]] &#38;&#38; echo 0 || echo 1" />
        <page title="ROOT专区" config-sh="cat \$Pages/ROOT.xml" locked="$LOCKED" />
        <page title="镜像分区专区" config-sh="cat \$Pages/IMG_Function.xml" locked="$LOCKED" />
        <page title="高级重启" config-sh="cat \$Pages/Advanced_Restart.xml" locked="$LOCKED" />
        <page title="应用程序管理专区" config-sh="cat \$Pages/APK.xml" />
        <page title="系统相关查看与调试" config-sh="cat \$Pages/WanJi.xml" />
        <page title="附加功能区" config-sh="cat \$Pages/FuJia.xml" />
        <page title="Termux专区" config-sh="cat \$Pages/Termux.xml" locked="$LOCKED">
            <lock>
                if [[ -d "$DATA_DIR/com.termux" &#38;&#38; $Have_ROOT ]]; then
                    echo 'unlocked'
                else
                    echo '未安装 Termux 应用'
                fi
            </lock>
        </page>
        <page title="充电控制专区" config-sh="cat \$Pages/Charging_control.xml" visible=". ./support/Charging_control_support.sh" locked="$LOCKED" />
        <page title="救援专区" config-sh="cat \$Pages/JiuYuan.xml" />
    </pages>
</group>
<group title="其它">
    <action>
        <title>脚本执行器</title>
        <params>
            <param name="CMD" title="输入命令点击确认即可，多行命令用键盘上的回车换行" desc="可通过which 命令、去查找命令是否存在" required="true" value-sh="cat $ShellScript/Shell2.sh" />
        </params>
        <set>. ./Shell.sh</set>
    </action>
    <action>
        <title>脚本执行器-执行.sh脚本</title>
        <params>
            <param name="File" type="file" suffix="sh" editable="true" title="可输入.sh文件绝对路径，也可以使用文件选择器选择文件" desc="温馨提示：可用「MT管理器」长按目录或文件 --&gt;点属性 --&gt;点击目录即可复制目录绝对路径，长按目录或长按名称即可复制文件绝对路径" required="true"/>
        </params>
        <set>cd /; . &#34;\$File&#34;</set>
    </action>
    <page title="实用网址推荐" config-sh="cat \$Pages/Practical_Web_address.xml" />
    <page title="搞机助手选项区" config-sh="cat \$Pages/GJZS.xml" />
    <text>
        <slices>
            <slice run="am force-stop $Package_name" size="15" color="#FF0366D6" u="1">完全退出</slice>
            <slice>　　　　　</slice>
            <slice run="am start -S $Package_name/gjzs.online.SplashActivity" size="15" color="#FF0366D6" u="1">重启搞机助手</slice>
        </slices>
    </text>
</group>
Han
fi
