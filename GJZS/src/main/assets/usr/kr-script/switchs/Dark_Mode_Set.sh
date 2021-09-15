#本脚本由　by Han | 情非得已c，编写
#应用于搞机助手上


if [[ $state = 1 ]]; then
    settings put secure ui_night_mode 2
    service call uimode 4 i32 2
    cmd uimode night yes
else
    settings put secure ui_night_mode 1
    service call uimode 4 i32 1
    cmd uimode night no
fi
