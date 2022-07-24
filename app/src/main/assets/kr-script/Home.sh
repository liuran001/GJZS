rm -rf ~/downloader/path/*
[[ ! -d ~/Flag ]] && mkdir ~/Flag
if [[ -f ~/Flag/Enable ]]; then
    . "$Pages/Home.sh"
    exit 0
fi
cat <<EOL
<?xml version="1.0" encoding="utf-8"?>
<text>
    <slices>
        <slice size="20" color="#ff0000" bold="true">您需要同意免责声明后才可使用本应用！</slice>
    </slices>
</text>

<group>
    <text>
        <slices>
            <slice size="25" break="true" bold="true" align="center">免责声明</slice>
            <slice size="20" break="true">首先，感谢您信赖并使用搞机助手·R应用。</slice>
            <slice size="20" break="true">搞机助手·R是一款专为Android极客用户设计的工具应用，鉴于本应用的特殊性，我们会在使用此应用时申请ROOT（超级用户）权限。而ROOT权限作为手机的最高权限，授予本权限后您在应用内进行的操作可能会对你的设备造成损害，包括但不限于系统异常 无法开机 甚至硬件损坏等问题。</slice>
            <slice size="30" color="#ff0000" bold="true" break="true">我们不对您使用本应用造成的任何损失做任何担保！</slice>
            <slice size="20" break="true">如果您知情并同意，请点击下方按钮，否则请卸载本APP</slice>
        </slices>
    </text>
</group>
<group>
    <action reload="true" auto-off="true">
        <title>我已阅读并同意以上条款</title>
        <desc>点击之后需要等待几秒以加载功能</desc>
        <script>touch ~/Flag/Enable</script>
    </action>
</group>
<group>
    <action>
        <title>重启搞机助手·R</title>
        <desc>等了很久还是没加载出来就重启吧~</desc>
        <script>am start -S $Package_name/.SplashActivity %26%26 echo '请尝试手动重启APP！'</script>
    </action>
</group>
EOL
exit 0