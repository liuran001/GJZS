#本脚本由　by Han | 情非得已c，编写
#应用于搞机助手上


. $ShellScript/Termux/common.sh
output_Dir=${dat%/*}
name=`echo "$dat" | sed 's/.*\///; s/\..*//'`

[[ ! -f "$list" ]] && abort "！$list文件不存在"
[[ ! -f "$dat" ]] && abort "！$dat文件不存在"

Check python

echo "- 正在解包中请稍等……"
cd "$output_Dir"
    $PYTHON $ShellScript/Termux/sdat2img.py "$list" "$dat" "$name.img"
if [[ $? -eq 0 && $Remove -eq 1 ]]; then
    echo "- 已选择删除.list和.dat源文件"
    rm -f "$list" "$dat"
fi
    end
