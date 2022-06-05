lu=$PeiZhi_File/BootAnimation_Screen1/Customize
lu2=$GJZS/Customize_BootAnimation_Screen1
jian=$lu/Configuration.log
. $jian
img=$lu/$IMG_Name
tmp=$TMPDIR/$IMG_Name

echo "- 开始复制到临时目录"
cp -f $img $tmp


echo "- 开始检查已选择的图片是否符合规格"
Start_Time
echo 0 >"$Status"
for i in `seq $Picture`; do
    bmp=`eval echo '$bmp'$i`
    cf=`od -An -tx1 "$bmp" | head -n 1 | tr -d ' ' | grep '^424d'`
    if [[ -n $cf ]]; then
        echo "- 图片信息：`file "$bmp"`"
        echo
    else
        error "！$bmp文件不是.bmp图片格式禁止更改"
        echo "- 错误详情："
        error "！`file "$bmp"`"
        echo 1 >"$Status"
    fi
    
        bsize=`wc -c < "$bmp"`
        msize=${bmp_max[$i]}
        [[ $bsize -gt $msize ]] && error "！当前已选择的$bmp图片为：$bsize字节大于原来的图片$msize字节无法刷入" && echo 1 >"$Status"
done

s=`cat "$Status"`
[[ $s -ne 0 ]] && exit 1
    for i in `seq $Picture`; do
        bmp=`eval echo '$bmp'$i`
        echo "- 开始写入："$bmp""
        dd if="$bmp" of=$tmp seek=${offset[$i]} count=`wc -c < "$bmp"` bs=1
    done
        End_Time 制作 
            if [[ $Way = zs ]]; then
                echo "- 开始刷入到$IMG_Name分区"
                dd if=$tmp of=$IMG
                rm -rf $tmp
                CQ
            else
                mv -f $tmp $lu2
                echo
                echo "- 文件已输出到$lu2/$IMG_Name"
                echo "！温馨提示：如果重新点击「生成配置」这个目录所有文件会被清空"
            fi
            
