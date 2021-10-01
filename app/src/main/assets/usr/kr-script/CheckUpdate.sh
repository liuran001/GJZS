#本脚本由　by Han | 情非得已c，编写
#应用于搞机助手上


V() {
    Configuration=`grep_prop Configuration $Load`
    echo "云端页面：`cat $Data_Dir/Cloud_Version.log`"
    echo "功能版本：$Util_Functions_Code"
    echo "配置版本：$Configuration"
    echo "$1版本：$Version_Name（$Version_code）"
    echo "永久免费，禁止倒卖"
}

if [[ -f $Core ]]; then
if [[ -f ~/offline ]]; then
	V 软件
else
    if [[ $Version_code -lt $New_Code ]]; then
        echo "- 当前版本：$Version_Name（$Version_code）"
        echo "- 已发布了最新版本：$New_Version（$New_Code）"
        echo "- 请前往https://gjzs.qqcn.xyz/ 下载最新版本"
        echo "- 如果你在软件上遇到bug，可联系重制版作者QQ1939426769"
    else
        V 软件
    fi
fi
elif [[ ! -s $Core ]]; then
        echo -e "\n！连接服务器失败❌（error：404）"
fi
