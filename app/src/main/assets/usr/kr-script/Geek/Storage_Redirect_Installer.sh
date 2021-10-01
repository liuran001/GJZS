#本脚本由　by Han | 情非得已c，编写
#应用于搞机助手上

if [[ ! -d $DATA_DIR/moe.shizuku.redirectstorage ]]; then
    abort "！没有安装存储重定向应用，无法安装"
fi

Frame_installation_Check
Check_Riru
MODID=riru_storage_redirect
MODPATH=$Frame_Dir/$MODID
MODNAME="Riru - Storage Redirect（储存重定向增强模式）"
. $Install_Method $MODID
sh $install_Frame 1 1 None 1 $MODID

End_installation
