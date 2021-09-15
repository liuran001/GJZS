#本脚本由　by Han | 情非得已c，编写
#应用于搞机助手上


kill -1 `pgrep -f "$@"`
rm -f $ShellScript/cache/$(echo -n ". \"\$ShellScript/exit.sh\" "$@"" | md5sum | sed 's/ .*//g').sh
