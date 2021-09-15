#本脚本由　by Han | 情非得已c，编写
#应用于搞机助手上


case $Option in
    verify)
        . $ShellScript/MultiFunction.sh Magisk -verify "$File"
    ;;
    
    sign)
        File1=${File%.*}
        File3="${File1}_sign.img"
        
        . $ShellScript/MultiFunction.sh Magisk -sign "$File" "$File3"
    ;;
esac