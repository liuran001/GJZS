#!/system/bin/sh
FILE="/data/adb/bootanimation_make"
FFMPEG="$PREFIX/ffmpeg"
FFMPEGMD5="6151938ef180f016d16332d8955c2816"
mkdir -p $FILE
if [[ ! -f $FFMPEG ]]
then
	echo "--联网下载ffmpeg，稍等"
	curl -o ${FFMPEG} -L "https://pan-yz.chaoxing.com/download/downloadfile?fleid=635136135332622336&puid=175627921"
fi

md5sum $FFMPEG | grep $FFMPEGMD5 > /dev/null
[[ $? -eq 0 ]] || (echo "ffmpeg下载出现问题，返回重新下载" && rm -f $FFMPEG)

chmod 777 $FFMPEG
alias ffmpeg=$FFMPEG