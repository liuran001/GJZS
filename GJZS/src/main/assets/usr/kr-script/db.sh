#本脚本由　by Han | 情非得已c，编写
#应用于搞机助手上


case $Option in
    Check)
        sqlite3 "$File" .dump
    ;;
    
    output)
        suffix=${File##*.}
        [[ $suffix != db ]] && abort "！选择的$File不是.db文件"
        OutFile=${File%.$suffix}
        sqlite3 "$File" .dump >"$OutFile-$Time.sql"
        echo "- 文件已输出到：$OutFile-$Time.sql"
    ;;
    
    pack)
        suffix=${File##*.}
        [[ $suffix != sql ]] && abort "！选择的$File不是.sql文件"
        OutFile=${File%.$suffix}
        sqlite3 "$OutFile-$Time.db" <"$File"
        echo "- 文件已输出到：$OutFile-$Time.db"
    ;;
esac
