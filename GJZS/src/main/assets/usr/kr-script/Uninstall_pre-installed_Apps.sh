#本脚本由　by Han | 情非得已c，编写
#应用于搞机助手上


for i in $package; do
   echo "- 开始卸载$i"
   pm uninstall $i
   rm -rf $SD_PATH/Android/data/$i
done