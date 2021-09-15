adb root
adb2 -c rm -rf \
"data/system/gatekeeper.password.key" \
"data/system/gatekeeper.pattern.key" \
"data/system/locksettings.db" \
"data/system/locksettings.db-shm" \
"data/system/locksettings.db-wal" \
"/data/system/gesture.key" \
"/data/system/password.key" \
"/data/system/locksettings.db" &>/dev/null
