if [[ -f ~/Flag/NFO ]]; then #NFO_NotFirstOpen
    . $HOME/kr-script/Home.sh
    exit 0
fi
cat <<End
<text>
    <slices>
        <slice size="20" color="#ff0000" bold="true">您需要同意免责声明后才可使用本应用！</slice>
    </slices>
</text>

<group>
    <text size="20">
        <title align="center" break="true">免责声明</title>
        <slices>
            <slice>首先，感谢您信赖并使用搞机助手·R应用。</slice>
            <slice>搞机助手·R是一款专为Android极客用户设计的工具应用，鉴于本应用的特殊性，我们会在使用此应用时申请ROOT（超级用户）权限。而ROOT权限作为手机的最高权限，授予本权限后您在应用内进行的操作可能会对你的设备造成损害，包括但不限于系统异常 无法开机 甚至硬件损坏等问题。</slice>
            <slice size="25" color="#ff0000" bold="true">我们不对您使用本应用造成的任何损失做任何担保！</slice>
            <slice>如果您知情并同意，请点击下方按钮，否则请卸载本APP</slice>
        </slices>
    </text>
</group>

<action reload="true">
    <title>我已阅读并同意以上条款</title>
    <script>
        [[ ! -d ~/Flag ]] && mkdir ~/Flag
        touch ~/Flag/NFO
    </script>
</action>
End
exit 0