#本脚本由　by Han | 情非得已c，编写
#应用于搞机助手上


. $Load EdXposed_Manager_Repo
P=org.meowcat.edxposed.manager
file=$DATA_DIR/$P/no_backup/repo_cache.db

pkill $P
am force-stop $P

if [[ ! -f $file ]]; then
    echo "- 未检测到数据开始打开EdXposed Manager"
    sleep 2
    am start -n $P/org.meowcat.edxposed.manager.WelcomeActivity
    input keyevent 4
    pkill $P
    am force-stop $P
fi

cat $Download_File >$file
echo "- 数据写入完毕，打开EdXposed Manager即可"
