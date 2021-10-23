sqlite3 "/data/adb/lspd/config/modules_config.db" .dump | grep "INSERT INTO modules VALUES" | awk -F "'"  '{print $2}'
