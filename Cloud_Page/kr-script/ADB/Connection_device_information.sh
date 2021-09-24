#本脚本由　by Han | 情非得已c，编写
#应用于搞机助手上


echo "获取设备列表及设备状态"
adb devices | sed -e 's/device$/　设备已连接/g' -e 's/offline$/　设备已离线/g' -e 's/unauthorized$/　没有允许授权USB调试/g'
    Number=`adb devices | grep -v -i 'List of .*' | wc -l`
    if [[ "$Number" -gt 2 ]]; then
        echo "！多个设备连接"
        echo "$a"
    fi
echo
echo
SheBei=`adb get-state`
[[ $? -eq 126 ]] && exit 126
echo "当前设备连接状态："
echo "$SheBei" | sed -e 's/device/设备连接正常（当前为系统模式）/g' -e 's/offline/连接出现异常，设备无响应/g' -e 's/unknown/没有设备连接/g' -e 's/recovery/Recovery（恢复模式）/g' -e 's#error: no devices/emulators found#FASTBOOT（引导模式）#g'
echo
echo "已连接的设备信息如下"
echo "序列号：`adb get-serialno`"
echo "设备路径：`adb get-devpath`"
echo "手机型号：`adb2 -c getprop ro.product.model`"
echo "安卓版本：`adb2 -c getprop ro.build.version.release`"
echo "安卓SDK版本：`adb2 -c getprop ro.build.version.sdk`"
echo "设备代号：`adb2 -c getprop ro.product.device`"
# echo
# echo -n "BL锁状态："
# a=`adb2 -c getprop ro.boot.flash.locked`
# b=`adb2 -c getprop ro.boot.verifiedbootstate`
    # if [[ "$a" = 0 && "$b" = orange ]]; then
        # echo "已解锁"
    # elif [[ "$a" = 1 && "$b" = green ]]; then
        # echo "未解锁"
    # fi
        kill -2 $$
        