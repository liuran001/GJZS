#本脚本由　by Han | 情非得已c，编写
#应用于搞机助手上


if [[ $SDK -ge 30 ]]; then
abort -e "！极客专区Riru 无法适配安卓11

由于Riru模块作者对Riru 22+进行了改动，直接修改/system/build.prop无法成功修改Riru 里那个system.prop属性，在查阅了资料后才得知这个属性由boot.img控制，所以导致新版Riru 22+以上版本无法直接写入系统，自然也就只保留了一个21.3版本和最后一个兼容21.3版本的Riru EdXposed

意思就是安卓11+的用户想使用EDXposed必须去解锁BL然后使用Magisk模块方式安装"
fi

export Riru_version=2
MODID=riru-core
MODPATH=$Frame_Dir/$MODID
MODNAME="Riru （Riru - Core）"
ChongQi=1
Riru_Manger=0


Frame_installation_Check
. $Install_Method $MODID
sh $install_Frame 1 1 None 1 $MODID

End_installation
