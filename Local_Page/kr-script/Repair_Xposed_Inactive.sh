#本脚本由　by Han | 情非得已c，编写
#应用于搞机助手上


if [[ $1 = -Dreamland ]]; then
    BM=top.canyie.dreamland.manager
    Name='EdXposed Manager'
elif [[ $1 = -EDXposed ]]; then
    BM=org.meowcat.edxposed.manager
    Name=梦境
elif [[ $1 = -LSPposed ]]; then
    BM=org.meowcat.edxposed.manager
    [[ -d $DATA_DIR/$BM ]] || BM=org.lsposed.manager
    Name=LSPposed
fi

[[ -f /system/lib/libjit.so ]] && abort "！一山不容二虎，请先卸载太极 · 阳模块，再来修复吧！"
[[ ! -d $DATA_DIR/$BM ]] && abort "！未安装$Name无法进行修复"

    echo "开始修复……"
    apk=`pm path $BM | sed 's/.*://g'`
    export File="$TMP/$BM.apk"
    cp -f "$apk" "$File"
    pm uninstall $BM &>/dev/null
    pm install -r "$File" 1>/dev/null
    [[ $? -eq 0 ]] && echo "- 修复成功" || error "！修复失败"
    rm -f "$File"
