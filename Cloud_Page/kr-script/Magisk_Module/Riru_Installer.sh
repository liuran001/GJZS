#本脚本由　by Han | 情非得已c，编写
#应用于搞机助手上


[[ ! -n $Riru_version ]] && export Riru_version=1
[[ "$old_Riru_version" = 1 ]] && export Riru_version=3 && echo '即将安装Riru-v25.4.4版本'
[[ -d $Modules_Dir/riru_edxposed && ! -f $Modules_Dir/riru_edxposed/disable && ! -f $Modules_Dir/riru_edxposed/remove ]] && echo '- 检测到你安装了EdXposed模块，由于此模块不支持最新版Riru，已为您切换安装Riru-v25.4.4版本' && export Riru_version=3
sh $install_MOD $Compatible $Error None 1 "riru-core"
[[ $Riru_Manger -eq 1 ]] && . ./install_App_Store_File.sh rikka.riru
