#本脚本由　by Han | 情非得已c，编写
#应用于搞机助手上


. $ShellScript/Termux/common.sh
log=$Data_Dir/Termux_open_payload.log
echo "Option=$Option" >$log
[[ -n $Customize_img && $Option -eq d ]] && echo "Customize_img=$Customize_img" >>$log
output_Dir=${File%/*}
output_Dir2="$output_Dir/imgoutput_$Time"

[[ ! -f "$File" ]] && abort "！$File不存在"
Check protobuf

echo "- 正在解包中请稍等……"
rm -rf $ShellScript/Termux/__pycache__

if [[ $Option = d ]]; then
    mkdir -p "$output_Dir2"
    cd "$output_Dir2"
    $PYTHON $ShellScript/Termux/payload_dumper.py -d "$Customize_img" "$File"
elif [[ $Option = list ]]; then
    $PYTHON $ShellScript/Termux/payload_dumper.py -l "$File"
    exit 0
else
    mkdir -p "$output_Dir2"
    cd "$output_Dir2"
    $PYTHON $ShellScript/Termux/payload_dumper.py "$File"
fi
    output_Dir="$output_Dir2"
    end
