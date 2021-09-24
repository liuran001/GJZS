#本脚本由　by Han | 情非得已c，编写
#应用于搞机助手上


Find_prop() {
    sed "/^$/d" "$Modules_Dir/$1/module.prop" | sed -n '/^name/p; /^version/p; /^versionCode/p; /^author/p; /^description/p' | sed 's/\&/\&#38;/g; s/\"/\&#34;/g; s/</\&#60;/g; s/>/\&#62;/g' | sed 's/^id=/&"/; s/^name=/&"/; s/^version=/&"/; s/^versionCode=/&"/; s/^author=/&"/; s/^description=/&"/; s/$/"/g'
}

List=0
K=0
M=0
JG=0
JG2=0
IFS=$'\n'
unset Empty_Modules_List Modules_List


for o in `ls $Modules_Dir`; do
    if [[ ! -f "$Modules_Dir/$o/module.prop" ]]; then
        K=$(($K+1))
        JG=1
        Empty_Modules_List="$Empty_Modules_List\n$o"
    else
        Modules_List="$Modules_List\n$o"
        JG2=1
    fi
    List=$(($List+1))
done


cat <<Han
<?xml version="1.0" encoding="utf-8"?>
<group>
    <text>
        <slices>
            <slice size="18" color="#FF9C27B0">已检测到您安装了$List个模块</slice>
Han


if [[ $List -ne 0 ]]; then
cat <<Han
            <slice break="true"></slice>
            <slice break="true"></slice>
            <slice run=". ./Magisk_Module/Modules_Management.sh -e" size="15" color="#FF0366D6" u="1">启用所有模块</slice>
            <slice>　　　　　</slice>
            <slice run=". ./Magisk_Module/Modules_Management.sh -d" size="15" color="#FF0366D6" u="1">禁用所有模块</slice>
        </slices>
    </text>
</group>
<group>
    <picker interruptible="false" reload="true" auto-off="true" multiple="true" options-sh="printf &#34;$Empty_Modules_List\n　请勾选要删除的模块　　&#34;" visible="echo $JG" >
        <title>已检测到有$K个未提供信息的Magisk模块</title>
        <summary>删除模块安装目录同时执行模块的uninstall.sh，切记此操作一旦执行无法恢复，请深思熟虑！！！</summary>
        <set>. ./Magisk_Module/Forced_Deletion_Modules.sh</set>
    </picker>
    <picker interruptible="false" reload="true" auto-off="true" multiple="true" options-sh=". ./Magisk_Module/Get_Modules_List.sh" visible="echo $JG2">
        <title>强制删除模块</title>
        <summary>强制删除模块安装目录同时执行模块的uninstall.sh，切记此操作一旦执行无法恢复，请深思熟虑！！！</summary>
        <set>. ./Magisk_Module/Forced_Deletion_Modules.sh</set>
    </picker>
</group>
Han
else
cat <<Han
        </slices>
    </text>
</group>
Han
fi

    for i in `printf "$Modules_List"`; do
        M=$(($M+1))
        eval $(Find_prop $i)
cat <<Han
<group title="$M">
    <picker interruptible="false" shell="hidden" reload="@$i" id="@$i" options-sh="printf 'e|启用\nd|禁用\nr|卸载\ns|不挂载system文件夹'">
        <summary sh=". ./Magisk_Module/Modules_Management.sh -s $i" />
        <title>$name</title>
        <desc>模块路径：$Modules_Dir/$i&#x000A;版本：$version&#x000A;版本号：$versionCode&#x000A;作者：$author&#x000A;$description</desc>
        <get>. ./Magisk_Module/Modules_Management.sh -g &#34;$i&#34;</get>
        <set>. ./Magisk_Module/Modules_Management.sh &#34;$i&#34;</set>
    </picker>
</group>
Han
    done
