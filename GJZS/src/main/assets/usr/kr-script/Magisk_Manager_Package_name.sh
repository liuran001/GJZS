#本脚本由　by Han | 情非得已c，编写
#应用于搞机助手上


echo "$Magisk_Manager" >$Data_Dir/Magisk_Manager_Package_name.log
if [[ -z "$Magisk_Manager" ]]; then
    echo "- 开始识别Magisk Manger包名……"
    test -d $DATA_DIR/com.topjohnwu.magisk
        if [[ $? -eq 0 ]]; then
            Magisk_Manager=com.topjohnwu.magisk
        else
            echo -n "- 开始查找随机包名安装的Magisk Manger ."
            t=`ls /data/user_de/*/*/shared_prefs/su_timeout.xml 2>/dev/null`
                if [[ $? -eq 0 ]]; then
                    echo -n "."
                    Magisk_Manager=`echo $t | cut -d / -f 5`
                else
                    echo -n " ."
                    Magisk_Manager=$(magisk --sqlite "SELECT value FROM strings WHERE key='requester'" 2>/dev/null | cut -d= -f2)
                    if [[ -z $Magisk_Manager ]]; then
                        echo -n " ."
                        Magisk_Manager=$(strings /data/adb/magisk.db | sed -rn 's/^.?requester//p')
                        [[ -z $Magisk_Manager ]] && abort "！未识别到Magisk Manger包名"
                    fi
                fi
        fi
        echo -e "\n- 已识别到Magisk Manger包名为：$Magisk_Manager"
fi

[[ -d $DATA_DIR/$Magisk_Manager ]] || abort "！未识别出Magisk Manger包名"
