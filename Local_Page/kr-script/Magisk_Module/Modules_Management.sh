#本脚本由　by Han | 情非得已c，编写
#应用于搞机助手上


if [[ $1 = -s ]]; then
    shift
    mask $1
    if [[ -f $Module_Disable ]]; then
        echo "- 模块将在下次重启后禁用"
    fi
    if [[ -f $Module_Remove ]]; then
        echo "- 模块将在下次重启后卸载"
    fi
    if [[ -f $Module_Update ]]; then
        echo "- 已更新了模块但尚未重启"
    fi
    if [[ -f $Module_Skip_Mount ]]; then
        echo "- 模块将在下次重启后，不对system文件夹进行更改"
    fi
    exit 0
elif [[ $1 = -g ]]; then
    shift
    mask $1
    if [[ -f $Module_Disable ]]; then
        echo d
    elif [[ -f $Module_Remove ]]; then
        echo r
    elif [[ -f $Module_Skip_Mount ]]; then
        echo s
    else
        echo e
    fi
    exit 0
elif [[ $1 = -d ]]; then
    ls "$Modules_Dir" | while read i; do
        touch "$Modules_Dir/$i/disable" &>/dev/null
    done
    echo "- 已禁用了所有模块，可在右上角刷新界面或返回重进才能刷新当前页面状态"
elif [[ $1 = -e ]]; then
    ls "$Modules_Dir" | while read i; do
        rm -f "$Modules_Dir/$i/"{disable,remove,skip_mount} &>/dev/null
    done
    echo "- 已启用了所有模块，可在右上角刷新界面或返回重进才能刷新当前页面状态"
fi

mask "$1"

case $state in
    e)
        rm -rf "$Module_Remove" "$Module_Disable" "$Module_Skip_Mount" &>/dev/null
    ;;
    
    d)
        rm -rf "$Module_Remove"
        touch "$Module_Disable"
    ;;
    
    r)
        touch "$Module_Remove"
    ;;
    
    s)
        touch "$Module_Skip_Mount"
    ;;
esac
