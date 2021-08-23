#本脚本由　by Han | 情非得已c，编写
#应用于搞机助手上


if [[ $Option -eq 1 ]]; then
    o=+i
elif [[ $Option -eq 2 ]]; then
    o=+a
else
    o=-ia
fi

if [[ $Subdirectory -eq 1 ]]; then
    c="chattr -R $o"
else
    c="chattr $o"
fi


case $Option in
1 | 2)
    echo "$File_Dir" "$File_Dir2" | while read i; do
        $c "$i"
        [[ $? = 0 ]] && echo "已保护了$i" && echo "$i" >>$Data_Dir/Protection_File_Dir.log
    done
;;
0)
    echo "$File_Dir" "$File_Dir2" | while read i; do
        $c "$i"
        [[ $? = 0 ]] && echo "已解除了对$i的保护"
    done
;;
esac