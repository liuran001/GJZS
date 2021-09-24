#本脚本由　by Han | 情非得已c，编写
#应用于搞机助手上


if [[ -n $hide ]]; then
    for i in $hide; do
        pm hide $i
        echo "已隐藏了$i"
        echo "$i" >>$Data_Dir/Hidden_app_Records.log
    done
    echo "已隐藏应用的记录已写入到数据目录，清除「搞机助手」全部数据会导致记录丢失哦﻿⊙∀⊙！"
fi


if [[ -n $unhide ]]; then
    for o in $unhide; do
        pm unhide $o
        echo "已恢复了$o"
        echo "$o" >>$Data_Dir/Hidden_app_Records.log
    done
fi
