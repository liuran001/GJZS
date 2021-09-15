#本脚本由　by Han | 情非得已c，编写
#应用于搞机助手上


Clean_install

OLD_PATH="$PATH"
PATH="$PATH0"
if [[ -z `$which setenforce` ]]; then
    echo "- 检测到系统缺少命令，开始复制busybox"
    cp -f "$ELF4_Path/busybox" $Module
    chmod 755 $Module/busybox
    setenforce="\$MODDIR/busybox setenforce"
else
    setenforce=setenforce
fi
    PATH="$OLD_PATH"
        
        
cat <<Han >$Module_S2
#!/system/bin/sh
#本脚本由搞机助手自动创建
#作者：$author
#请不要试图篡改本脚本，否则一切后果自负，已安装版本：$version($versionCode)
#特别鸣谢Magisk提供服务支持：by topjohnwu


MODDIR=\${0%/*}
$setenforce 1
echo 1 >/sys/fs/selinux/enforce
Han


module_prop

[[ -f $Module_XinXi ]] && ui_print "- $name模块安装完成" || abort "！$name模块安装失败"
exit 0
