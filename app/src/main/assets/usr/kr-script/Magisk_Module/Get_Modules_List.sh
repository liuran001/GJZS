#本脚本由　by Han | 情非得已c，编写
#应用于搞机助手上


echo "Reboot|是否立即重启？（推荐）"
IFS=$'\n'
for i in `ls $Modules_Dir`; do
    name=`grep_prop name "$Modules_Dir/$i/module.prop"`
    if [[ -n $name ]]; then
        echo "$i|$name"
    else
        echo "$i"
    fi
done