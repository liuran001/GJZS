[[ ! -d "$Data_Dir/.Empty" ]] && mkdir -p "$Data_Dir/.Empty"
cd $Data_Dir/.Empty
sc="$ShellScript/Shell2.sh"
echo "$CMD" >$sc

echo -e "- $currently_entered_command: \n"
cat $sc
echo -e "\n------------------------------------------------\n"
echo -e "- $execution_results: \n"
. $sc
echo -e "\n------------------------------------------------\n"
