#本脚本由　by Han | 情非得已c，编写
#应用于搞机助手上


if [[ $Brand = Lenovo ]]; then
    echo "已选择一键解锁Lenovo联想系列BL锁"
    echo "如果提示OKAY代表解锁成功"
    fastboot flash unlock $PeiZhi_File/unlock_bootloader.img
    fastboot oem unlock-go
elif [[ $Brand = oppo ]]; then
    echo "已选择一键解锁OPPO/一加/realme系列系列BL锁"
    echo "如果提示OKAY代表解锁成功"
    echo "接着按手机音量键选中“Unlock The Bootloader”选项，按电源键确认后手机将自动解锁BL并清除手机中所有用户数据。"
    fastboot flashing unlock
elif [[ $Brand = Google_Pixel ]]; then
    echo "已选择一键解锁google_pixel系列bl锁"
    echo "如果提示okay代表解锁成功"
    fastboot flashing unlock
    fastboot flashing unlock_critical
fi
