#本脚本由　by Han | 情非得已c，编写
#应用于搞机助手上


BootAnimation_Screen1() {
    by_name=`find /dev/block -name 'by-name'|head -n 1`
    splash=$by_name/splash
    #logo=$by_name/logo
    lu=/data/backup/gjzs.online
    lu2=$lu/splash.img
    lu3=$PeiZhi_File/BootAnimation_Screen1
    Han=false
    [[ ! -d $lu3 ]] && mkdir -p $lu3
    
    
    lu4=$lu3/"$BootAnimation_Screen1"_splash.img
    if [[ $Default == 1 ]]; then
        echo "您选择了恢复默认"
        echo "即将恢复默认第一屏动画，请骚等！！！"
        dd if=$lu2 of=$splash && rm -rf $lu2 && rmdir $lu &>/dev/null && CQ
        [[ ! -f $lu2 ]] && echo "已恢复默认"
        abort
    fi
        if [[ ! -f $lu2 ]]; then
            echo "正在备份splash第一屏中…………"
            [[ ! -d $lu ]] && mkdir -p $lu
            [[ ! -f $lu2 ]] && dd if=$splash of=$lu2 && echo "已自动备份splash.img文件"
            echo "备份路径：$lu2"
        else
            [[ -f $lu2 ]] && echo "splash.img备份已存在"
        fi
        echo "------------------------------------------------"
    
   
    echo -e "您当前选择了$BootAnimation_Screen1第一屏动画"
    eval "$BootAnimation_Screen1=1"
    Download "$@"
    [[ $? -ne 0 ]] && abort "下载文件出错❌"
    
        lu6=`ls -l $lu3 | egrep -c "^-"`
        if [[ $lu6 != $6 ]]; then
            echo "正在解压配置文件……"
            rm -rf $lu3/* &>/dev/null
            unzip -oq "$Download_File" -d $lu3
            sleep 3
        fi
            echo "开始刷入$BootAnimation_Screen1第一屏…………"
            dd if=$lu4 of=$splash
            echo "刷入完成，重启即可见证奇迹！"
            sleep 2
}


. $Load BootAnimation_Screen1
$Han && CQ