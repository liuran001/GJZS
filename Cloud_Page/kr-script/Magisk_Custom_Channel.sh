#本脚本由　by Han | 情非得已c，编写
#应用于搞机助手上


s() {
    echo 3
    sleep 1
    echo 2
    sleep 1
    echo 1
    sleep 1
}

echo "- 开始修改Magisk自定义通道为：https://gitee.com/QingFeiDeiYi/Magisk/raw/master/stable.json"
echo "- 如果直接修改失败，可以手动前往 -->设置 -->自定义通道 -->填写上面网址即可"
. $ShellScript/Magisk_Manager_Package_name.sh
echo "- 检查是否存在多用户"

find /data/user_de/ -name "$Magisk_Manager" -type d | while read Dir; do
    user=`echo $Dir | cut -d / -f 4`
    File="$Dir/shared_prefs/${Magisk_Manager}_preferences.xml"
    am force-stop --user "$user" $Magisk_Manager

    ! test -f "$File" && {
        echo "- 未检测到数据开始启动Magisk Manger初始化数据"
        s
        am start --user "$user" -n `dumpsys package $Magisk_Manager | fgrep -B 2 'android.intent.category.LAUNCHER' | awk '/\//{print $2}'`
        s
        input keyevent 4
        am force-stop --user "$user" $Magisk_Manager
    }
    
    ! test -f "$File" && error "！加载数据出错" && continue
    
        echo "- 开始为$user用户修改自定义通道"
        sed -i '/update_channel/c\    <string name="update_channel">2<\/string>' "$File"
        fgrep -q '<string name="custom_channel">' "$File"
        if [[ $? -eq 0 ]]; then
        echo "- 正在编辑……"
        sed -i '/custom_channel/c\    <string name="custom_channel">https:\/\/gitee.com\/QingFeiDeiYi\/Magisk\/raw\/master\/stable.json<\/string>' "$File"
        else
        echo "- 正在写入数据……"
        sed -i '/<\/map>/i\    <string name="custom_channel">https:\/\/gitee.com\/QingFeiDeiYi\/Magisk\/raw\/master\/stable.json<\/string>' "$File"
        fi
done
echo "- 修改完毕，打开Magisk Manger即可看到效果"