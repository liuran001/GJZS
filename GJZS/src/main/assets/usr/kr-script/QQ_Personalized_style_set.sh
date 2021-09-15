#本脚本由　by Han | 情非得已c，编写
#应用于搞机助手上


if [[ `pm list packages com.tencent.mobileqq|wc -l` = 1 ]]; then
    echo "已安装QQ开始修改……"
    pkill com.tencent.mobileqq
    am force-stop com.tencent.mobileqq
        if [[ `pm dump com.tencent.mobileqq | grep versionCode= | sed -r 's/.*versionCode=([0-9]*) .*/\1/'` -lt 1346 ]]; then
            echo "检测到安装的QQ版本低于8.2.8开始使用旧方案"
            SD=/data/media/0/?encent/MobileQQ
        else
            echo "检测到安装的QQ版本大于或等于8.2.8开始使用新方案"
            SD=/data/media/0/Android/data/com.tencent.mobileqq/?encent/MobileQQ
        fi
else
    abort "没有安装QQ，无法使用本功能！"
fi
DATA=$DATA_DIR/com.tencent.mobileqq/files

Delete_df() { rm -rf "$@"; }

rmmkch_df() {
    rm -rf "$@"
    mkdir -p "$@"
    chmod a-w "$@"
}

#1
    if $Bubble; then
        echo "已去除QQ聊天气泡"
        rmmkch_df "$DATA/bubble_info"
    else
        echo "气泡已恢复默认"
        Delete_df "$DATA/bubble_info"
    fi
    if $Drop_Expression; then
        echo "已去除聊天界面掉表情"
        rmmkch_df "$DATA/animConfig"
    else
        echo "掉表情已恢复默认"
        Delete_df "$DATA/animConfig"
    fi
#2
        if $Font; then
            echo "已去除聊天界面字体特效"
            rmmkch_df "$SD/.font_info"
        else
            echo "字体特效已恢复默认"
            Delete_df "$SD/.font_info"
        fi
        if $Expression; then
            echo "已去除QQ聊天界面输入框上面表示推介"
            rmmkch_df "$SD/.sticker_recommended_pics"
        else
            echo "表示推介已恢复默认"
            Delete_df "$SD/.sticker_recommended_pics"
        fi
        if $Head_Pendant; then
            echo "已去除头像挂件"
            rmmkch_df "$SD/.pendant"
        else
            echo "头像挂件已恢复默认"
            Delete_df "$SD/.pendant"
        fi
    
        echo "已修改完毕，请打开QQ即可"
        sleep 3