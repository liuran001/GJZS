#本脚本由　by Han | 情非得已c，编写
#应用于搞机助手上


[[ -z "$Custom_CMD" ]] && rm -f "$ELF1_Path/$1" && exit 0
echo "$Custom_CMD" >"$ELF1_Path/$1"
set_perm "$ELF1_Path/$1" $APP_USER_ID $APP_USER_ID 700
