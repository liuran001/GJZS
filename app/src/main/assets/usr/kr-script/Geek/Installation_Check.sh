#本脚本由　by Han | 情非得已c，编写
#应用于搞机助手上


Mount_system
if [[ $Way -eq 0 ]]; then
    :
elif [[ $Way -eq 1 ]]; then
    #恢复
    state=0
    . $ShellScript/switchs/Installed_Frame_remove_Set.sh "$1"
elif [[ $Way -eq 2 ]]; then
    rm -rf $Frame_Dir/$1
fi
