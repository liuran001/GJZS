#本脚本由　by Han | 情非得已c，编写
#应用于搞机助手上


pm list package -s | cut -f2 -d ':' | sed '/^android$/d; /^com.android.systemui$/d; /^com.android.settings$/d'
[[ -f "$Data_Dir/Freezing_system_applist.log" ]] && cat "$Data_Dir/Freezing_system_applist.log"
