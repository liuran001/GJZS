#本脚本由　by Han | 情非得已c，编写
#应用于搞机助手上


[[ ! -f "$File" ]] && abort "！$File文件不存在"
tar -xzvf "$File" -C $Modules_Dir
echo "已恢复模块，重启手机才能生效。"
