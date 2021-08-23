#本脚本由　by Han | 情非得已c，编写
#应用于搞机助手上


Clean_install
mktouch $Module/system/app/PowerKeeper/PowerKeeper.apk
rm -f /data/system/package_cache/*/PowerKeeper*

cat <<Han >$Module_us
#!/system/bin/sh

rm -f /data/system/package_cache/*/PowerKeeper*
Han

module_prop
[[ -f $Module_XinXi ]] && ui_print "- $name模块安装完成" || abort "！$name模块安装失败"
exit 0
