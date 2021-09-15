#本脚本由　by Han | 情非得已c，编写
#应用于搞机助手上


echo "正在修改中……"
if [[ $Rotate == 0 ]];then
    echo "即将恢复默认"
    content insert --uri content://settings/system --bind name:s:user_rotation --bind value:i:0
elif [[ $Rotate == 1 ]];then
    content insert --uri content://settings/system --bind name:s:user_rotation --bind value:i:1
elif [[ $Rotate == 2 ]];then
    content insert --uri content://settings/system --bind name:s:user_rotation --bind value:i:2
elif [[ $Rotate == 3 ]];then
    content insert --uri content://settings/system --bind name:s:user_rotation --bind value:i:3
fi
    sleep 2
