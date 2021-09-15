#本脚本由　by Han | 情非得已c，编写
#应用于搞机助手上

appinfo -r | awk -F'"' '{print $1}'
#pm list package -d | cut -f2 -d ':'
