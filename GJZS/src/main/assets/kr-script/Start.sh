#本脚本由　by Han | 情非得已c，编写
#应用于搞机助手上

abort() {
   echo "$@"
   sleep 1
   exit 1
}

Inject() {
	curl -L -s -o "$2" "$CODING/$1"
}

SCRIPT() {
   if [[ ! -f $2 ]]; then
      Inject $1 $2
      Check_MD5=`md5sum $2 2>/dev/null | sed 's/ .*//g'`
         if [[ $Check_MD5 = $3 ]]; then
            echo "- 初始化$4成功"
         else
            rm -f $2
            echo "！ 初始化$4失败"
         fi
    elif [[ -f $2 ]]; then
      Check_MD5=`md5sum $2 2>/dev/null | sed 's/ .*//g'`
         if [[ $Check_MD5 != $3 ]]; then
           Inject $1 $2
            Check_MD5=`md5sum $2 | sed 's/ .*//g'`
               if [[ $Check_MD5 = $3 ]]; then
                  echo "- 更新$4成功"
               else
                  rm -f $2
                  echo "- 更新$4失败"
               fi
         fi
     fi
}

DATA() {
	echo "- 开始检测脚本更新"
    Inject data.php "$data_MD5"
    sleep 1
}
if [[ ! -f ~/offline ]]; then
DATA
if [[ -f $data_MD5 ]]; then
  . $data_MD5
  if [[ $? -ne 0 ]]; then
     echo -e "\n！服务器已过期（error：404）"
     echo "请前往「搞机助手」群更新至最新版本﻿⊙∀⊙！"
     sleep 3
     echo -e "\n\n错误详情`cat $data_MD5`"
     sleep 3
     exit 6
  fi
     PeiZhi_File=$Data_Dir
     if [[ ! -d $PeiZhi_File ]]; then
        mkdir -p $PeiZhi_File
        chown $APP_USER_ID:$APP_USER_ID $PeiZhi_File
     fi
        SCRIPT $Util_Functions_ID "$Core" $Util_Functions_MD5 功能
        SCRIPT $init_data_ID "$Load" $init_data_MD5 配置
else
  echo "！未连接到互联网❓"
fi
fi
  . $Core
  Installing_Busybox
  echo "- 完成！"
  exit 0