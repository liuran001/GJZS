#本脚本由　by Han | 情非得已c，编写
#应用于搞机助手上


[[ $music != 0 ]] && . $ShellScript/Charging_Sound_Effect_Play.sh -exit
state=$install_Way
[[ $music = 0 ]] && YinYue="$ZiDY_Effect" || YinYue="$PeiZhi_File/Charging_Sound_Effect/$music"
[[ ! -f $YinYue ]] && abort "！要修改的音频文件不存在"
. $ShellScript/switchs/MIUI/Sound_Effect_Replace_Set.sh $1 $Sound "$YinYue"
