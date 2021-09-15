#本脚本由　by Han | 情非得已c，编写
#应用于搞机助手上


lu=`dirname $Game_Toolbox_File`
[[ ! -d $lu ]] && mkdir -p $lu
echo >>$Game_Toolbox_File
echo -e "已添加的包名如下：\n\n------------------------------------------------------\n"
printf "$package" | sed 's/ /\\n/g' | tee -a $Game_Toolbox_File
sort -u $Game_Toolbox_File -o $Game_Toolbox_File
echo -e "\n\n------------------------------------------------------\n\n已添加完成。"
sed -i '/^$/d' $Game_Toolbox_File
set_Game_Toolbox