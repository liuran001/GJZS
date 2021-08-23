#本脚本由　by Han | 情非得已c，编写
#应用于搞机助手上

p() {
    echo -e "\n------------------------------------------------\n"
}


echo "查看设备连接状态"
fastboot devices | sed 's/fastboot/　&/g'
p
#echo "BL状态：`fastboot getvar unlocked 2>&1 | egrep -q 'unlocked.*yes' && echo "已解锁" || echo "未解锁"`"
echo "查看设备序列号"
fastboot getvar serialno
[[ $? -eq 126 ]] && exit 126
echo "设备产品代号"
fastboot getvar product
echo "设备储存类型"
fastboot getvar variant
echo "检查是否允许解锁，仅供参考"
echo "显示：get_unlock_ability: 1，说明允许解锁"
echo "显示：get_unlock_ability: 0，说明不允许解锁"
fastboot flashing get_unlock_ability

echo
echo
p
echo "查看BL解锁状态，由于设备不统一所以用了很多命令来查看"
p
echo ①
echo "理论上显示：Device unlocked: true，说明已解锁"
echo "理论上显示：Device unlocked: false，说明未解锁"
fastboot oem device-info
p
echo ②
echo "理论上显示：unlocked: yes，说明已解锁"
echo "理论上显示：unlocked: no，说明未解锁"
fastboot getvar unlocked
p
echo ③
echo "查看MTK BL解锁状态"
echo "理论上显示：lks = 0，说明已解锁"
echo "理论上显示：lks = 1，说明未解锁"
fastboot oem lks
p
echo ④
echo "理论上显示：Lock State: UNLOCKED，说明已解锁"
echo "理论上显示：Lock State: LOCKED，说明未解锁"
fastboot oem get-bootinfo
if [[ $ShowAll -eq 1 ]]; then
echo
p
echo "已选择查看设备全部信息"
fastboot getvar all
fi

exit 0
#慎用小米会导致上锁
# echo ⑥
# echo "理论上显示：LockState: UNLOCKED，说明已解锁"
# echo "理论上显示：LockState: LOCKED，说明未解锁"
# fastboot oem lock-state info
