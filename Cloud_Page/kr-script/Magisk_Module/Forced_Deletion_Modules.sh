#本脚本由　by Han | 情非得已c，编写
#应用于搞机助手上


[[ -z "$state" ]] && abort "！未选中模块"
IFS=$'\n'
for i in $state; do
    [[ $i = Reboot ]] && ChongQi=1 && continue
    Module="$Modules_Dir/$i"
    Module2="${Modules_Dir}_update/$i"
    Module_us="$Module/uninstall.sh"
    Module_us2="$Module2/uninstall.sh"
    [[ -f "$Module_us" ]] && sh "$Module_us" &>/dev/null
    [[ -f "$Module_us2" ]] && sh "$Module_us2" &>/dev/null
    rm -rf "$Module" "$Module2"
    [[ $? = 0 ]] && echo "已删除模块：$i"
done
CQ
sleep 3
