#本脚本由　by Han | 情非得已c，编写
#应用于搞机助手上


[[ $SDK -ge 30 ]] && lu=$SDdir/downloaded_rom || lu=$SDdir/Download/downloaded_rom
if [[ -f $lu ]]; then
    echo 1
elif [[ ! -f $lu ]]; then
    echo 0
fi