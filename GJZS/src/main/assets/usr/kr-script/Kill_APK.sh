#本脚本由　by Han | 情非得已c，编写
#应用于搞机助手上


echo "- 正在处理中请稍等……"

for i in `pm list package -3`; do
    apk=${i/package:/}
    [[ $apk = $Package_name ]] && continue
    [[ $apk = com.tencent.qqpinyin ]] && continue
    echo "- 开始停止$apk"
    am force-stop ${apk}
done
