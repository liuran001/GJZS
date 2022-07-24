[[ ! -d "$Data_Dir/.Empty" ]] && mkdir -p "$Data_Dir/.Empty"
cd $Data_Dir/.Empty
sc="$ShellScript/Shell2.sh"
echo "$CMD" >$sc

echo -e "- 当前输入的命令：\n"
cat $sc
echo -e "\n------------------------------------------------\n"
echo -e "- 执行结果：\n"
. $sc
echo -e "\n------------------------------------------------\n"
