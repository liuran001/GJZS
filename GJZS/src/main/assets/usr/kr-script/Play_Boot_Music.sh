#本脚本由　by Han | 情非得已c，编写
#应用于搞机助手上


log=$Data_Dir/Play_Boot_Music.log
echo "bootaudio=$bootaudio" >$log
echo "Customize_lu=$Customize_lu" >>$log

if [[ $bootaudio = Customize ]]; then
    echo "- 已选择自定义路径：$Customize_lu"
    jian="$Customize_lu"
else
    echo "- 已选择路径：$bootaudio"
    jian="$bootaudio"
fi
    [[ -f "$jian" ]] && Play_Music "$jian" || abort "！$jian文件不存在无法播放"
