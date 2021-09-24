#本脚本由　by Han | 情非得已c，编写
#应用于搞机助手上


echo "port=$port" >"$Data_Dir/Connect_Network_adb.log"
echo "fs=$fs" >>"$Data_Dir/Connect_Network_adb.log"
echo "ip=$ip" >>"$Data_Dir/Connect_Network_adb.log"
cp -f "$Data_Dir/Connect_Network_adb.log" "$Data_Dir/Connect_Network_adb2.log"

echo "- 当前输入ip：$ip"
echo "- 当前输入端口：$port"
echo "- 当出现USB授权弹窗时，请确定USB调试，授权过的无需再次授权"

case $fs in
    l)
        adb connect $ip:$port
    ;;
    
    d)
        adb disconnect $ip:$port
        rm -rf "$Data_Dir/$Connect_Network_adb2.log"
    ;;
    
    r)
        adb reconnect &>/dev/null
        adb disconnect $ip:$port
        adb connect $ip:$port
        echo "- 已重新连接请确定USB调试"
    ;;
esac
