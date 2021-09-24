#本脚本由　by Han | 情非得已c，编写
#应用于搞机助手上


ip=$(ifconfig wlan0 | grep 'inet addr:' | awk '{printf $2}' | awk -F: '{print $2}')
echo "关闭此开关为使用USB调试"
echo "本机WiFi ip=${ip:-当前未连接到WiFi}"
echo -n "确保在同一局域网|内，使用其它设备输入命令：adb connect "$ip:5555"，来连接控制本机进行网络adb调试"
