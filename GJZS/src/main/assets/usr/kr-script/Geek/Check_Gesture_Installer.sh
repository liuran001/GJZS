#本脚本由　by Han | 情非得已c，编写
#应用于搞机助手上


if [[ -f $Load ]]; then
    echo "已上传版本："
    . $Load com.fb.fluid
    echo "$name-$version($versionCode)"
    . $Load com.omarea.gesture
    echo "$name-$version($versionCode)"
fi
    if [[ -d $Frame_Dir/Fluid-NG ]]; then
        mask com.fb.fluid
        echo -e "\n已安装流体手势导航-${version}($versionCode)"
    elif [[ -d $Frame_Dir/Gesture ]]; then
        mask com.omarea.gesture
        echo -e "\n已安装Gesture(手势导航) -${version}($versionCode)"
    else
        [[ ! -d $Frame_Dir/Fluid-NG ]] && echo -e "\n未安装流体手势导航"
        [[ ! -d $Frame_Dir/Gesture ]] && echo "未安装Gesture(手势导航)"
    fi
