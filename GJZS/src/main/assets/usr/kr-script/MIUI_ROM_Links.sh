#本脚本由　by Han | 情非得已c，编写
#应用于搞机助手上


var(){
    echo "$line" | sed "s/^$1=//g"
}

XML() {
    fgrep 'string name' "$xml" | sed 's/&quot;/"/g; s/\\\//\//g; s/","/\n/g; s/":"/="/g' | sed 's/$/"/g' | sed -n '/^md5=/p; s/^name=/\n\n\n\n\n\nname=/gp; /^version=/p; /^codebase=/p; /^filename=/p; /^filesize=/p'
    echo
}

Check_md5() {
cat <<Han
<group title="校验md5">
    <action>
        <title>校验已下载的ROM文件md5</title>
        <summary>验证ROM包是否下载完整，防止卡刷时报错</summary>
        <set>. ./Check_MIUI_ROM_MD5.sh</set>
        <params>
            <param name="MD5" title="输入md5效验，也可以留空选择文件校验" ></param>
            <param name="File" type="file" suffix="zip" editable="true" required="true" title="可输入已下载ROM文件绝对路径，也可以使用文件选择器选择文件" desc="温馨提示：可用「MT管理器」长按目录或文件 -->点属性 -->点击目录即可复制目录绝对路径，长按目录或长按名称即可复制文件绝对路径" />
        </params>
    </action>
</group>
Han
}


c=false
xml=/data/data/com.android.updater/shared_prefs/version_json.xml


cat <<Han
<?xml version="1.0" encoding="UTF-8" ?>
Han

if [[ ! -f $xml ]]; then
cat <<Han
<group>
    <text>
        <slice size="18" color="#FFFF0000">未找到版本信息，请检查是否已屏蔽/冻结「系统更新」</slice>
    </text>
</group>
Han
exit 1
else
    device=$(getprop ro.product.device)
    model=$(getprop ro.product.model)
cat <<Han
<group>
    <text>
        <slice size="18" color="#FF9C27B0">$model（$device）ROM下载地址获取</slice>
    </text>
</group>
Han
fi



MD5=$(XML | grep '^md5=' | sort -u)
if [[ -n "$MD5" ]]; then
Check_md5

for i in $MD5; do
    md5_now=$(XML | sed -n "/$i/=" | head -n 1)
    start=$((md5_now-6))
    end=$((md5_now+6))
    eval $(XML | sed -n "$start,${end}p")
    LINK="&#34;\$Source_url/$version/$filename&#34;"
    if [[ "$version" = V* ]]; then
        BanBen=稳定版
    else
        BanBen=开发版
    fi
        if [[ "$name" = *OTA\ From* ]]; then
            Bao=增量包
        else
            Bao=完整包
        fi




cat <<Han
<group title="$BanBen" >
    <action interruptible="false">
        <title>$version $Bao</title>
        <desc>点即可跳转浏览器下载&#x000A;</desc>
        <summary>$name&#x000A;安卓：${codebase}&#x000A;大小：${filesize}&#x000A;MD5：${md5}</summary>
        <set>if [[ \$Option = copy ]]; then echo $LINK ; elif [[ \$Option = download ]]; then Website $LINK; fi</set>
            <param name="Source_url" label="来源接口" option-sh="printf 'https://hugeota.d.miui.com|①\nhttps://bigota.d.miui.com|②'" />
            <param name="Option" label="选择类型" option-sh="printf 'copy|打印链接\ndownload|跳转浏览器下载'" />
    </action>
</group>

Han
done
fi
