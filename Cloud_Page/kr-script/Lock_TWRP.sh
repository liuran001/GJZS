#本脚本由　by Han | 情非得已c，编写
#应用于搞机助手上


[[ $Scheme = 0 ]] && return 0

case $Scheme in
1)
    echo "- 开始修补启动注入补丁以防止twrp被覆盖"
    for i in $boot_IMG; do
        echo "- 开始检验状态"
        AVBf=`tail -c 2k "$i" | grep "AVBf" 2>/dev/null`
        [[ -z "$AVBf" ]] && error "- 没有AVB 2.0引导，无法注入补丁" && continue
        pReAVBf=`tail -c 2k "$i" | grep "pReAVBf" 2>/dev/null`
        [[ -z "$pReAVBf" ]] && echo "- 已安装补丁，无需重复注入" && continue
        echo "- 开始修补`basename $i`分区"
        magiskboot hexpatch "$i" 0000000041564266000000 0070526541564266000000 || abort "注入失败"
    done
;;

2)
    echo "- 开始签名boot.img以防止twrp被覆盖"
    File=$EXECUTOR_PATH
    for i in $boot_IMG; do
        echo "- 签名`basename $i`分区"
        . $ShellScript/MultiFunction.sh Magisk -sign "$i" "$i"
    done
;;
esac
