#本脚本由　by Han | 情非得已c，编写
#特别鸣谢：1群里的by 依心所言提供思路
#应用于搞机助手上


abort() {
    echo "$@" 1>&2
    echo 1 >$Status
    exit 1
}

. $Core

IFS=$'\n'
suffix=${File##*.}
name=`basename "$File"`
[[ $1 = -s ]] && installer=" -i $installer " || installer=" "

#com.android.vending

echo "- 开始安装$name……"
echo 0 >$Status
if [[ ! -f $File ]]; then
     abort "！ 文件不存在无法安装"
else
     unzip -l "$File" &>/dev/null
     [[ $? -ne 0 ]] && abort "！$name 不是压缩文件"
fi

     if [[ $suffix = apk ]]; then
          size=`wc -c < "$File"`
          a="cat \""$File"\" | adb2 -c pm install -r -S "$size""$installer" 1>/dev/null"
          eval $a
          result=$?
          if [[ $result = 0 ]]; then
                echo "- $name安装成功"
                [[ $Delete_APK = 1 ]] && rm -f "$File"
                echo 0 >$Status
          else
                echo "！使用A计划安装失败，自动启用B计划安装$name"
                cp -f "$File" $TMP
                a="adb2 -c pm install -r"$installer"\""$TMP/$name"\" 1>/dev/null"
                eval $a
                result=$?
                rm -f "$TMP/$name"
                [[ $result -eq 0 ]] && echo "- $name安装成功" || { [[ $Choice = 1 ]] && cp -f "$File" "$GJZS/$name" && abort -e "！$name安装失败\n已自动复制到：$GJZS/$name，请手动前往安装"; }
          fi
          exit $result
     elif [[ $suffix = apex ]]; then
          size=`wc -c < "$File"`
          a="cat \""$File"\" | adb2 -c pm install -r -S "$size" --apex"$installer" 1>/dev/null"
          eval $a
          result=$?
          [[ $result = 0 ]] && echo "- $name安装成功" && [[ $Delete_APK = 1 ]] && rm -f "$File" || abort "！$name安装失败."
          exit $result
     fi
     
          if unzip -l "$File" | fgrep -q 'Android/obb'; then
                echo "- 开始解压obb资源……"
                Dir="$Script_Dir"
                rm -rf $Dir
                mkdir -p $Dir
                Target=/sdcard
                unzip -o "$File" 'Android/*' -d "$Dir" 1>/dev/null
                [[ $? = 0 ]] && echo "- ${name}obb资源解压成功" || abort "！${name}obb资源解压失败"
                . $ShellScript/ADB/Read_Push_files.sh -push
                rm -rf $Dir
          fi
          Number=`unzip -l "$File" 2>/dev/nul | egrep '\.apk'$ | wc -l`
          [[ $Number -eq 0 ]] && abort "！$name 文件不是正规$suffix文件"
          session1="adb2 -c pm install-create -r"$installer""
          session=`eval $session1`
          echo $session | grep -iq 'Success' || abort "！安装$name失败"
          session_id=$(echo $session | sed -n 's/.*\[\(.*\)\]/\1/p')
          
          echo "- 已检测到有$Number个被分割的apk文件"
                until [[ $Number -eq 0 ]]; do
                     echo "- 开始推送$Number"
                     apk_list=`unzip -l "$File" | egrep '\.apk'$ | sed -n ${Number}p | awk '/.*\.apk$/{print "unzip -p \"'"$File"'\" \""$4"\" | adb2 -c pm install-write -S "$1" '"$session_id"' '"$Number"'.apk"}'`
                     eval $apk_list 1>/dev/null
                     [[ $? -ne 0 ]] && abort "！推送失败，无法安装$name"
                     Number=$((Number-1))
                done
                echo -e "\n- 开始安装……"
                adb2 -c pm install-commit $session_id 1>/dev/null
                result=$?
                     if [[ $result -eq 0 ]]; then
                          echo "- $name成功安装"
                          [[ $Delete_APK = 1 ]] && rm -f "$File"
                     else
                          adb2 -c pm install-abandon $session_id
                          abort "！$name安装失败"
                     fi
                     exit $result
