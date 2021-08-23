#!/system/bin/sh
source ./BootAnimation/command.sh

LOG=ffmpeg.log
ffmpeg -i "$MP4" 2> $LOG
sed -n "/Video/p" $LOG | sed "s/ //g" | sed "s/,/\n/g" >> $LOG
TYPE=`sed -n "/Input/p" $LOG | sed "s/^Input #0, \(.*\), from.*/\1/g"`
TIME=`sed -n "/Duration/p" $LOG | sed "s/  Duration: //g" | cut -d "," -f 1`
HH=${TIME%%:*}
MM=${TIME:0-8:2}
SS=${TIME:0-5:2}
MS=${TIME##*.}
FPS=`sed -n "/^[0-9.]*fps/p" $LOG`
[[ $FPS ]] || FPS=未识别到fps
DPI=`sed -n "/^[0-9.]*x[0-9.]/p" $LOG | cut -d "[" -f 1`


echo "MP4_PATH='$MP4'
MP4_TYPE='$TYPE'
MP4_TIME='$TIME'
MP4_FPS='$FPS'
MP4_DPI='$DPI'
" > $LOG