#本脚本由　by Han | 情非得已c，编写
#应用于搞机助手上


Clean_install

cat <<Han >$Module_prop
#Magisk模块作者  by：淡淡的影寒
#本模块由「搞机助手」创建
#特别鸣谢：by：topjohnwu & Magisk Manager提供服务支持

ro.vendor.audio.voice.change.support=true
Han

module_prop
[[ -f $Module_prop ]] && ui_print "- $name模块安装完成" || abort "！$name模块安装失败"
exit 0
