#本脚本由　by Han | 情非得已c，编写
#应用于搞机助手上


IFS=$'\n'
echo "$Extract" > $Data_Dir/img_Extract_Dir.log
[[ ! -d "$Extract" ]] && mkdir -p "$Extract"

for i in $IMG; do
    e=${i##*/}
    File="$Extract/${e}_${Time}.img"
    [[ ! -L $i ]] && abort "！$e分区不存在无法提取"
    echo "- 开始提取$e分区…………"
    dd if="$i" of="$File"
    echo "- 已提取$e分区到：$File"
    echo
done
