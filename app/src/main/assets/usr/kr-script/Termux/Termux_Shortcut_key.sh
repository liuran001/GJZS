#本脚本由　by Han | 情非得已c，编写
#应用于搞机助手上


. $ShellScript/Termux/common.sh
File=$HOME/.termux/termux.properties

if [[ $Option = 1 ]]; then
    Termux_UID
    mktouch $File
if [[ $Row -eq 2 ]]; then
cat <<EOF >$File
extra-keys = [['exit','/','-','HOME','UP','END','PGUP'],['TAB','CTRL','ALT','LEFT','DOWN','RIGHT','PGDN']]
EOF
elif [[ $Row -eq 3 ]]; then
cat <<EOF >$File
extra-keys = [['ESC','<','>','BACKSLASH','=','^','$','()','{}','[]','ENTER'],['TAB','&',';','/','\`','%','*','HOME','UP','END','PGUP'],['CTRL','FN','ALT','|','-','+','QUOTE','LEFT','DOWN','RIGHT','PGDN']]
EOF
fi
    chmod 700 $Termux/files/home/.termux &>/dev/null
    chown $User_Group:$User_Group $Termux/files/home/.termux $File &>/dev/null
    chmod 644 $File
    echo "- 已添加双行快捷键，请手动重启Termux即可"
elif [[ $Option = 0 ]]; then
    rm -rf $File
    rmdir -p $Termux/files/home/.termux &>/dev/null
    echo "- 已恢复了默认，请手动重启Termux即可"
fi
