abort() {
   echo "$@"
   sleep 1
   exit 1
}

Inject() {
    [[ ! -x "`curl -where`" ]] && Install_Curl
    curl -L -s -o "$2" "$CODING/$1"
}

Install_Curl() {
        echo "- $curl_not_found"
        Curl_URL='http://159.27.81.21/curl'
        wget -O $ELF1_Path/curl3 "$Curl_URL/`getprop ro.product.cpu.abi`"
        wget -O $ELF1_Path/curl3 "$Curl_URL/armeabi-v7a"
        wget -O ~/cacert.pem "$Curl_URL/cacert.pem"
        if $Have_ROOT; then
            . $Core
            [[ ! -f "$ELF1_Path/curl3" ]] && downloader "$ELF1_Path/curl3" "$Curl_URL/`getprop ro.product.cpu.abi`"
            [[ ! -f "$ELF1_Path/curl3" ]] && downloader "$ELF1_Path/curl3" "$Curl_URL/armeabi-v7a"
            [[ ! -f ~/cacert.pem ]] && downloader ~/cacert.pem "$Curl_URL/cacert.pem"
        fi
        chmod +x $ELF1_Path/curl3
}

SCRIPT() {
   if [[ ! -f $2 ]]; then
      Inject $1 $2
      Check_MD5=`md5sum $2 2>/dev/null | sed 's/ .*//g'`
         if [[ $Check_MD5 = $3 ]]; then
            echo "- $init $4 $successfully"
         else
            rm -f $2
            echo "- $init $4 $failed"
         fi
    elif [[ -f $2 ]]; then
      Check_MD5=`md5sum $2 2>/dev/null | sed 's/ .*//g'`
         if [[ $Check_MD5 != $3 ]]; then
           Inject $1 $2
            Check_MD5=`md5sum $2 | sed 's/ .*//g'`
               if [[ $Check_MD5 = $3 ]]; then
                  echo "- $update $4 $successfully"
               else
                  rm -f $2
                  echo "- $update $4 $failed"
               fi
         fi
     fi
}

DATA() {
    if [[ ! -f ~/offline2 ]]; then
        echo "- $detecting_for_script_update"
        Inject data.php "$data_MD5"
    fi
}
DATA
if [[ -f $data_MD5 ]]; then
  . $data_MD5
  if [[ $? -ne 0 ]]; then
     echo -e "\n$server_expired (error：404)"
     echo "$please_update_app"
     sleep 3
     echo -e "\n\n$error_details`cat $data_MD5`"
     sleep 3
     exit 6
  fi
     PeiZhi_File=$Data_Dir
     if [[ ! -d $PeiZhi_File ]]; then
        mkdir -p $PeiZhi_File
        chown $APP_USER_ID:$APP_USER_ID $PeiZhi_File
     fi
        if [[ ! -f ~/offline2 ]];then
            SCRIPT $init_data_ID "$Load" $init_data_MD5 $configuration_file
            [[ ! -f "$Load" ]] && cp "$Load".bak "$Load"
            if [[ ! -f ~/offline ]];then
              SCRIPT $APP_Version_ID "$ShellScript/APP_Version.sh" $APP_Version_MD5 $version_info
              . $ShellScript/APP_Version.sh
            fi
        fi
else
  echo "! $disconnect_internet"
fi
  . $Core
  Installing_Busybox
  echo "- $finished"
  exit 0
