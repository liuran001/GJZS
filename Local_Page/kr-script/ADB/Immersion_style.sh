#本脚本由　by Han | 情非得已c，编写
#应用于搞机助手上


if [[ -n "$package3" && -n $package ]]; then
    package="$package,$package3"
elif [[ -n "$package3" && -z $package ]]; then
    package="$package3"
fi

List=${package//,/\\n}

    if [ "$Immersion_style" = "1" ]; then
        echo "- 已隐藏状态栏"
        adb2 -c settings put global policy_control immersive.status=*
    elif [ "$Immersion_style" = "2" ]; then
        echo "- 已隐藏虚拟键"
        adb2 -c settings put global policy_control immersive.navigation=*
    elif [ "$Immersion_style" = "3" ]; then
        echo "- 已隐藏虚拟键和状态栏"
        adb2 -c settings put global policy_control immersive.full=*
    elif [ "$Immersion_style" = "4" ]; then
        echo -e "- 已选择仅在指定应用\n$List里隐藏状态栏"
        adb2 -c settings put global policy_control immersive.status=$package
    elif [ "$Immersion_style" = "5" ]; then
        echo -e "- 已选择仅在指定应用\n$List里隐藏虚拟按键"
        adb2 -c settings put global policy_control immersive.navigation=$package
    elif [ "$Immersion_style" = "6" ]; then
        echo -e "- 已选择仅在指定应用\n$List里隐藏状态栏和虚拟按键"
        adb2 -c settings put global policy_control immersive.full=$package
    elif [ "$Immersion_style" = "7" ]; then
        echo -e "- 已选择不在指定应用\n$List里隐藏状态栏"
        adb2 -c settings put global policy_control immersive.status=apps,-$package
    elif [ "$Immersion_style" = "8" ]; then
        echo -e "- 已选择不在指定应用\n$List里隐藏虚拟按键"
        adb2 -c settings put global policy_control immersive.navigation=apps,-$package
    elif [ "$Immersion_style" = "9" ]; then
        echo -e "- 已选择不在指定应用\n$List里隐藏状态栏和虚拟按键"
        adb2 -c settings put global policy_control immersive.full=apps,-$package
    elif [ "$Immersion_style" = "10" ]; then
        echo "- 已恢复状态栏"
        adb2 -c settings put global policy_control immersive.status=null
    elif [ "$Immersion_style" = "11" ]; then
        echo "- 已恢复虚拟键"
        adb2 -c settings put global policy_control immersive.navigation=null
    else
        echo "- 已全部恢复默认"
        adb2 -c settings put global policy_control null
    fi
