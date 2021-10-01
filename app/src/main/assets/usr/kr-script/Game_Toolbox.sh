#本脚本由　by Han | 情非得已c，编写
#应用于搞机助手上


lu=`dirname $Game_Toolbox_File`
[[ ! -d $lu ]] && mkdir -p $lu
[[ ! -f $Game_Toolbox_File ]] && touch $Game_Toolbox_File

if [[ $XuanZe == 0 ]]; then
    echo "您选择添加所有软件方案"
    echo "即将查看哪些没被添加并自动添加……"
    echo "已添加的包名如下"
    echo "------------------------------------------------------"
    for o in `pm list packages | sed 's/.*://g'`; do
        [[ -z `egrep "^$o$" $Game_Toolbox_File` ]] && printf "\n$o" | tee -a $Game_Toolbox_File
    done
elif [[ $XuanZe == 3 ]]; then
    echo "您选择添加第三方软件方案"
    echo "即将查看哪些没被添加并自动添加……"
    echo "已添加的包名如下"
    echo "------------------------------------------------------"
    for o in `pm list packages -3 | sed 's/.*://g'`; do
        [[ -z `egrep "^$o$" $Game_Toolbox_File` ]] && printf "\n$o" | tee -a $Game_Toolbox_File
    done
elif [[ $XuanZe == Customize ]]; then
    printf "您选择自定义添加了如下应用程序"
    for o in "$Customize_APK"; do
        [[ -z `egrep "^$o$" $Game_Toolbox_File` ]] && printf "\n$o" | tee -a $Game_Toolbox_File
    done
fi
    sed -i '/^$/d' $Game_Toolbox_File
    echo -e "\n\n------------------------------------------------------\n\n已添加完成。"-
    set_Game_Toolbox