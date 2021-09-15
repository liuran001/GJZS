#本脚本由　by Han | 情非得已c，编写
#应用于搞机助手上


PREFIX=/data/data/com.termux/files/usr
APT=$PREFIX/etc/apt
jian=$APT/sources.list
jian2=$APT/sources.list.d/game.list
jian3=$APT/sources.list.d/science.list


HuiFu() {
    cat $jian.bak >$jian
    cat $jian2.bak >$jian2
    cat $jian3.bak >$jian3
    rm -f $jian.bak $jian2.bak $jian3.bak
    # sed -i -e '/mirrors.tuna.tsinghua.edu.cn/d' -e 's/^#deb/deb/' $jian $jian2 $jian3
}

bakfile() {
    echo "- 备份原文件为.bak用于恢复"
    [[ ! -f $jian.bak ]] && cp -f $jian $jian.bak
    [[ ! -f $jian2.bak ]] && cp -f $jian2 $jian2.bak
    [[ ! -f $jian3.bak ]] && cp -f $jian3 $jian3.bak
    
    chown $User_Group:$User_Group $jian.bak $jian2.bak $jian3.bak
    chmod 600 $jian.bak $jian2.bak $jian3.bak
}

if [[ $Option = 1 ]]; then
    . $ShellScript/Termux/common.sh
    Termux_UID
    bakfile
    sed -i 's@^\(deb.*stable main\)$@#\1\ndeb https://mirrors.tuna.tsinghua.edu.cn/termux/termux-packages-24 stable main@' $jian
    sed -i 's@^\(deb.*games stable\)$@#\1\ndeb https://mirrors.tuna.tsinghua.edu.cn/termux/game-packages-24 games stable@' $jian2
    sed -i 's@^\(deb.*science stable\)$@#\1\ndeb https://mirrors.tuna.tsinghua.edu.cn/termux/science-packages-24 science stable@' $jian3
    echo "- 已更换了清华源"
elif [[ $Option = clear ]]; then
    pm clear com.termux
    echo "- 已清除Termux全部数据来恢复了默认"
    exit 0
elif [[ $Option = 0 ]]; then
    HuiFu
    echo "- 已恢复了默认"
fi
    echo "- 请手动打开Termux然后执行一遍更新所有包"
    echo "- apt update && apt upgrade"
    echo "- 执行「 apt update && apt upgrade 」时会提示

Configuration file '/data/data/com.termux/files/usr/etc/apt/sources.list'
 ==> File on system created by you or by a script.
 ==> File also in package provided by package maintainer.
   What would you like to do about it ?  Your options are:
    Y or I  : install the package maintainer's version
    N or O  : keep your currently-installed version
      D     : show the differences between the versions
      Z     : start a shell to examine the situation
 The default action is to keep your current version.
*** sources.list (Y/I/N/O/D/Z) [default=N] ?


输入Y会再次变回官方源，默认为N，想保持清华源回车即可"
echo
echo
echo "- 开始打开Termux更新可用软件包列表和已安装的软件包"
sleep 5
. ./Termux/update.sh
