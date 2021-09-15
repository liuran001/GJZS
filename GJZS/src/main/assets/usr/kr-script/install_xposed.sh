#本脚本由　by Han | 情非得已c，编写
#应用于搞机助手上


case "$ABI" in
    arm64*) Type=arm64;;
    arm*) Type=arm;;
    x86*) Type=x86;;
    *) abort "！ 未知的架构 ${ABI}，无法安装xposed";;
esac

. $Load Xposed_rovo89 -$Option

jian=$Script_Dir/META-INF/com/google/android/update-binary

rm -rf $Script_Dir
mkdir -p $Script_Dir
unzip -o "$Download_File" 'META-INF/com/google/android/update-binary' -d $Script_Dir
chmod 755 $jian
(
export NO_UIPRINT=1
$jian 2 1 "$Download_File"
)

[[ $Option = install ]] && . ./install_App_Store_File.sh de.robv.android.xposed.installer
ChongQi=1
CQ
