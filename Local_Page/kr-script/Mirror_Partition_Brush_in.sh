#本脚本由　by Han | 情非得已c，编写
#应用于搞机助手上


CQ2() {
    if [[ $ChongQi2 = 1 ]]; then
        echo "即将重启到恢复模式，倒计时开始……"
        for i in $(seq 4 -1 1); do
            echo $i
            sleep 1
        done
        reboot recovery
    fi
}

[[ -z $IMG ]] && abort "！选择分区哈"
IFS=$'\n'
e=${IMG##*/}
echo "- 您当前选择了$e分区"
echo "- 刷入文件路径：$Brush_in"
echo "- 检测刷入镜像文件是否存在"
[[ ! -L "$IMG" ]] && abort "！$e分区不存在无法刷入"
    if [[ -f "$Brush_in" ]]; then
        echo "- 开始刷写$e分区"
        dd if="$Brush_in" of="$IMG" && CQ && CQ2
    else
        abort "！$Brush_in刷入文件不存在无法刷写到$e分区"
    fi
    echo "- 完成"
    sleep 2
