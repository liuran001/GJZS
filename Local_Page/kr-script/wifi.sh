#本脚本由　by Han | 情非得已c，编写
#应用于搞机助手上


if [[ $SDK -ge 30 ]]; then
    lu=/data/misc/apexdata/com.android.wifi
else
    lu=/data/misc/wifi
fi

cd $lu
if [[ -f WifiConfigStore.xml ]]; then
    egrep '"SSID|"PreSharedKey' WifiConfigStore.xml | sed -r 's/&quot\;|<\/string>//g; s/<null .*"PreSharedKey".*/密码：无/g; s/.*="SSID">/\nWiFi名称：/g; s/<string .*"PreSharedKey">/密码：/g'
elif [[ -f wpa_supplicant.conf ]]; then
    ssid=(`sed -n '/ssid="/=' wpa_supplicant.conf`)
    key=(`sed -n '/key_mgmt=/=' wpa_supplicant.conf`)
    num=0
    
    for i in ${ssid[@]}; do
        sed -n "$i,${key[$num]}p" wpa_supplicant.conf | egrep 'ssid="|psk="|key_mgmt=NONE' | sed -r 's/"$//g; s/.*ssid="/\nWiFi名称：/g; s/.*psk="/密码：/g; s/.*key_mgmt=NONE/密码：无/g'
        num=`expr $num + 1`
    done
else
    abort "！未找到WiFi配置文件，请私信我适配"
fi
