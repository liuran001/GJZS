#本脚本由　by Han | 情非得已c，编写
#应用于搞机助手上


[[ -n "$Way" ]] && { echo "Way=$Way" >"$Data_Dir/install_App_Store_File.log"
echo "File_Dir=$File_Dir" >>"$Data_Dir/install_App_Store_File.log"
}


Choice=1
. $Load $1
File="$Download_File"
    if [[ $Way = download ]]; then
        [[ -z "$File_Dir" ]] && File_Dir=$GJZS/APK_Extraction && error "！未填写要下载到的目录，已默认下载到$File_Dir"
        DF="$File_Dir/$name-$version($versionCode).apk"
        [[ ! -d "$File_Dir" ]] && mkdir -p "$File_Dir"
        cp -f "$File" "$DF"
        echo "- 文件已下载到：$DF"
    else
        sh $ShellScript/install_apk.sh
    fi