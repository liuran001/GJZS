#本脚本由　by Han | 情非得已c，编写
#应用于搞机助手上


add_hosts() {
ui_print "- 正在添加hosts文件……"
sed -i '/# Start github-hosts GitHub/,/# END github-hosts GitHub/d' $hosts
cat <<EOF >>$hosts

# Start $id GitHub
$IP1 github.com
$IP2 github.global.ssl.fastly.net
$IP3 assets-cdn.github.com
$IP4 gist.github.com
$IP5 raw.githubusercontent.com
$IP6 github.githubassets.com
$IP7 customer-stories-feed.github.com
$IP8 codeload.github.com
$IP9 avatars.githubusercontent.com
# END $id GitHub
EOF

}

check() {
    echo "- 查找是否已安装冲突模块"
    find $Modules_Dir -name $1 | while read i; do
        modid=`echo "$i" | cut -f5 -d '/'`
        Module="$Modules_Dir/$modid"
        Module_Disable="$Module/disable"
        Module_Remove="$Module/remove"
        Module_XinXi=$Module/module.prop
        modname=`grep_prop name "$Module_XinXi"`
            if [[ ! -f "$Module_Disable" || ! -f "$Module_Remove" ]]; then
                ui_print "- 已检测到「$modname」模块修改了hosts，已在该模块上修改，如果该模块卸载或禁用会使，$name模块失效"
                hosts=$Module/system/etc/hosts
                add_hosts
                echo 1 >$Status
                [[ $modid = $id ]] && module_prop
            fi
    done
}

Check_IP() {
    curl -skLA "Mozilla/5.0 (Android 11; Mobile; rv:88.0) Gecko/88.0 Firefox/88.0" "$1" | egrep -o '<li>[0-9.]{11,}</li>' | egrep -o -m 1 '[0-9.]{11,}'
}

echo "- 正在查询github.com的IP"
IP1=`Check_IP https://github.com.ipaddress.com/` && echo $IP1
echo "- 正在查询github.global.ssl.fastly.net的IP"
IP2=`Check_IP https://fastly.net.ipaddress.com/github.global.ssl.fastly.net` && echo $IP2
echo "- 正在查询assets-cdn.github.com的IP"
IP3=`Check_IP https://github.com.ipaddress.com/assets-cdn.github.com` && echo $IP3
echo "- 正在查询gist.github.com的IP"
IP4=`Check_IP https://github.com.ipaddress.com/gist.github.com` && echo $IP4
echo "- 正在查询raw.githubusercontent.com的IP"
IP5=`Check_IP https://githubusercontent.com.ipaddress.com/raw.githubusercontent.com` && echo $IP5
echo "- 正在查询github.githubassets.com的IP"
IP6=`Check_IP https://githubassets.com.ipaddress.com/github.githubassets.com` && echo $IP6
echo "- 正在查询customer-stories-feed.github.com的IP"
IP7=`Check_IP https://github.com.ipaddress.com/customer-stories-feed.github.com` && echo $IP7
echo "- 正在查询codeload.github.com的IP"
IP8=`Check_IP https://github.com.ipaddress.com/codeload.github.com` && echo $IP8
echo "- 正在查询avatars.githubusercontent.com的IP"
IP9=`Check_IP https://githubusercontent.com.ipaddress.com/avatars.githubusercontent.com` && echo $IP9
[[ -z "$IP1" || -z "$IP2" || -z "IP3" || -z "IP4" || -z "IP5" || -z "IP6" || -z "IP7" || -z "IP8" || -z "IP9" ]] && abort "！未连接到互联网？"

echo 0 >$Status
check hosts
[[ `cat $Status` = 1 ]] && exit 0

Clean_install

hosts=$Module/system/etc/hosts
mkdir -p $Module/system/etc
ui_print "- 正在从系统复制hosts文件……"
cp -ap /system/etc/hosts $hosts
add_hosts

description="使用Hosts形式修改Github和资源地址被DNS污染导致打不开，如果失效请再次安装本模块即可"
module_prop

ui_print "- 正在设置权限……"
set_perm_recursive "$Module" 0 0 0755 0644

[[ -f $Module_XinXi ]] && ui_print "- $name模块安装完成" || abort "！$name模块安装失败"
exit 0


