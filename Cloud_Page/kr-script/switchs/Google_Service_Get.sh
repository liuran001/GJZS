#本脚本由　by Han | 情非得已c，编写
#应用于搞机助手上


disabled=`pm list packages -d com.google.android.gms`
if [[ -n $disabled ]]; then
    echo 0
else
    echo 1
fi
