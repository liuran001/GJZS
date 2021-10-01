#本脚本由　by Han | 情非得已c，编写
#应用于搞机助手上


Mount_system
Mount_vendor

File=$(find /system /vendor -name WCNSS_qcom_cfg.ini)
for i in $File; do
    if [[ -z $i ]]; then echo "！未找到WCNSS_qcom_cfg.ini，无法使用2.4G-WiFi频率提速至最大"; exit 1; fi
    [[ -L $i ]] && continue
        if [[ $state = 1 ]]; then
            sed -i '/gChannelBondingMode24GHz=/d;/gChannelBondingMode5GHz=/d;/gForce1x1Exception=/d;s/^END$/gChannelBondingMode24GHz=1\ngChannelBondingMode5GHz=1\ngForce1x1Exception=0\nEND/g' $i
        else
            sed -ri '/gChannelBondingMode24GHz.*/d' $i
        fi
done
Unload
Unload_vendor
