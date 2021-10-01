#本脚本由　by Han | 情非得已c，编写
#应用于搞机助手上


MODID=AD-Hosts
MODPATH=$Frame_Dir/$MODID
MODNAME="AD Hosts"
Frame_installation_Check
. $Install_Method $MODID
sh $install_Frame 1 1 None 1 $MODID
End_installation
