#本脚本由　by Han | 情非得已c，编写
#应用于搞机助手上


adbsu -c rm -rf \
"data/system/gatekeeper.password.key" \
"data/system/gatekeeper.pattern.key" \
"data/system/locksettings.db" \
"data/system/locksettings.db-shm" \
"data/system/locksettings.db-wal" \
"/data/system/gesture.key" \
"/data/system/password.key" \
"/data/system/locksettings.db" &>/dev/null
