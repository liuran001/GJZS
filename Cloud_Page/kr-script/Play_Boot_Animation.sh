#本脚本由　by Han | 情非得已c，编写
#应用于搞机助手上


echo "$Set_Time" >$Data_Dir/Play_Boot_Animation.log
setprop service.bootanim.exit 0
setprop ctl.start bootanim
#start bootanim
sleep $Set_Time
#stop bootanim
setprop ctl.stop bootanim
setprop service.bootanim.exit 1
