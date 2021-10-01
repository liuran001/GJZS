#本脚本由　by Han | 情非得已c，编写
#应用于搞机助手上


. $ShellScript/Termux/common.sh
output_Dir=${br%/*}
[[ ! -f "$br" ]] && abort "！$br文件不存在"
Check brotli
echo "- 正在解包中请稍等……"
cd "$output_Dir"
if [[ $Remove -eq 1 ]]; then
    echo "- 已选择删除$br源文件"
    $BROTLI -dj "$br"
else
    $BROTLI -d "$br"
fi
    end
