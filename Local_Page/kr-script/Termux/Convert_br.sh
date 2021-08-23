#本脚本由　by Han | 情非得已c，编写
#应用于搞机助手上


. $ShellScript/Termux/common.sh
output_Dir=${File%/*}
[[ ! -f "$File" ]] && abort "！$File文件不存在"
Check brotli
echo "- 正在解包中请稍等……"
cd "$output_Dir"
echo "- 压缩级别：$q"
$BROTLI -q "$q" "$File"

if [[ $Remove -eq 1 ]]; then
    echo "- 已选择删除源文件$File"
    rm -f "$File"
fi
    end
