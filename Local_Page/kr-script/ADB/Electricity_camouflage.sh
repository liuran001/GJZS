#本脚本由　by Han | 情非得已c，编写
#应用于搞机助手上


if [[ $Percentage0 == 1 ]]; then
    adb2 -c dumpsys battery reset
    echo "已恢复默认值：`adb2 -c dumpsys battery | awk '/level/{print $2}'`"
elif [[ -n $Percentage1 ]];then
    echo "您输入了$Percentage1，开始修改…………"
    adb2 -c dumpsys battery set level $Percentage1
    echo "已成功电量伪装为：$Percentage1"
else
    echo "您没有填写数值开始使用滑动方案进行修改"
    echo "您滑动的值为$Percentage2，开始修改…………"
    adb2 -c dumpsys battery set level $Percentage2
    echo "已成功电量伪装为：$Percentage2"
fi
    sleep 2
