#本脚本由　by Han | 情非得已c，编写
#应用于搞机助手上


device=`getprop ro.product.device`
File=/system/etc/device_features/"$device".xml
[[ ! -f $File ]] && File=/vendor/etc/device_features/"$device".xml
[[ ! -f $File ]] && abort
C=`fgrep '<bool name="support_multi_face_input">true</bool>' $File`

if [[ -n $C ]]; then
    echo 1
else
    echo 0
fi