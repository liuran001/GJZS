#本脚本由　by Han | 情非得已c，编写
#应用于搞机助手上


for i in `adb2 -s ./Get_Package_Name-3.sh`; do
    grep "$i" $APK_Name_list2 2>/dev/null || echo "$i"
done
