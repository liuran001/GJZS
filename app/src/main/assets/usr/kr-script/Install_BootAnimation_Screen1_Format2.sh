hd() {
    for i in `seq ${#1} -2 0`; do
        echo -n "${1:$i:2}"
    done
}

get_offset() {
    pyl=$1
    shift
    p=`echo "$@" | tr -d ' ' | sed -rn '/424d.{8}0{8}/p'`
    if [[ -n $p ]]; then
        Number=$((Number+1))
        p2=`echo -n $p | sed 's/424d.*//' | wc -m`
        p3=`awk "BEGIN{print $pyl+($p2/2)}"`
        b=`echo "$@" | tr -d ' ' | sed -rn 's/.*424d//p'`
        b2=${b:0:8}
        b3=`hd $b2`
        b4=`printf "%d" 0x$b3`
        offset[$Number]=$p3
        bmp_size[$Number]=$b4
    fi
}

[[ -z `od -where` ]] && abort "！未找到od命令"

name=`basename $img`
Number=0
jian2=$TMPDIR/Configuration.log

echo "- 正在分析$name"
[[  -z `strings $img` ]] && abort "！$name为空分区，请切换分区解析"

echo "- 正在解析$name"
Start_Time
while read line ; do
    get_offset $line
done <<Han
`od -w16 -Ad -tx1 "$img" | sed -rn '/42 4d/{N;p}; /42$/{N;/42\n.* 4d .{44}/p}' | sed 'N; s/\n/ %/' | sed -rn 's/%[^ ]* //p'`
Han

# echo "- 解析用时：${SECONDS}s"
End_Time 解析$name
echo "- 共找到$Number张bmp图片"
if [[ $Number -eq 0 ]]; then
    abort "！未找到.bmp格式图片"
else
    [[ ! -d $Pic_Dir ]] && mkdir -p "$Pic_Dir"
    echo "IMG=$img" >$jian2
    echo "Picture=$Number" >>$jian2
    echo "IMG_Name=$name" >>$jian2
    z=0
        for i in `seq $Number`; do
            z=$((z+1))
            echo "offset[$i]=${offset[$i]}" >>$jian2
            echo "bmp_size[$i]=${bmp_size[$i]}" >>$jian2
        done
            z=$((z+1))
            size=`wc -c < $img`
            echo "offset[$z]=$size" >>$jian2
                z=0
                j=1
                . $jian2
                echo "- 开始解包$name"
                for e in ${bmp_size[@]}; do
                    z=$((z+1))
                    j=$((j+1))
                    bsize=${offset[$z]}
                    bsize2=${offset[$j]}
                    msize=$((bsize2-bsize))
                    echo "bmp_max[$z]=$msize" >>$jian2
                    dd if=$img of="$Pic_Dir/$z.bmp" skip=$bsize count=$e bs=1
                    rm -r $TMPDIR/*
                done
                    echo "- 已解包完成"
                    echo "- 路径：$Pic_Dir"
                    echo "- PS注意事项："
                    echo "1.图片分辨率不一定要和官方的一样，但是可能因设备不同出错时就必须和官方的一样"
                    echo "2.图片必须.bmp格式，别异想天开改个后缀就是bmp格式了"
                    echo "3.最终做好的bmp成品图片不能大于原图片的字节"
fi
