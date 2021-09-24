#本脚本由　by Han | 情非得已c，编写
#应用于搞机助手上


if [[ $Extreme -eq 1 ]]; then
    DongHua1=0.01
    DongHua2=0.01
    DongHua3=0.01
fi

adb2 -c settings put global window_animation_scale $DongHua1
adb2 -c settings put global transition_animation_scale $DongHua2
adb2 -c settings put global animator_duration_scale $DongHua3

echo "当前窗口动画缩放速度为：`adb2 -c settings get global window_animation_scale`"
echo "当前过渡动画缩放速度为：`adb2 -c settings get global transition_animation_scale`"
echo "当动画程序时长缩放速度为：`adb2 -c settings get global animator_duration_scale`"
