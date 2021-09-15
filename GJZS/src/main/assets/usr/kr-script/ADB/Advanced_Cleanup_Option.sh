#本脚本由　by Han | 情非得已c，编写
#应用于搞机助手上


[[ $Format_data = 1 ]] && fastboot format data && echo "已格式化data" 
[[ $Restore_Factory = 1 ]] && fastboot -w && echo "已恢复出厂设置"
[[ $Erase_cache = 1 ]] && fastboot erase cache && echo "已清除cache分区"
[[ $Erase_data = 1 ]] && fastboot erase data && echo "已清除data分区"
[[ $Erase_userdata = 1 ]] && fastboot erase userdata && echo "已清除userdata用户数据"
[[ $Erase_system = 1 ]] && fastboot erase system && echo "已清除system分区"
[[ $Erase_system_a = 1 ]] && fastboot erase system_a && echo "已清除system_a分区"
[[ $Erase_system_b = 1 ]] && fastboot erase system_b && echo "已清除system_b分区"
[[ $Erase_vendor = 1 ]] && fastboot erase vendor && echo "已清除vendor分区"
[[ $Erase_vendor_a = 1 ]] && fastboot erase vendor_a && echo "已清除vendor_a分区"
[[ $Erase_vendor_b = 1 ]] && fastboot erase vendor_b && echo "已清除vendor_b分区"
[[ $Erase_boot = 1 ]] && fastboot erase boot && echo "已清除boot分区"
[[ $Erase_boot_a = 1 ]] && fastboot erase boot_a && echo "已清除boot_a分区"
[[ $Erase_boot_b = 1 ]] && fastboot erase boot_b && echo "已清除boot_b分区"
[[ $Erase_recovery = 1 ]] && fastboot erase recovery && echo "已清除recovery分区"
