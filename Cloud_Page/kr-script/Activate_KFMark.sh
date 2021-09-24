#本脚本由　by Han | 情非得已c，编写
#应用于搞机助手上


Choice=1
. $Load kfmark
if [[ -f $Download_File ]]; then
    chmod 755 $Download_File
    $Download_File
    [[ $? = 0 ]] && echo -e "\n\n已成功激活快否"
else
    echo "文件不存在激活失败"
fi
