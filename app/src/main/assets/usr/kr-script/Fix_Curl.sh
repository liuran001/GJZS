. $Core
rm -f $ELF1_Path/curl3
rm -f ~/cacert.pem
Curl_URL='http://159.27.81.21/curl'
if $Have_ROOT; then
    . $Core
    downloader "$ELF1_Path/curl3" "$Curl_URL/`getprop ro.product.cpu.abi`"
    downloader ~/cacert.pem "$Curl_URL/cacert.pem"
fi
[[ ! -f "$ELF1_Path/curl3" ]] && wget -O $ELF1_Path/curl3 "$Curl_URL/`getprop ro.product.cpu.abi`"
[[ ! -f "$ELF1_Path/curl3" ]] && wget -O $ELF1_Path/curl3 "$Curl_URL/armeabi-v7a"
[[ ! -f ~/cacert.pem ]] && wget -O ~/cacert.pem "$Curl_URL/cacert.pem"
chmod +x $ELF1_Path/curl3