#!/system/bin/sh
SERVICE="/data/adb/service.d/bootanimation_make"
echo '#!/system/bin/sh
MAKE_PATH="/data/adb/bootanimation_make"
rm -rf ${MAKE_PATH}
rm -f $0
' > $SERVICE
chmod 777 $SERVICE
source ffmpeg.log

#每秒分解的帧数
FPS="$FPS"
#图片质量
QC="$QC"
#图片格式
FORM="$FORM"
#预览动画时长
TIME="$TIME"
#是否等待开机动画结束
WAIT="$WAIT"
#是否铺满整屏
DPI="$DPI"
#视频选取
MP4="$MP4_PATH"
MAKE="$MAKE"
MAKEPATH="$MAKEPATH"
FIRST_TIME="$FIRST_TIME"
LAST_TIME="$LAST_TIME"
#水印
WATERMARK=$WATERMARK
FONT=$FONT

[[ $USER_DPI2 ]] && DPI="${USER_DPI2%% *}x${USER_DPI2##* }"

#模块目录
MODPATH="/data/adb/modules"
[[ $MP4 ]] || (echo "未选取视频" && exit 1)
[[ $MAKEPATH ]] && ([[ ! -d $MAKEPATH ]] && echo "--检测到当前仅制作目录不存在，请重新选择" && exit 1)

#准备部分必须命令
source ./BootAnimation/command.sh

#分解后的图片存储目录
FILE="$FILE"
OUT_FILE="$FILE/animation"
OUT_FILE_PART="$OUT_FILE/part0"

#清理存储目录图片
[[ -d $OUT_FILE ]] && rm -rf $OUT_FILE
mkdir -p $OUT_FILE_PART

if [[ $MP4_TYPE != gif ]]
then
#剪切时间计算
FHH="${FIRST_TIME%%:*}"
FMM="${FIRST_TIME:0-8:2}"
FSS="${FIRST_TIME:0-5:2}"
FMS="${FIRST_TIME##*.}"
LHH="${LAST_TIME%%:*}"
LMM="${LAST_TIME:0-8:2}"
LSS="${LAST_TIME:0-5:2}"
LMS="${LAST_TIME##*.}"
#秒计算
SS="$(( $LHH * 3600 + $LMM * 60 + $LSS - $FHH * 3600 - $FMM * 60 - $FSS ))"
#毫秒计算
if [[ $LMS -ge $FMS ]]
then
    SUB_MS="00$(( $LMS - $FMS ))"
    MS="${SUB_MS:0-2:2}"
else
    SS="$(( $SS - 1 ))"
    SUB_MS="$(( $LMS + 1000 - $FMS ))"
    MS="${SUB_MS:0:2}"
fi
CUT_TIME="-ss $FIRST_TIME -t ${SS}.${MS}"
CUT_TIME2="$CUT_TIME -accurate_seek"
fi


#识别视频分辨率
#STR=`file $OUT_FILE_PART/00001.png | sed 's/ //g' | cut -d ',' -f 2`
#PW=${STR%x*}
#PH=${STR#*x}
PW="${MP4_DPI%x*}"
PH="${MP4_DPI#*x}"

#识别手机分辨率
#STR=`wm size | sed 's/.*: //'`
#U=$(echo $STR | sed 's/ .*//g')
#UW=${U%x*}
#UH=${U#*x}
STR="$USER_DPI"
UW="${STR%x*}"
UH="${STR#*x}"

VOLUME="$VOLUME"
VOLUME_2="-af volume=${VOLUME}dB"
#VOLUME_2="-filter：'volume =${VOLUME}dB'"
#提取音频
if [[ $MP3 -eq 1 ]] && [[ $MP4_TYPE != gif ]]
then
    MP3_NUM="$MP3_NUM"
    MP3="$FILE/out.mp3"
    MP3_2="$MP3"
    ffmpeg -i "$MP4" $CUT_TIME $VOLUME_2 -q:a 0 -map a "$MP3" -y
    echo "ffmpeg -i "$MP4" $CUT_TIME $VOLUME_2 -q:a 0 -map a "$MP3" -y"
    for i in `seq 2 ${MP3_NUM}`
    do
        MP3_2="${MP3_2}|${MP3}"
    done
    ffmpeg -i "concat:${MP3_2}" -acodec copy "$FILE/bootaudio.mp3" -y
    echo "ffmpeg -i "concat:${MP3_2}" -acodec copy "$FILE/bootaudio.mp3" -y"
fi

dpi(){
    #分辨率设置 当高度拉满后图片宽度小于手机时
    if [ $(( $UH * $PW / $PH )) -lt $UW ]
    then
        W="$(( $UH * $PW / $PH ))"
        H="$UH"
    else
        W="$UW"
        H="$(( $UW * $PH / $PW ))"
    fi
}

#分辨率设置
case $DPI in
    fill)
        #填充
        if [[ $(( $UH * $PW )) -ge $(( $PH *$UW )) ]]
        then
            H="$UH"
            W="$(( $UH * $PW / $PH ))"
        else
            H="$(( $UW * $PH / $PW ))"
            W="$UW"
        fi
        CROP=",crop=${UW}:${UH}"
    ;;
    splice)
        #拼接
        ffmpeg -i "$MP4" -i "$MP4" -i "$MP4" $CUT_TIME -filter_complex "[0:v]pad=iw:ih*3[a];[a][1:v]overlay=0:h[b];[b][2:v]overlay=0:h*2" $FILE/out.mp4 -y
        echo 'ffmpeg -i "$MP4" -i "$MP4" -i "$MP4" $CUT_TIME -filter_complex "[0:v]pad=iw:ih*3[a];[a][1:v]overlay=0:h[b];[b][2:v]overlay=0:h*2" $FILE/out.mp4 -y'
        MP4="$FILE/out.mp4"
        unset CUT_TIME2
        #分辨率设置
        PH="$(( $PH *3 ))" && dpi
    ;;
    stretch)
        #拉伸
        W="$UW"
        H="$UH"
    ;;
    *)
        #适应
        #分辨率设置 当高度拉满后图片宽度小于手机时
        dpi
    ;;
esac


#设置参数
SW=$(( ( $UW - $W ) / 2 ))
SH=$(( ( $UH - $H ) / 2 ))
COLOR="#${COLOR:0-6:6}"
[[ $FLIP ]] && FLIP=",${FLIP}"
#[[ $FLIP ]] && FLIP=",drawtext=fontfile=/storage/emulated/0/文件夹/gitee/pio/Miui-Regular.ttf:text='水印测试':x=100:y=10:fontsize=100:fontcolor=yellow:shadowy=2"
[[ $DPI == stretch ]] || [[ $DPI == fill ]] || PAD=",pad=${UW}:${UH}:${SW}:${SH}:color=${COLOR}"
VF="-vf "scale=${W}:${H}${PAD}${FLIP}${CROP}""
[[ $FPS -eq 0 ]] && FPS="${MP4_FPS%fps}"
[[ $MP4_TYPE == gif ]] || TYPE="-r $FPS -f image2"
ffmpeg ${CUT_TIME2} -i "${MP4}" ${TYPE} ${VF} -q:v ${QC} ${OUT_FILE_PART}/%5d.${FORM}
echo "ffmpeg ${CUT_TIME2} -i "${MP4}" ${TYPE} ${VF} -q:v ${QC} ${OUT_FILE_PART}/%5d.${FORM}"



[[ $WAIT -eq 0 ]] && WAIT="p" || WAIT="c"
echo -e "$UW $UH $FPS\n$WAIT $NUM 0 part0" > $OUT_FILE/desc.txt

#打包动画
cd $OUT_FILE && zip -rq -0 bootanimation.zip *
[[ $? -eq 0 ]] || echo "--打包失败，截图联系作者解决"

if [[ $MAKEPATH ]]
then
    MODFILE="$FILE/mod/system/media"
    rm -rf $FILE/mod/*
    mkdir -p $MODFILE
    mkdir -p $FILE/mod/META-INF/com/google/android
    echo '#!/sbin/sh
umask 022
ui_print() { echo "$1"; }
require_new_magisk() {
  ui_print "*******************************"
  ui_print " Please install Magisk v20.4+! "
  ui_print "*******************************"
  exit 1
}
OUTFD=$2
ZIPFILE=$3
mount /data 2>/dev/null
[ -f /data/adb/magisk/util_functions.sh ] || require_new_magisk
. /data/adb/magisk/util_functions.sh
[ $MAGISK_VER_CODE -lt 20400 ] && require_new_magisk
install_module
REPLACE="
/system/media
"
exit 0' > $FILE/mod/META-INF/com/google/android/update-binary
echo '#MAGISK' > $FILE/mod/META-INF/com/google/android/updater-script

    cp -f bootanimation.zip $MODFILE
    cp -f $FILE/bootaudio.mp3 $MODFILE
    echo -e "id=$MOD_ID\nname=${MOD_NAME}\nversion=v1\nversionCode=1.0\nauthor=${MOD_AUTHOR} & 搞机助手 & 巴啦啦魔仙女王\ndescription=${MOD_DESC}" > $FILE/mod/module.prop
    cd $FILE/mod && zip -rq -9 ${MOD_NAME}.zip *
    cp -f ${MOD_NAME}.zip ${MAKEPATH}/${MOD_NAME}.zip
    echo "--制作完成 保存文件"
    echo "--目录 ${MAKEPATH}/${MOD_NAME}.zip"
    echo "--即将跳转文件管理 稍等"
    sleep 2
    am start -n com.android.fileexplorer/.FileExplorerTabActivity -d $MAKEPATH > /dev/null 2>&1
    exit 0
fi

test_cp(){
if [[ $? -ne 0 ]]
then
    [[ $MODPATH/bootanimation ]] && rm -rf $MODPATH/bootanimation
    mkdir -p $MODPATH/bootanimation/${ANIM_PATH%/*}
    cp -f ./bootanimation.zip $MODPATH/bootanimation/$ANIM_PATH
    cp -f $FILE/bootaudio.mp3 $MODPATH/bootanimation/${ANIM_PATH%/*}
    echo -e "id=bootanimation\nname=自定义开机动画\nversion=v1\nversionCode=1.0\nauthor=by搞机助手@酷安:巴啦啦魔仙女王\ndescription=自定义开机动画第二屏和开机铃声，由搞机助手生成" > $MODPATH/bootanimation/module.prop
    echo "当前未安装开机动画模块且system未解锁或空间已满，无法生成指定的开机动画，已自动生成模块，重启生效"
    exit 1
fi
}

[[ -f $FILE/bootaudio.mp3 ]] && (cp -f $FILE/bootaudio.mp3 ${ANIM_PATH%/*} ; test_cp)
[[ -f bootanimation.zip ]] && (cp -f ./bootanimation.zip $ANIM_PATH ; test_cp)

anim(){
setprop service.bootanim.exit 0
setprop ctl.start bootanim
sleep $TIME
setprop ctl.stop bootanim
setprop service.bootanim.exit 1
}
[[ $MAKE -eq 0 ]] && anim
exit 0
