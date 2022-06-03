#本脚本由　by Han | 情非得已c，编写
#应用于搞机助手上


[[ ! -d "$Data_Dir/.Empty" ]] && mkdir -p "$Data_Dir/.Empty"
cd $Data_Dir/.Empty
# echo "$Actuator" >$Data_Dir/Shell.log
sc="$ShellScript/Shell2.sh"
echo "$CMD" >$sc

echo -e "- $currently_entered_command: \n"
cat $sc
echo -e "\n------------------------------------------------\n"
echo -e "- $execution_results: \n"
Start_Time
. $sc
echo -e "\n------------------------------------------------\n"
End_Time $execute
