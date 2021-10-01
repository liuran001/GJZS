if [[ $state = 1 ]]; then
    echo "已去除MIUI应用包管理组件更新系统应用的限制"
    setprop persist.sys.allow_sys_app_update true
else
    echo "已恢复默认"
    setprop persist.sys.allow_sys_app_update false
fi