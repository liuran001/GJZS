#本脚本由　by Han | 情非得已c，编写
#应用于搞机助手上


Tu=/data/system/theme/$1
File=$GJZS/$2壁纸$Time.jpg

case $1 in
    wallpaper)
    Tu2=/data/system/users/0/$1
        if [[ -f $Tu2 ]]; then
            Tu=$Tu2
            echo "- 正在提取$2壁纸."
        elif [[ -f $Tu ]]; then
            echo "- 正在提取$2壁纸.."
        else
            abort "！未找到$2壁纸"
        fi
    ;;
    
    lock_wallpaper)
        if [[ -f $Tu ]]; then
            echo "- 正在提取$2壁纸"
        else
            abort "！未找到$2壁纸"
        fi
    ;;
esac

cp -f $Tu $File
echo "- 文件输出路径：\"$File\""
echo "- 完成"
