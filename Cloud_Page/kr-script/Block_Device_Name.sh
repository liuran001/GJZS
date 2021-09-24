#本脚本由　by Han | 情非得已c，编写
#应用于搞机助手上


version=8

jian="$Data_Dir/by_name.log"
log="$Data_Dir/Block_Device_version.log"

[[ -f $log ]] && user_version=`cat $log` || user_version=0

if [[ $user_version -lt $version || ! -f $jian ]]; then
a=0
b=(`ls /dev/block/`)
    for i in ${b[@]}; do
        [[ -d /dev/block/$i ]] && unset b[$a]
        a=$((a+1))
    done

        rm -rf $jian &>/dev/null
        echo $version >$log
        AWK=`awk -where 2>/dev/null`
        BLOCKDEV=`which blockdev`
    
            find /dev/block -type l | while read o; do
                [[ -d "$o" ]] && continue
                c=`basename "$o"`
                echo ${b[@]} | grep -q "$c" && continue
                echo $c
            done | sort -u | while read Row; do
                BLOCK=`find /dev/block -name $Row | head -n 1`
                # BLOCK2=`readlink -e $BLOCK`
                    if [[ -n $AWK && -n $BLOCKDEV ]]; then   
                        size=`blockdev --getsize64 $BLOCK`
                        if [[ $size -ge 1073741824 ]]; then
                            File_Type=`awk "BEGIN{print $size/1073741824}"`G
                        elif [[ $size -ge 1048576 ]]; then
                            File_Type=`awk "BEGIN{print $size/1048576}"`MB
                        elif [[ $size -ge 1024 ]]; then
                            File_Type=`awk "BEGIN{print $size/1024}"`kb
                        elif [[ $size -le 1024 ]]; then
                            File_Type=${size}b
                        fi
                            echo "$BLOCK|$Row 「大小：$File_Type」" >>$jian
                    else
                        echo "$BLOCK|$Row" >>$jian
                    fi
            done
fi

cat $jian
