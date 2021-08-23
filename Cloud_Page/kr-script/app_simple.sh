taobao="/data/data/com.taobao.taobao"
jingdong="/data/data/com.jingdong.app.mall"
youku="/data/data/com.youku.phone"

am kill --user 0 com.tencent.tmgp.sgame

function lock_dir() {
	if [[ -e "$1" ]];
	then
		rm -rf "$1"
	fi
	mkdir -p "$1"
	chmod 500 "$1"
	chown 0:0 "$1"
}

if [[ -d $taobao ]]; then
	echo '- 处理淘宝...'
	#lock_dir ${taobao}/files/storage/hotpatch
	#lock_dir ${taobao}/files/storage/com.taobao.maindex
	rm -rf ${taobao}/files/storage
	rm -rf ${taobao}/files/bundleBaseline
	#lock_dir ${taobao}/files/bundleBaseline
else
	echo '- ERROR: 淘宝未安装！'
fi

if [[ -d $jingdong ]]; then
	echo '- 处理京东...'
	lock_dir ${jingdong}/files/start_image
	lock_dir ${jingdong}/files/hotfix
else
	echo '- ERROR: 京东未安装！'
fi

if [[ -d $youku ]]; then
	echo '- 处理优酷...'
	#lock_dir ${youku}/files/storage/hotpatch
	rm -rf ${youku}/files/storage
	rm -rf ${youku}/files/bundleBaseline
else
	echo '- ERROR: 优酷未安装！'
fi

echo -e '- 操作已完成，如果出现问题，可通过卸载应用并重新安装来解决！\n'
