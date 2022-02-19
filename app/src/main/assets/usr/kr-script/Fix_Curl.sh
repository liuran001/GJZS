. $Core
rm -f $ELF1_Path/curl3
rm -f ~/cacert.pem
downloader "$ELF1_Path/curl3" "https://mscdnfile.qqcn.xyz/GJZS/Other/Curl/`getprop ro.product.cpu.abi`"
downloader ~/cacert.pem "https://mscdnfile.qqcn.xyz/GJZS/Other/Curl/cacert.pem"
chmod +x $ELF1_Path/curl3
