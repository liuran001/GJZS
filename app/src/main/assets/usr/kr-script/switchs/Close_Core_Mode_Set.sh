#本脚本由　by Han | 情非得已c，编写
#应用于搞机助手上


if check_ab_device; then
   File=/data/cache/.disable_magisk
else
   File=/cache/.disable_magisk
fi
   if [[ $state -eq 1 ]]; then
      touch $File
   else
      [[ -f $File ]] && rm $File
   fi

ZR=`grep_prop ro.build.version.sdk /system/build.prop`
if [[ -z $ZR ]]; then
   Mount_system
   echo "ro.build.version.sdk=$SDK" >>$system/build.prop
   Unload
fi
