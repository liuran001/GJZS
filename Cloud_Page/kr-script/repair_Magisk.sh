#本脚本由　by Han | 情非得已c，编写
#应用于搞机助手上


export BBBIN=$Script_Dir/busybox
unzip -o "$3" lib/x86/libbusybox.so lib/armeabi-v7a/libbusybox.so -d $Script_Dir &>/dev/null
chmod -R 755 $Script_Dir/lib
mv -f $Script_Dir/lib/x86/libbusybox.so $BBBIN
$BBBIN >/dev/null 2>&1 || mv -f $Script_Dir/lib/armeabi-v7a/libbusybox.so $BBBIN
rm -rf $Script_Dir/lib

export INSTALLER=$Script_Dir/install
mkdir -p $INSTALLER
unzip -o "$3" "assets/*" "lib/*" "META-INF/com/google/*" -x "lib/*/libbusybox.so" -d $INSTALLER &>/dev/null


# Magisk Flash Script (updater-script)
OUTFD=$2
APK="$3"
COMMONDIR=$INSTALLER/assets
CHROMEDIR=$INSTALLER/assets/chromeos

if [ ! -f $COMMONDIR/util_functions.sh ]; then
  echo "! 提取文件失败"
  exit 1
fi

# Load utility functions
. $COMMONDIR/util_functions.sh

check_data

# Detect version and architecture
api_level_arch_detect

[ $API -lt 17 ] && abort "! Magisk只支持Android 4.2及以上"

ui_print "- 设备架构：$ARCH"

BINDIR=$INSTALLER/lib/$ARCH32
[ ! -d "$BINDIR" ] && BINDIR=$INSTALLER/lib/armeabi-v7a
cd $BINDIR
for file in lib*.so; do mv -f "$file" "${file:3:${#file}-6}"; done
chmod -R 755 $CHROMEDIR $BINDIR


# Copy required files
APK2=$MAGISKBIN/magisk.apk

rm -rf $MAGISKBIN 2>/dev/null
mkdir -p $MAGISKBIN 2>/dev/null
cp -af $BINDIR/. $COMMONDIR/. $BBBIN $MAGISKBIN

$IS64BIT && cp -af $MAGISKBIN/magisk64 $MAGISKBIN/magisk || cp -f $MAGISKBIN/magisk32 $MAGISKBIN/magisk
cp -f $APK $APK2
chmod -R 755 $MAGISKBIN
#rm -rf "$Script_Dir"
