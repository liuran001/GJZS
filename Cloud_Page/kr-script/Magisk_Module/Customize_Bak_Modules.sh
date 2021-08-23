#本脚本由　by Han | 情非得已c，编写
#应用于搞机助手上


[[ -z "$state" ]] && abort "！未选择模块"
F="$GJZS/模块备份${Time}.tgz"
rm -rf $TMPDIR/tar &>/dev/null
mkdir -p $TMPDIR/tar

cd $Modules_Dir
for i in $state; do
    cp -rf $i $TMPDIR/tar
done
    echo "- 开始备份中，请骚等﻿⊙∀⊙！"
    cd $TMPDIR/tar
    echo
    tar -czvf "$F" ./*
    echo -e "\n文件已打包至：$F"
    rm -rf $TMPDIR/tar
