#本脚本由　by Han | 情非得已c，编写
#应用于搞机助手上


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

name=`basename $IMG`.img
Number=0
lu=$PeiZhi_File/BootAnimation_Screen1/Customize
lu2=$GJZS/Customize_BootAnimation_Screen1
jian=$lu/Configuration.log
img=$lu/$name

echo "- 正在分析$name"
[[  -z `strings $IMG` ]] && abort "！$name为空分区，请切换分区解析"

echo "- 正在解析$name"
Start_Time
while read line ; do
    get_offset $line
done <<Han
`od -w16 -Ad -tx1 "$IMG" | sed -rn '/42 4d/{N;p}; /42$/{N;/42\n.* 4d .{44}/p}' | sed 'N; s/\n/ %/' | sed -rn 's/%[^ ]* //p'`
Han

# echo "- 解析用时：${SECONDS}s"
End_Time 解析$name
echo "- 共找到$Number张bmp图片"
if [[ $Number -eq 0 ]]; then
    abort "！未找到.bmp格式图片，目前尚未支持您的机型：`getprop ro.product.model`"
else
    [[ ! -d $lu ]] && mkdir -p "$lu"
    [[ ! -d $lu2 ]] && mkdir -p "$lu2"
    echo "IMG=$IMG" >$jian
    echo "Picture=$Number" >>$jian
    echo "IMG_Name=$name" >>$jian
    echo "- 已支持您的设备并生成配置文件"
    echo "- 配置文件生成一次在不清除搞机助手数据的时候无需重复生成"
    echo "- 提取出$name……"
    dd if=$IMG of="$img"
    z=0
        for i in `seq $Number`; do
            z=$((z+1))
            echo "offset[$i]=${offset[$i]}" >>$jian
            echo "bmp_size[$i]=${bmp_size[$i]}" >>$jian
        done
            z=$((z+1))
            size=`wc -c < $img`
            echo "offset[$z]=$size" >>$jian
                z=0
                j=1
                . $jian
                echo "- 开始解包$name"
                rm -rf $lu2/*
                cp -f "$img" "$lu2/原$name"
                for e in ${bmp_size[@]}; do
                    z=$((z+1))
                    j=$((j+1))
                    bsize=${offset[$z]}
                    bsize2=${offset[$j]}
                    msize=$((bsize2-bsize))
                    echo "bmp_max[$z]=$msize" >>$jian
                    dd if=$img of="$lu2/$z.bmp" skip=$bsize count=$e bs=1
                done
                    touch $lu2/禁止更改这里的图片和存放东西
                    echo "- 已解包完成请按解压出来的图片名称自定义ps要修改的图片，原$name也备份在这个目录里"
                    echo "- 路径：$lu2，禁止更改这个目录的文件，否则需要重新解析才能得出图片，并会自动清空这个目录"
                    echo "- PS注意事项："
                    echo "1.图片分辨率不一定要和官方的一样，但是可能因设备不同出错时就必须和官方的一样"
                    echo "2.图片必须.bmp格式，别异想天开改个后缀就是bmp格式了"
                    echo "3.最终做好的bmp成品图片不能大于我提示的字节"
fi
