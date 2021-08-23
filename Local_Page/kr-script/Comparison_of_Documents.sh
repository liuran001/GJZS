#本脚本由　by Han | 情非得已c，编写
#应用于搞机助手上


unfiles() {
    rm -rf $Script_Dir
    mkdir $Script_Dir
    unzip -oq "$1" -d $Script_Dir
}


[[ ! -f "$File0" ]] && abort "！$File0 文件不存在"
[[ ! -f "$File1" ]] && abort "！$File1 文件不存在"
dir=$TMPDIR/tmp2
f=$dir/md5.log
f2=$dir/Difference.log
mkdir -p $dir
echo "- 解压原文件"
unfiles "$File0"
echo "- 开始生成md5文件"
find $Script_Dir -type f -exec md5sum {} \; >$f
echo "- 解压对比文件"
unfiles "$File1"
md5sum -c $f 2>/dev/null | grep -i FAILED >$f2

echo "- 查看改动后的文件"
echo
[[ ! -s $f2 ]] && echo "！未找到任何差异" || cat $f2 | sed -e "s#$Script_Dir##g" -e 's/: FAILED//g'
rm -rf $Script_Dir $dir
