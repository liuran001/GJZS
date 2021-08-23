#本脚本由　by Han | 情非得已c，编写
#应用于搞机助手上


echo $Color >$Data_Dir/Color_blind_mode_Option.log
if [[ $Color = Default ]]; then
    settings put secure accessibility_display_daltonizer_enabled 0
    settings put secure accessibility_display_daltonizer 0
    exit 0
fi
    settings put secure accessibility_display_daltonizer_enabled 1
    settings put secure accessibility_display_daltonizer $Color
