#本脚本由　by Han | 情非得已c，编写
#应用于搞机助手上


mask riru-core
if [[ -d "$Module" ]]; then
    echo "- 已安装了Riru （Riru - Core）$version($versionCode)"
else
    abort "！未安装Riru"
fi

case $Option in
    1)
        if [[ $versionCode -gt 59 ]]; then
            # 24.0.0+(314)
            touch /data/adb/modules/riru-core/enable_hide
        else
            touch /data/adb/riru/enable_hide
        fi
            echo "- 已开启 Riru 隐藏机制（也需要模块的支持）"
    ;;
    
    0)
        rm -rf /data/adb/modules/riru-core/enable_hide /data/adb/riru/enable_hide
        echo "- 已恢复默认"
    ;;
esac
CQ
