#本脚本由　by Han | 情非得已c，编写
#应用于搞机助手上


if [[ $state == 1 ]]; then
    pm enable com.google.android.gsf &>/dev/null
    pm enable com.google.android.gsf.login &>/dev/null
    pm enable com.google.android.gms &>/dev/null
    pm enable com.android.vending &>/dev/null
    pm enable com.google.android.play.games &>/dev/null
    echo "- 已启用谷歌框架！"
else
    pm disable com.google.android.gsf &>/dev/null
    pm disable com.google.android.gsf.login &>/dev/null
    pm disable com.google.android.gms &>/dev/null
    pm disable com.android.vending &>/dev/null
    pm disable com.google.android.play.games &>/dev/null
    echo "- 已临时禁用谷歌框架！"
fi
    sleep 2
