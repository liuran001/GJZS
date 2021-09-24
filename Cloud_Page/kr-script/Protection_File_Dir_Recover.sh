#本脚本由　by Han | 情非得已c，编写
#应用于搞机助手上


if [[ -n $state ]]; then
   for i in ${state}; do
      chattr -R -ia $i
      if [[ $? = 0 ]]; then
         echo "已恢复了$i"
         sed -i "/${i//\//\\/}/d" $Data_Dir/Protection_File_Dir.log
      fi
   done
else
   echo "！未勾选无法恢复"
fi
