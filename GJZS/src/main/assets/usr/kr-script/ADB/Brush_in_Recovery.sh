#本脚本由　by Han | 情非得已c，编写
#应用于搞机助手上


echo "- 出现OKAY=成功，FAILED=失败"
case $Scheme in
    1) fastboot flash recovery "$REC_File" ;;
    2) fastboot flash recovery_ramdisk "$REC_File" ;;
    3) fastboot boot "$REC_File"; ChongQi2=0 ;;
esac

[[ $ChongQi2 -eq 1 ]] && { fastboot flash misc $PeiZhi_File/misc.bin &>/dev/null; fastboot reboot; }
