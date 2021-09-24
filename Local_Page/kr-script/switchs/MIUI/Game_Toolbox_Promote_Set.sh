#本脚本由　by Han | 情非得已c，编写
#应用于搞机助手上


if [[ $state == 0 ]]; then
   lu=`dirname $Game_Toolbox_File`
   [[ ! -d $lu ]] && mkdir -p $lu
   [[ ! -f $Game_Toolbox_File ]] && touch $Game_Toolbox_File
   echo -e "\nHan" >>$Game_Toolbox_File
   sed -i '/^$/d' $Game_Toolbox_File
   echo "已去除游戏工具箱下方的官方推介的快捷窗口应用入口"
else
   sed -i -e '/^Han$/d' -e '/^$/d' $Game_Toolbox_File
   echo "已恢复默认"
fi
set_Game_Toolbox