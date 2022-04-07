if [[ `settings get global show_hidden_icon_apps_enabled` = 1 ]]; then
    settings put global show_hidden_icon_apps_enabled 0
else
    settings put global show_hidden_icon_apps_enabled 1
fi
