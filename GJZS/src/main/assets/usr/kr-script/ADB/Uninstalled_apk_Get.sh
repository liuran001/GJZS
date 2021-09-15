#本脚本由　by Han | 情非得已c，编写
#应用于搞机助手上


A() {
    adb2 -c pm list packages -u
    adb2 -c pm list packages -e
}

A | sort | uniq -u | cut -f2 -d ':'
