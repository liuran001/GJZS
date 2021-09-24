#本脚本由　by Han | 情非得已c，编写
#应用于搞机助手上


d=$1
b=$2
[[ $# -eq 2 ]] && rm -rf /data/system/package_cache/*/*$d*

case $Sound in
    uninstall)
        pm uninstall $b
    ;;

    install)
        . ./install_App_Store_File.sh $b
    ;;
esac
