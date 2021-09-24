export SD_PATH=$({SDCARD_PATH})
export EXECUTOR_PATH=$({EXECUTOR_PATH})
export TMPDIR=$({TEMP_DIR})
export HOME=$({START_DIR})
export APP_USER_ID=$({APP_USER_ID})
export SDK=$({ANDROID_SDK})
export Package_name=$({PACKAGE_NAME})
export Version_Name=$({PACKAGE_VERSION_NAME})
export Version_code=$({PACKAGE_VERSION_CODE})
export PREFIX=$({TOOLKIT})
export Have_ROOT=$({ROOT_PERMISSION})
export ANDROID_UID=$({ANDROID_UID})
export DATA_DIR=${HOME%/${Package_name}*}
export PATH0="$PATH"
if [[ -f ~/offline ]]; then
  export Pages=$PREFIX/pages
  export ShellScript=$PREFIX/kr-script
  export PeiZhi_File=$PREFIX/Configuration_File
  export Data_Dir=$PREFIX/Data_Dir
else
export Pages=~/pages
export ShellScript=~/kr-script
export PeiZhi_File=~/Configuration_File
export Data_Dir=~/Data_Dir
fi
export ELF1_Path="$PREFIX/bin"
export ELF2_Path="$PREFIX/bin/xbin"
export ELF3_Path="$PREFIX/xbin"
export ELF4_Path="$PREFIX/busybox"
export which="$ELF1_Path/which"
export data_MD5="$ShellScript/init_all_MD5.sh"
export Load="$ShellScript/init_data.sh"
export Core="$ShellScript/Util_Functions.sh"
export PATH="${ELF1_Path}:${ELF2_Path}:${ELF3_Path}:${PATH0}:${ELF4_Path}"
export Bin_MT1="$DATA_DIR/bin.mt.plus/files/term/usr/bin"
export Bin_MT2="$DATA_DIR/bin.mt.plus/files/term/usr/lib"
export Bin_MT3="$DATA_DIR/bin.mt.plus.canary/files/term/usr/bin"
export Bin_MT4="$DATA_DIR/bin.mt.plus.canary/files/term/usr/lib"
export TMP=/data/local/tmp
export CODING=https://file.qqcn.xyz/GJZS/Cloud

[[ -f $Core ]] && . $Core

if [[ -f "$1" ]]; then
    cd "$ShellScript"
    . "$@" &
else
    echo "${1} 脚本已丢失！"
fi
wait
exit 0
