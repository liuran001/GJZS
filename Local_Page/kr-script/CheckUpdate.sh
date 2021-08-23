#本脚本由　by Han | 情非得已c，编写
#应用于搞机助手上


V() {
    Configuration=`grep_prop Configuration $Load`
    echo "$1版本：$Version_Name（$Version_code）"
    echo "您正在使用离线版"
}

V 软件