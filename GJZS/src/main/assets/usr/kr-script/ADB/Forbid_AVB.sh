#本脚本由　by Han | 情非得已c，编写
#应用于搞机助手上


case $Option in
    01)
        fastboot --disable-verity flash vbmeta "$img_File"
        echo "- 已禁用AVB2.0的DM校验"
    ;;
    02)
        fastboot --disable-verification flash vbmeta "$img_File"
        echo "- 已禁用AVB2.0的启动校验"
    ;;
    03)
        fastboot --disable-verity --disable-verification flash vbmeta "$img_File"
        echo "- 已禁用AVB2.0的启动校验/DM校验"
    ;;
esac
