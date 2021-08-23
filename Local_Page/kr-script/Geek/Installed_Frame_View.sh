#本脚本由　by Han | 情非得已c，编写
#应用于搞机助手上


remove_get=$ShellScript/switchs/Installed_Frame_remove_Get.sh
remove_set=$ShellScript/switchs/Installed_Frame_remove_Set.sh

Find_prop() {
    sed -n "s/$1=//p" $i | sed -e 's/\&/\&#38;/g' -e 's/\"/\&#34;/g' -e 's/</\&#60;/g' -e 's/>/\&#62;/g'
}

List=`ls -l $Frame_Dir |grep "^d"|wc -l`

cat <<Han
<?xml version="1.0" encoding="UTF-8" ?>
<group>
   <text>
     <slices>
       <slice size="20" color="#FFFF0000">已安装的服务框架管理与查看</slice>
       <slice break="true"></slice>
       <slice size="14" color="#FF9400D3">已检测到您安装了$List个框架</slice>
     </slices>
   </text>
   <action confirm="true" auto-off="true" interruptible="false">
       <title>重启设备</title>
       <set>reboot</set>
   </action>
</group>
Han


    for i in `find "$Frame_Dir" -name module.prop`; do

H=$(($H+1))

id=`Find_prop id`
name=`Find_prop name`
version=`Find_prop version`
versionCode=`Find_prop versionCode`
author=`Find_prop author`
description=`Find_prop description`

cat <<Han
<group title="$H" >
    <switch auto-off="true" confirm="true" reload="true" >
        <title>「$name」框架：卸载</title>
        <desc>关闭此开关为卸载框架，强烈建议立即重启</desc>
        <getstate>. $remove_get '$id' '$name'</getstate>
        <setstate>. $remove_set '$id' '$name'</setstate>
    </switch>
    <text>
       <slices>
         <slice break="true"></slice>
         <slice size="14" color="#FF9400D3">框架信息如下：</slice>
         <slice break="true"></slice>
         <slice size="14" color="#FF0F9D58">
版本：$version

版本号：$versionCode

作者：$author

说明描述：$description</slice>
       </slices>
    </text>
</group>
Han
    done
