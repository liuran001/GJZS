#本脚本由　by Han | 情非得已c，编写
#应用于搞机助手上


[[ -z $package ]] && abort "！请选择你要删除的包名"
echo -e "已删除的包名如下：\n\n------------------------------------------------------\n"
for i in $package; do
    sed -i "/$i/d" $Game_Toolbox_File
    echo "已删除$i"
done
    sed -i '/^$/d' $Game_Toolbox_File
    echo -e "\n\n------------------------------------------------------\n\n已删除完成。"
    set_Game_Toolbox
