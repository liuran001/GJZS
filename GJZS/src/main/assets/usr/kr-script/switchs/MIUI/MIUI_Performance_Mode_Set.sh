if [[ $state = 1 ]]; then
    echo "已开启MIUI隐藏的性能模式开关（有可能需要重启生效）"
    setprop persist.sys.power.default.powermode 1
else
    echo "已关闭MIUI隐藏的性能模式开关（有可能需要重启生效）"
    setprop persist.sys.power.default.powermode ''
fi