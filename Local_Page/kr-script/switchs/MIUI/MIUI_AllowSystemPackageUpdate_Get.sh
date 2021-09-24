if [[ `getprop persist.sys.allow_sys_app_update` = true ]]; then
    echo 1
else
    echo 0
fi