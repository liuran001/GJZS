#本脚本由　by Han | 情非得已c，编写
#应用于搞机助手上


export SLOT fenqu
if check_ab_device; then
    SLOT=`cat /proc/cmdline | tr '[:space:]' '\n' | sed -rn 's/androidboot.slot.{0,7}=//p'`
    if [[ -n "$SLOT" ]]; then
        echo "- 当前使用的分区系统：$SLOT。"
        case $SLOT in
            _a)
                slot=1
                fenqu="b"
            ;;
            _b)
                slot=0
                fenqu="a"
            ;;
        esac
    else
    
        qu=`bootctl get-current-slot 2>&1`
        echo -n "- 当前使用的分区系统："
        if [[ "$qu" = 0 ]]; then
            SLOT=_a
            echo "$SLOT"
            slot=1
            fenqu="b"
        elif [[ "$qu" = 1 ]]; then
            SLOT=_b
            echo "$SLOT"
            slot=0
            fenqu="a"
        else
            abort "！未知错误：$qu"
        fi
    fi
    [[ $1 = -c ]] && return 0
    sleep 2
    echo "- 开始切换到另一个$fenqu分区"
    bootctl set-active-boot-slot "$slot"
    ChongQi=1
    CQ
else
    SLOT=
    fenqu=
    return 1
fi
