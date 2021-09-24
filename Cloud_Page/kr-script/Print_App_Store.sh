#本脚本由　by Han | 情非得已c，编写
#应用于搞机助手上


chuli() {
    echo "$@" | sed -e 's/\&/\&#38;/g' -e 's/\"/\&#34;/g' -e 's/</\&#60;/g' -e 's/>/\&#62;/g'
}


start_xml() {
cat <<Han
<?xml version="1.0" encoding="UTF-8" ?>
<group>
    <text>
        <slices>
            <slice size="18" color="#FFFF0000">已云端上架了$H个应用</slice>
        </slices>
    </text>
    <text>
        <slices>
            <slice size="16" color="#FF9C27B0">本功能为云端收集一些其它常规应用商店没有的应用，如果你有好的应用想分享，或者你是应用作者，可私信我云端上架分享大家一起享用</slice>
            <slice break="true"></slice>
            <slice break="true"></slice>
            <slice size="16" color="#FF9C27B0">免责申明：&#x000A;一旦安装了本页应用，出现的一切后果请自行承担风险，与本人无关</slice>
        </slices>
    </text>
</group>
<group>
<!-- START -->
    <action auto-off="true" interruptible="false" reload="true">
        <title>刷新应用状态信息</title>
        <summary>清除已缓存的在线仓库信息，强制刷新数据以及刷新应用变动过后的信息</summary>
        <set>. ./Print_App_Store.sh -s</set>
    </action>
<!-- END -->
</group>

Han
}


title() {
cat <<Han
<group>
    <text>
        <slices>
            <slice size="14" color="#FFFF0000">$1</slice>
        </slices>
    </text>
Han
}


p() {
    . "$Load" "$1"
    name=`chuli "$name"`
    version=`chuli "$version"`
    author=`chuli "$author"`
    description=`chuli "$description"`
    if [[ $2 = -y ]]; then
         versionName=`pm dump $1 | grep -m 1 versionName | sed -n 's/.*=//p'`
         versionCode2=`pm list packages --show-versioncode $1 | sed -n "s/.*$1 .*://p"`
         [[ -z "$versionCode2" ]] && versionCode2=`pm dump $1 | sed -n 's/.*versionCode=//p' | cut -f1 -d ' '`
cat <<Han
<!-- START -->
    <action interruptible="false">
        <title>$name</title>
        <desc>包名：$1&#x000A;版本：$version&#x000A;版本号：$versionCode&#x000A;已安装：$versionName（$versionCode2）&#x000A;作者：$author&#x000A;描述：$description&#x000A;更新于：$time</desc>
        <set>. ./install_App_Store_File.sh $1</set>
        <params>
            <param name="Way" label="请选择安装方式" options-sh="printf '0|①　直接安装\ndownload|②　仅下载'" value-sh="grep_prop Way \$Data_Dir/install_App_Store_File.log" />
            <param name="File_Dir" title="当上面选择方案②时生效" type="folder" editable="true" desc="可输入要下载到的目录绝对路径，也可以通过文件选择器长按选定目录，上面是默认路径，请自行根据需求更改目录，温馨提示：可用「MT管理器」长按目录或文件 -->点属性 -->点击目录即可复制目录绝对路径，长按目录或长按名称即可复制文件绝对路径" value-sh="grep_prop File_Dir \$Data_Dir/install_App_Store_File.log || echo \$GJZS/APK_Extraction" />
        </params>
    </action>
<!-- END -->
Han
    else
cat <<Han
<!-- START -->
    <action interruptible="false">
        <title>$name</title>
        <desc>包名：$1&#x000A;版本：$version&#x000A;版本号：$versionCode&#x000A;作者：$author&#x000A;描述：$description&#x000A;更新于：$time</desc>
        <set>. ./install_App_Store_File.sh $1</set>
        <params>
            <param name="Way" label="请选择安装方式" options-sh="printf '0|①　直接安装\ndownload|②　仅下载'" value-sh="grep_prop Way \$Data_Dir/install_App_Store_File.log" />
            <param name="File_Dir" title="当上面选择方案②时生效" type="folder" editable="true" desc="可输入要下载到的目录绝对路径，也可以通过文件选择器长按选定目录，上面是默认路径，请自行根据需求更改目录，温馨提示：可用「MT管理器」长按目录或文件 -->点属性 -->点击目录即可复制目录绝对路径，长按目录或长按名称即可复制文件绝对路径" value-sh="grep_prop File_Dir \$Data_Dir/install_App_Store_File.log || echo \$GJZS/APK_Extraction" />
        </params>
    </action>
<!-- END -->
Han
    fi
}

end() {
    echo -e '</group>\n'
}



###
xml="$Pages/App_Store.xml"
File="$Data_Dir/App_Store_version.log"
[[ -f $File ]] && user_version=`cat $File` || user_version=0
eval `sed -n 3p $Load`

if [[ $1 = -s ]]; then
    echo "正在刷新页面信息状态，请骚等……"
elif [[ ! -f $xml ]]; then
    :
elif [[ $user_version = $App_Store_version ]]; then
    exit 0
fi


exec 1>$xml
APK_ID=($(sed -n 's/^apk=//p' $Load | tr -d \'))


H=0
for i in ${APK_ID[@]}; do
    H=$(($H+1))
    if [[ -n `pm path $i` ]]; then
        install_apk[$H]=$i
        user_versionCode=`pm list packages --show-versioncode $i | sed -n "s/.*$i .*://p"`
         [[ -z "$user_versionCode" ]] && user_versionCode=`pm dump $i | sed -n 's/.*versionCode=//p' | cut -f1 -d ' '`
        . "$Load" "$i"
        [[ "$user_versionCode" -lt "$versionCode" ]] && update_apk[$H]=$i && unset install_apk[$H]
    else
        noinstall_apk[$H]=$i
    fi
done


echo $App_Store_version >$File
start_xml


if [[ -n ${update_apk[@]} ]]; then
    title "有更新（${#update_apk[@]}）"
    for i in ${update_apk[@]}; do
        p "$i" -y
    done
    end
fi
    if [[ -n ${install_apk[@]} ]]; then
        title "已安装（${#install_apk[@]}）"
        for o in ${install_apk[@]}; do
            p "$o" -y
        done
        end
    fi
        if [[ -n ${noinstall_apk[@]} ]]; then
            title "未安装（${#noinstall_apk[@]}）"
            for p in ${noinstall_apk[@]}; do
                p "$p"
            done
            end
        fi
            if [[ $H = 0 ]]; then
                title "未找到云端数据"
                end
                exit 1
            fi
            exit 0
