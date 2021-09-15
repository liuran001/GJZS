#本脚本由　by Han | 情非得已c，编写
#应用于搞机助手上


version=1
jian="$ELF1_Path/zipsigner"
log="$Data_Dir/Zipsigner_version.log"

[[ -f $log ]] && user_version=`cat $log` || user_version=0

if [[ $user_version -lt $version || ! -f $jian ]]; then
    echo $version >"$log"
    Choice=1
    . $Load Zipsigner
    echo "开始解压资源……"
    unzip -oq "$Download_File" -d "$ELF1_Path"
    chmod 755 $ELF1_Path/*
fi


File="${File:="$File2"}"
File1=${File%.*}
File2=${File##*.}
File3="${File1}_sign.$File2"

! test -f "$File" && abort "！$File 文件不存在"
echo "签名中请骚等，速度看文件大小而定……"
zipsigner "$File" "$File3"
    if [[ $? = 0 ]]; then
        echo "文件已保存到：$File3"
        return 0
    else
        error "签名$File失败"
        return 1
    fi