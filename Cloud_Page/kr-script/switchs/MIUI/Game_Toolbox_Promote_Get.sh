#本脚本由　by Han | 情非得已c，编写
#应用于搞机助手上


a=`grep '^Han$' $Game_Toolbox_File`
if [[ -n $a ]]; then
    echo 0
else
    echo 1
fi
