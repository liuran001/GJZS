#本脚本由　by Han | 情非得已c，编写
#应用于搞机助手上


motd=$Termux/usr/etc/motd
mod2=$motd.bak

[[ ! -f $motd ]] && abort -e "！$motd文件已被删除，请先在Termux里执行\n\ntouch \$PREFIX/etc/motd"
if [[ $1 = 0 ]]; then
    [[ ! -f $mod2 ]] && abort "！$mod2 备份文件不存在无法恢复默认"
    cat $mod2 >$motd && rm -f $mod2
elif [[ $1 = 1 ]]; then
    [[ ! -f $mod2 ]] && cp -f $motd $mod2
cat <<Han >$motd

欢迎使用 Termux!

社区论坛: https://termux.com/community
Gitter 聊天:     https://gitter.im/termux/termux
IRC 通道:     #termux on freenode

使用包:

 * 搜索包:   pkg search <query>
 * 安装包:   pkg install <package>
 * 更新包:   pkg upgrade

订阅其他存储库:

 * Root:     pkg install root-repo
 * Unstable: pkg install unstable-repo
 * X11:      pkg install x11-repo

反馈问题: https://termux.com/issues
帮助: man termux或访问https://wiki.termux.com
Han
elif [[ $1 = 2 ]]; then
    [[ ! -f $mod2 ]] && cp -f $motd $mod2
    echo >$motd
fi
echo "- 执行完毕，重启Termux后生效"
