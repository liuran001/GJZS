appinfo -a | awk -F'"' '{print $1}'
#pm list package | cut -f2 -d ':'