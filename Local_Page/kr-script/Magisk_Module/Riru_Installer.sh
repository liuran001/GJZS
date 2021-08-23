#本脚本由　by Han | 情非得已c，编写
#应用于搞机助手上


export Riru_version=1
sh $install_MOD $Compatible $Error None 1 "riru-core"
[[ $Riru_Manger -eq 1 ]] && . ./install_App_Store_File.sh rikka.riru
