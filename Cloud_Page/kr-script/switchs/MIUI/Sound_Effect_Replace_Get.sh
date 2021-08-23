#本脚本由　by Han | 情非得已c，编写
#应用于搞机助手上


if [[ $1 = -system ]]; then
    f="/system/media/audio/ui/$2"
elif [[ $1 = -mask ]]; then
    f="$Modules_Dir/Han.GJZS-MIUI/system/media/audio/ui/$2"
fi

md5=`md5sum < $f`
if [[ $md5 = 64093e670b664838b01648704ce746ea* ]]; then
    echo 1
else
    echo 0
fi