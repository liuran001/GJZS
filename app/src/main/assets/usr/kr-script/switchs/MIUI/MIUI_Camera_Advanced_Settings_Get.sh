#本脚本由　by Han | 情非得已c，编写
#应用于搞机助手上


jian5=$SDdir/DCIM/Camera/lab_options_visible

if [[ -f $jian5 ]]; then
    echo 1
elif [[ ! -f $jian5 ]]; then
    echo 0
fi