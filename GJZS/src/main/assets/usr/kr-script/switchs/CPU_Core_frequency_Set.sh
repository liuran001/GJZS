#本脚本由　by Han | 情非得已c，编写
#应用于搞机助手上


if [[ $state -eq 1 ]]; then
    setprop sys.sptm.gover true
else
    setprop sys.sptm.gover false
fi
