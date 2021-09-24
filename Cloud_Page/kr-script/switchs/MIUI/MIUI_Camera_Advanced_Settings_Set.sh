#本脚本由　by Han | 情非得已c，编写
#应用于搞机助手上


jian5=$SDdir/DCIM/Camera/lab_options_visible
lu=`dirname $jian5`

[[ ! -d $lu ]] && mkdir -p $lu
if [ $state == 1 ];then
    touch $jian5 && chattr +i $jian5 && echo "已打开MIUI相机设置里隐藏的高级设置功能"
else
    [[ -f $jian5 ]] && chattr -i $jian5 && rm -rf $jian5 && echo "已恢复默认"
fi
    am force-stop com.android.camera
    sleep 1.2
