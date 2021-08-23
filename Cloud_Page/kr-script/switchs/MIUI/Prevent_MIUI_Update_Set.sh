#本脚本由　by Han | 情非得已c，编写
#应用于搞机助手上


[[ $SDK -ge 30 ]] && lu=$SDdir/downloaded_rom || lu=$SDdir/Download/downloaded_rom

if [[ $state = 1 ]]; then
    [[ -e $lu ]] && chattr -i $lu &>/dev/null && rm -rf $lu
    touch $lu && chattr +i $lu && echo "已禁止了MIUI自动下载ROM" || abort "！禁止失败"
else
    chattr -i $lu && rm -rf $lu && echo "已恢复默认" || abort "！恢复失败"
fi
    sleep 2
