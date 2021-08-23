if [[ "$Magisk_lite_Version" = "" ]];then
	abort '本功能仅支持Magisk_lite用户'
fi
if [ ! -d "/data/adb/modules" ];then
	echo "未找到/data/adb/modules目录，跳过此步骤"
else
	[ ! -d "/data/adb/lite_modules" ] && mkdir /data/adb/lite_modules
	echo "已找到/data/adb/modules目录，正在移动文件"
	mv /data/adb/modules/* /data/adb/lite_modules
	echo "正在删除modules文件夹"
	rm -r /data/adb/modules
	echo "已完成操作"
fi
if [ ! -d "/data/adb/modules_update" ];then
	echo "未找到/data/adb/modules_update目录，跳过此步骤"
else
	[ ! -d "/data/adb/lite_modules_update" ] && mkdir /data/adb/lite_modules_update
	echo "已找到/data/adb/modules_update目录，正在移动文件"
	mv /data/adb/modules_update/* /data/adb/lite_modules_update
	echo "正在删除modules_update文件夹"
	rm -r /data/adb/modules_update
	echo "已完成操作"
fi
echo "---------------------"
echo "移动操作已全部完成"
echo "请稍后重启手机"
echo "请注意，此功能仅会对不规范创建目录的模块进行模块目录的转移"
echo "并不会对模块进行兼容性处理"
echo "换言之，如果模块不支持Magisk_lite，那么执行此功能也是不济于事的"
echo "---------------------"