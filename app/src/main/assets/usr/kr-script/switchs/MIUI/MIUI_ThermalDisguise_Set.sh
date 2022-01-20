# https://github.com/helloklf/vtools/blob/master/app/src/main/java/com/omarea/library/shell/ThermalDisguise.kt

boardSensorTemp="/sys/class/thermal/thermal_message/board_sensor_temp"
migtMaxFreq="/sys/module/migt/parameters/glk_maxfreq"
gameServiceApp="com.xiaomi.gamecenter.sdk.service"
gameService="com.xiaomi.gamecenter.sdk.service/.PidService"
vtoolsStorage="vtools.thermal.disguise"
Brand=`getprop ro.product.brand`
CPU=`getprop ro.board.platform`
[[ $Brand != Xiaomi || $CPU != lahaina ]] && echo '! 仅支持处理器为骁龙888的小米设备' && exit 1

if [[ `getprop $vtoolsStorage` = 1 ]]; then
    chmod 644 $boardSensorTemp
    chmod 644 $migtMaxFreq
    pm enable $gameService
    setprop $vtoolsStorage 0
    exit 0
else
    chmod 644 $boardSensorTemp
    echo 36500 > $boardSensorTemp
    chmod 000 $boardSensorTemp
    chmod 644 $migtMaxFreq
    echo 0 0 0 > $migtMaxFreq
    chmod 644 $migtMaxFreq
    pm disable $gameService
    pm clear $gameServiceApp
    setprop $vtoolsStorage 1
    exit 0
fi

exit 1