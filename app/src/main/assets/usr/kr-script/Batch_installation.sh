#本脚本由　by Han | 情非得已c，编写
#应用于搞机助手上


echo "$File_Dir" > $Data_Dir/Batch_installation.log
IFS=$'\n'
log_file="$lu/批量安装$Time.log"

az() {
    export File="$1"
    echo 0 >$Status
    echo

    if [[ $log -eq 1 ]]; then
        sh $ShellScript/install_apk.sh | tee -a "$log_file"
    else
        sh $ShellScript/install_apk.sh
    fi
    result=`cat $Status`
    [[ $result -eq 1 ]] && return $result
    [[ $Delete_APK = 1 ]] && {
    rm -f "$File" &>/dev/null
    echo "${File}已自动删除"
    }
}

[[ ! -d "$File_Dir" ]] && abort "！目录不存在无法批量安装"

if [[ $log == 1 ]]; then
    echo "已选择同时打印安装日志log，日志已保存到：$log_file"
    echo "$Time批量安装日志" &>"$log_file"
else
    echo "没有选择打印安装日志"
fi



case $Search_Dir in
0)
    echo "- 已选择不搜索子目录"
    ls "$File_Dir"/* &>/dev/null
    [[ $? -ne 0 ]] && abort "！$File_Dir目录里未找到任何文件"
    
    ls "$File_Dir"/* | while read apk; do
        az "$apk"
    done
;;

1)
    echo "- 已选择搜索子目录"
    o=`find ${File_Dir} -type f`
    [[ -z $o ]] && abort "！$File_Dir目录和子目录下未找到任何文件"
    
    for apk in `find ${File_Dir} -type f`; do
        az "$apk"
    done
;;
esac
