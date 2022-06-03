show=true
if [[ -f $Load ]]; then
if [[ -f ~/offline || -f ~/offline2 ]]; then
	show1=0
else
	if [[ $Version_code -lt $New_Code ]]; then
        title="New Version Detected: $New_Version（$New_Code）"
        show1=1
    else
        show1=0
	fi
fi
elif [[ ! -f $Core ]]; then
    title="Initialization function failed"
elif [[ ! -f $Load ]]; then
    title="Initialization configuration failed"
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
            <slice size="18" color="#FFFF0000">Cannot get ROOT access, some functions are not available.</slice>
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

<group title="Search">
    <action reload="true" auto-off="true" interruptible="false">
        <title>Search this page function</title>
        <params>
            <param name="Content" title="Enter the title of the function you want to search for, case insensitive." required="true" />
        </params>
        <set>. ./Search_Content.sh \$Pages</set>
    </action>
    <page title="Search Results" config-sh="cat \$Pages/Search_Results.xml" visible="[[ \`wc -l 2>/dev/null &#60; \$Pages/Search_Results.xml\` -gt 13 ]] &#38;&#38; echo 1 || echo 0"/>
<!-- START -->
    <action confirm="true" interruptible="false" visible="[[ \`wc -l 2>/dev/null &#60; \$Pages/Search_Results.xml\` -gt 13 ]] &#38;&#38; echo 1 || echo 0">
        <title>Clear search results</title>
        <set>rm -f $Pages/Search_Results.xml $Pages/ADB/Search_Results.xml; echo 'It will take effect the next time the app is opened.'</set>
    </action>
<!-- END -->
</group>
<group title="Functions">
    <pages>
    <page title="OTG Functions" config-sh="\$Pages/OTG.xml" />
        <page title="Magisk Functions" config-sh="cat \$Pages/Magisk.xml" />
        <page title="Magisk Modules Warehouse" before-load=". \$ShellScript/Magisk_Module/Print_Magisk_Warehouse.sh" config-sh="cat \$Pages/Magisk_Warehouse.xml" locked="$LOCKED" />
        <page title="Application/Xposed Modules Warehouse" before-load=". \$ShellScript/Print_App_Store.sh" config-sh="cat \$Pages/App_Store.xml" />
        <page title="LSPosed Modules Management" config-sh="cat \$Pages/LSPosed.xml" visible="[[ -d /data/adb/lspd ]] &#38;&#38; echo 1 || echo 0" />
        <page title="Boot Animation Functions" config-sh="cat \$Pages/Boot_Animation.xml" locked="$LOCKED" />
        <page title="MIUI Functions" config-sh="cat \$Pages/MIUI.xml" visible="sh ./support/Check_Ui_miui.sh" />
        <page title="Geek Functions" config-sh="cat \$Pages/Geek.xml" locked="$LOCKED" visible="[[ -n \`which magisk\` ]] &#38;&#38; echo 0 || echo 1" />
        <page title="ROOT Functions" config-sh="cat \$Pages/ROOT.xml" locked="$LOCKED" />
        <page title="Image Functions" config-sh="cat \$Pages/IMG_Function.xml" locked="$LOCKED" />
        <page title="Advanced Restart" config-sh="cat \$Pages/Advanced_Restart.xml" locked="$LOCKED" />
        <page title="Application Management Functions" config-sh="cat \$Pages/APK.xml" />
        <page title="System Information View and Debug" config-sh="cat \$Pages/WanJi.xml" />
        <page title="Additional Functions" config-sh="cat \$Pages/FuJia.xml" />
        <page title="Termux Functions" config-sh="cat \$Pages/Termux.xml" locked="$LOCKED">
            <lock>
                if [[ -d "$DATA_DIR/com.termux" &#38;&#38; $Have_ROOT ]]; then
                    echo 'unlocked'
                else
                    echo 'Termux is not installed'
                fi
            </lock>
        </page>
        <page title="Charging Control Functions" config-sh="cat \$Pages/Charging_control.xml" visible=". ./support/Charging_control_support.sh" locked="$LOCKED" />
        <page title="Recovery Functions" config-sh="cat \$Pages/JiuYuan.xml" />
    </pages>
</group>
<group title="Other">
    <action>
        <title>Script Executor</title>
        <params>
            <param name="CMD" title="Enter the command and click on the confirmation, multi-line command with the keyboard carriage return to line." desc="You can use the which command to find out if the command exists." required="true" value-sh="cat $ShellScript/Shell2.sh" />
        </params>
        <set>. ./Shell.sh</set>
    </action>
    <action>
        <title>Script Executor - Execution Shell File</title>
        <params>
            <param name="File" type="file" suffix="sh" editable="true" title="You can enter the absolute path to the .sh file, or you can use the file selector to select the file." desc="Tips: Use &#34;MT Manager&#34; to long click on a directory or file --&gt;Click Property --&gt;Click Name to copy the absolute path of the directory, long click Name to copy the absolute path of the file" required="true"/>
        </params>
        <set>cd /; . &#34;\$File&#34;</set>
    </action>
    <page title="Useful website recommendations" config-sh="cat \$Pages/Practical_Web_address.xml" />
    <page title="Settings" config-sh="cat \$Pages/GJZS.xml" />
    <text>
        <slices>
            <slice run="am force-stop $Package_name" size="15" color="#FF0366D6" u="1">Exit the application</slice>
            <slice>　　　　　</slice>
            <slice run="am start -S $Package_name/gjzs.online.SplashActivity" size="15" color="#FF0366D6" u="1">Restart the application</slice>
        </slices>
    </text>
</group>
Han
fi
