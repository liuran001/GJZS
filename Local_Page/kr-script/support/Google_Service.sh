#本脚本由　by Han | 情非得已c，编写
#应用于搞机助手上

Check() {
    Service=`pm list packages com.google.android.gms`
    if [[ -n $Service ]]; then
        return 1
    fi
        Service=`pm list packages -d com.google.android.gms`
        if [[ -n $Service ]]; then
            return 1
        fi
}
Check
echo $?
