#!/system/bin/sh

DPI=$DPI
FORMAT=$FORMAT
OUTPATH=$OUTPATH

[[ ! $OUTPATH ]] && echo "请选择目录" && exit 1
ANI="/system/media/bootanimation.zip"
TMP="/dev/tmp/animation"
rm -rf $TMP
mkdir -p $TMP
unzip -q $ANI -d $TMP
FILES=`cat $TMP/desc.txt | sed -n 2p | cut -d ' ' -f 4`
FPS=`cat $TMP/desc.txt | sed -n 1p | cut -d ' ' -f 3`

mkdir -p ${TMP}_BAK

i=1
for PIC in `ls $TMP/$FILES`
do
    case ${#i} in
        1)
            j=0000$i
            ;;
        2)
            j=000$i
            ;;
        3)
            j=00$i
            ;;
        4)
            j=0$i
            ;;
        5)
            j=$i
            ;;
        *)
            echo 图片过多，超出一万张了
            exit 1
            ;;
    esac
    cp -f $TMP/$FILES/$PIC ${TMP}_BAK/$j.png
    i=$(( $i + 1 ))
done

source ./BootAnimation/command.sh

#清理旧文件
rm -f ${TMP}.mp4 ${TMP}_OUT.mp4 ${TMP}_OUT.gif
#打包视频
ffmpeg -r $FPS -f image2 -i ${TMP}_BAK/%5d.png ${TMP}.mp4 -y
if [[ $DPI = 原分辨率 ]]
then
    cp -f ${TMP}.mp4 ${TMP}_OUT.mp4
else
    #转换分辨率
    ffmpeg -i ${TMP}.mp4 -vf scale=$DPI ${TMP}_OUT.mp4
fi

if [[ $FORMAT = mp4 ]]
then
    cp -f ${TMP}_OUT.mp4 $OUTPATH/bootanimation_extract.mp4
else
    #转换gif
    ffmpeg -i ${TMP}_OUT.mp4 ${TMP}_OUT.gif
    cp -f ${TMP}_OUT.gif $OUTPATH/bootanimation_extract.gif
fi