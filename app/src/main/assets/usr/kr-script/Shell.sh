[[ ! -d "$Data_Dir/.Empty" ]] && mkdir -p "$Data_Dir/.Empty"
cd $Data_Dir/.Empty
# echo "$Actuator" >$Data_Dir/Shell.log
sc="$ShellScript/Shell2.sh"
echo "$CMD" >$sc

echo -e "- 当前输入的命令：\n"
cat $sc
echo -e "\n------------------------------------------------\n"
echo -e "- 执行结果：\n"
Start_Time
. $sc
echo -e "\n------------------------------------------------\n"
End_Time 执行
