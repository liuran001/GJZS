#本脚本由　by Han | 情非得已c，编写
#应用于搞机助手上


a=0
for i in `which -a su`; do
echo $i
$i --help | grep -qw MagiskSU && continue
a=1
done

[[ $a -eq 0 ]] && abort -e "- 您的系统当前只由Magisk接管ROOT，没有存在其它ROOT管理\n\n如果已安装过1.4版本请先卸载1.4版本重启后才能再更新1.6版本"
Clean_install
echo '#!/system/bin/sh


MODDIR=${0%/*}' >$Module_S2

for i in `which -a su`; do
$i --help | grep -qw MagiskSU && continue

dir=`dirname $i`
mkdir -p $Module/mirror$dir
cp -af $dir/. $Module/mirror$dir
echo "mount --bind \$MODDIR/mirror$dir $dir" >>$Module_S2
done

find $Module -name "su" -exec rm -f {} \;
description="隐藏系统的ROOT，只保留magisk su，因为系统ROOT的存在会让Magisk Hide失效，导致部分应用仍然会检测到ROOT，且部分机型会存在Magisk掉ROOT的情况"
module_prop

[[ -f $Module_XinXi ]] && ui_print "- $name模块安装完成" || abort "！$name模块安装失败"
exit 0
