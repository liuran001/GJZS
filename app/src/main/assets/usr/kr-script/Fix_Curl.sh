rm -f $ELF1_Path/curl3
wget --no-check-certificate -nv -O $ELF1_Path/curl3 "https://file.qqcn.xyz/GJZS/Other/Curl/`getprop ro.product.cpu.abi`"
rm -f ~/cacert.pem
wget --no-check-certificate -nv -O ~/cacert.pem "https://file.qqcn.xyz/GJZS/Other/Curl/cacert.pem"
chmod +x $ELF1_Path/curl3
