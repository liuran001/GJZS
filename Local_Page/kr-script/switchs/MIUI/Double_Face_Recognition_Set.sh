#本脚本由　by Han | 情非得已c，编写
#应用于搞机助手上


device=`getprop ro.product.device`
File=/system/etc/device_features/"$device".xml
gz=
[[ -f $File ]] && Mount_system && File=$system/etc/device_features/"$device".xml && gz=s
[[ ! -f $File ]] && File2=/vendor/etc/device_features/"$device".xml
[[ -f $File2 ]] && Mount_vendor && File=$vendor/etc/device_features/"$device".xml && gz=v
[[ ! -f $File ]] && abort "未找到"$device".xml文件信息无法使用此功能"


if [[ $state = 1 ]]; then
    sed -i '/<\/features>/i\    <bool name=\"support_multi_face_input\">true<\/bool>' "$File"
    [[ $? = 0 ]] && echo "已开启双人脸识别"
else
    sed -i '/<bool name="support_multi_face_input">true<\/bool>/d' "$File"
    [[ $? = 0 ]] && echo "已恢复默认"
fi
    [[ $gz = s ]] && Unload
    [[ $gz = v ]] && Unload_vendor
    sleep 2
