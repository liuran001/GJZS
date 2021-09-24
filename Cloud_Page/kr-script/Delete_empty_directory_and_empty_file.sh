#本脚本由　by Han | 情非得已c，编写
#应用于搞机助手上


jian=0
lu=0
lu2=0
Find=/data/data/com.termux/files/usr/bin/find
Find2=$Bin_MT3/find
Find3=$Bin_MT1/find

QL() {
    echo "开始调用Termux的find命令快速查找"
    echo
    [[ $Empty_File = 1 ]] && {
    echo
    echo "------------------------------------------------------"
    while read i ; do
        echo "开始删除空文件$i"
        rm -f "$i" &>/dev/null
        jian=$((jian+1))
    done <<Han
`$Find "$Clean" -type f -empty|sed '/.nomedia/d'`
Han
    }
    [[ $Empty_Dir = 1 ]] && {
    echo
    echo "------------------------------------------------------"
    while read o ; do
        echo "开始删除空目录$o"
        rmdir -p "$o" &>/dev/null
        lu=$((lu+1))
    done <<Han
`$Find "$Clean" -type d -empty|sed '/.nomedia/d'`
Han
    }
}

QL2() {
if [[ -d "$Bin_MT1" && -d "$Bin_MT2" ]]; then
    export LD_LIBRARY_PATH="${Bin_MT2}:/data/data/bin.mt.plus/home/lib"
    Find=$Bin_MT1/find
elif [[ -d "$Bin_MT3" && -d "$Bin_MT4" ]]; then
    export LD_LIBRARY_PATH="${Bin_MT4}:/data/data/bin.mt.plus.canary/home/lib"
    Find=$Bin_MT3/find
fi

    echo "开始调用MT的find命令快速查找"
    echo
    [[ $Empty_File = 1 ]] && {
    echo
    echo "------------------------------------------------------"
    while read i ; do
        echo "开始删除空文件$i"
        rm -f "$i" &>/dev/null
        jian=$((jian+1))
    done <<Han
`$Find "$Clean" -type f -empty|sed '/.nomedia/d'`
Han
    }
    [[ $Empty_Dir = 1 ]] && {
    echo
    echo "------------------------------------------------------"
    while read o ; do
        echo "开始删除空目录$o"
        rmdir -p "$o" &>/dev/null
        lu=$((lu+1))
    done <<Han
`$Find "$Clean" -type d -empty|sed '/.nomedia/d'`
Han
    }
}


echo "正在扫描中，请骚等……"
echo
if [[ -f $Find3 || -f $Find2 ]]; then
    QL2
elif [[ -f $Find ]]; then
    QL
else
    echo "开始调用busybox的find命令慢速查找"
    [[ $Empty_File = 1 ]] && {
    echo
    echo "------------------------------------------------------"
    while read i ; do
        if [[ ! -s "$i" ]]; then
            echo "开始删除空文件$i"
            rm -f "$i" &>/dev/null
            jian=$((jian+1))
        fi
    done <<Han
`busybox find "$Clean" -type f -size 0c|sed '/.nomedia/d'`
Han
    }
    [[ $Empty_Dir = 1 ]] && {
    echo
    echo "------------------------------------------------------"
    while read o ; do
    empty_dir=$(ls -A "$o" 2>/dev/null)
    if [[ -z "$empty_dir" ]]; then
    echo "开始删除空目录$o*"
    rmdir -p "$o" &>/dev/null
    lu=$((lu+1))
    fi
    done <<Han
`busybox find "$Clean" -type d|sed '/.nomedia/d'`
Han
    }
fi

[[ $Clean_cache = 1 ]] && {
echo
echo "------------------------------------------------------"
echo "开始清理所有应用的cache缓存目录"
for BaoM in `pm list packages|awk -F: '{print $2}'`;do
    echo "正在查找$BaoM的cache缓存目录并删除……"
    [[ $BaoM = com.tencent.tmgp.sgame || $BaoM = com.tencent.tmgp.sgamece ]] && echo "- 跳过清理王者荣耀cache缓存目录" && continue
    find $SDdir/Android/data/$BaoM -type d -iname "*cache*" -exec rm -rf {} \; 2>/dev/null
    find $DATA_DIR/$BaoM -type d -iname "*cache*" -exec rm -rf {} \; 2>/dev/null
    lu2=$((lu2+1))
done
}
echo "------------------------------------------------------"
echo "已删除$jian个空文件，$lu个空目录，$lu2个应用cache缓存目录"
echo "THE END"