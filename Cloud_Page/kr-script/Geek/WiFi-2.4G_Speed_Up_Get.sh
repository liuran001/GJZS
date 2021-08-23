#本脚本由　by Han | 情非得已c，编写
#应用于搞机助手上


File=$(find /system /vendor -name WCNSS_qcom_cfg.ini)
for i in $File; do
    [[ -z $i ]] && exit 1
    [[ -L $i ]] && continue
    if [[ -n $(fgrep 'gChannelBondingMode24GHz=1' $i) ]]; then
        echo 1
    else
        echo 0
    fi
done
