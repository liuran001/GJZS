#本脚本由　by Han | 情非得已c，编写
#应用于搞机助手上


[[ ! -f "$ZIPFILE" ]] && abort "！$ZIPFILE文件不存在无法解密"
echo "开始解密，请骚等……"
TmpFile=$Script_Dir
OutFile=${ZIPFILE%.zip}
[[ -d $TmpFile ]] && rm -rf $TmpFile &>/dev/null
mkdir -p $TmpFile
unzip -o "$ZIPFILE" -d $TmpFile
cd $TmpFile
zip -rq "$OutFile-已解密".zip ./*
rm -rf $TmpFile
echo
echo "文件输出路径：$OutFile-已解密.zip"
