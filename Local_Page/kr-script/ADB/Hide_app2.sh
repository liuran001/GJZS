#本脚本由　by Han | 情非得已c，编写
#应用于搞机助手上


for i in $package; do
    adb2 -c pm hide $i
    if [[ $? = 0 ]]; then
        echo $i >>$Data_Dir/ADB_Hidden_app_Records.log
    fi
done
    [[ -n $package ]] && echo "已隐藏应用的记录已写入到数据目录，清除「搞机助手」全部数据会导致记录丢失哦﻿⊙∀⊙！"
