#本脚本由　by Han | 情非得已c，编写
#应用于搞机助手上

svc wifi disable
ifconfig wlan0 down
ifconfig wlan0 hw ether "$MAC"

for wlan in `find /sys/devices -name 'wlan0'`; do
if [[ -f "$wlan/address" ]]; then
echo "已修改MAC地址为：`cat "$wlan/address"`"
fi
done

#ifconfig wlan0 up
 #   svc wifi enable
 
 
 
# ifconfig wlan0 hw ether $mac
# ifconfig wlan0 down
# ifconfig wlan0 up