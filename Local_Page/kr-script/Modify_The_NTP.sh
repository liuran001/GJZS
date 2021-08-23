#本脚本由　by Han | 情非得已c，编写
#应用于搞机助手上


#setprop persist.backup.ntpServer 0.cn.ntp.org.cn
settings put global ntp_server "$ip"
#settings put global ntp_server_2 0.pool.ntp.org

settings get global auto_time 0
settings get global auto_time_zone 0
sleep 2
settings get global auto_time 1
settings get global auto_time_zone 1