#本脚本由　by Han | 情非得已c，编写
#应用于搞机助手上


case $Layout in
    0)
        settings put secure sysui_nav_bar null
    ;;
    
    1)
        echo "您选择了布局一：返回 | 主页 | 后台（菜单），即将修改"
        settings put secure sysui_nav_bar "space,back;home;recent,space"
    ;;
    
    2)
        echo "您选择了布局二：后台（菜单） | 主页 | 返回，即将修改"
        settings put secure sysui_nav_bar "space,recent;home;back,space"
    ;;
    
    3)
        settings delete secure sysui_nav_bar
    ;;
esac
sleep 2