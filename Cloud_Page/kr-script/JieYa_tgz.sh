#本脚本由　by Han | 情非得已c，编写
#应用于搞机助手上



echo "Dir=$Dir" >$Data_Dir/JieYa_tgz.log
Dir2=${Source_File%/*}
Dir3="${Dir:="$Dir2"}"
name="${Source_File##*/}"
name2="$Dir3/${name%.*}"

[[ ! -d "$name2" ]] && mkdir -p "$name2"
echo "正在解压中，请骚等……﻿⊙∀⊙！"
echo "如果出现红色字体就是代表解压出错了，请尝试用专业解压缩软件解压"
echo "解压出错的文件不能拿去做用途，否则后果自负！请手动删除解压错误的文件"
echo
tar -zxvf "$Source_File" -C "$name2" 1>/dev/null
code=$?
[[ $code -ne 0 ]] && echo "返回码：$code";
echo "解压文件输出目录路径："$name2""
