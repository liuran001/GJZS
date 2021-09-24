#本脚本由　by Han | 情非得已c，编写
#应用于搞机助手上


File=$Data_Dir/ADB_Hidden_app_Records.log

if [[ -n $package ]]; then
    for i in $package; do
        adb2 -c pm unhide "$i"
        if [[ $? = 0 ]]; then
            echo "已恢复了$i"
            sed -i "/$i/d" $File
        fi
    done
else
echo "！未勾选包名无法恢复"
fi
