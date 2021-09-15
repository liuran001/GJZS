#本脚本由　by Han | 情非得已c，编写
#应用于搞机助手上


Option=`dumpsys deviceidle whitelist | grep 'user,' | sed -r 's/user,(.*),.*/\1/g'`
print_apk_list
