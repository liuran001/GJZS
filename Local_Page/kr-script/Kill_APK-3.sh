#本脚本由　by Han | 情非得已c，编写
#应用于搞机助手上


if [[ $1 = -k ]]; then
    for o in $package; do
        echo "- 开始结束运行：$o"
        am force-stop $o
    done
    exit 0
fi


for i in `. ./Get_Package_Name-3.sh`; do
    pidof $i &>/dev/null && echo $i
done
