#本脚本由　by Han | 情非得已c，编写
#应用于搞机助手上


p() {
   echo -e "\n----------------------------------------\n"
}

   (. $ShellScript/Start.sh) 2>&1
p
   if [[ -f $Load || -f $Core ]]; then
      eval `sed -n 1p $Load`
      echo "功能版本：$Util_Functions_Code"
      echo "配置版本：$Configuration"
      p
   fi
