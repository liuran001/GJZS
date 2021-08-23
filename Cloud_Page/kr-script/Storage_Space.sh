#本脚本由　by Han | 情非得已c，编写
#应用于搞机助手上


a=
[[ $All -eq 1 ]] && a=a
C="df -$a$Unit"
[[ "$C" = "df -" ]] && C=df
eval $C
