#本脚本由　by Han | 情非得已c，编写
#应用于搞机助手上


LN=`which ln`
RM=`which rm`

mask -v
dir=`dirname $Magisk`
if [[ $Option -eq 0 ]]; then
    $Magisk su -c "$LN -sf $Magisk $dir/su"
    echo "- 已恢复了Magisk ROOT，已立即生效"
else
    $Magisk su -c "$RM -f $dir/su"
    echo "- 已隐藏了Magisk ROOT，已立即生效"
fi
