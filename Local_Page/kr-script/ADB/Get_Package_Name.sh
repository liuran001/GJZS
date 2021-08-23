for i in `adb2 -s ./Get_Package_Name.sh`; do
    grep "$i" $APK_Name_list2 2>/dev/null || echo "$i"
done
