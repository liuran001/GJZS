#本脚本由　by Han | 情非得已c，编写
#应用于搞机助手上


ls "$Modules_Dir" | while read i; do
    name=`grep_prop name "$Modules_Dir/$i/module.prop"`
    Size=`du -sh "$Modules_Dir/$i" 2>/dev/null | awk '{print $1}'`
    if [[ -n "$name" ]]; then
        [[ -n $Size ]] && echo "$i|$name「大小：$Size」" || echo "$i|$name"
    else
        [[ -n $Size ]] && echo "$i「大小：$Size」" || echo "$i"
    fi
done
