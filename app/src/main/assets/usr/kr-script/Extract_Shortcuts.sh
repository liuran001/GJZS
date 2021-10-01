#本脚本由　by by 依心所言，编写
#由　by：　　　情非得已c． | 情非得已c，应用于搞机助手上


ss="/data/system_ce/0/shortcut_service/shortcuts.xml"

case "$Option" in
Customize)
ff="$TMPDIR/shortcuts.sh"
cp -f $ss $ff

echo "- 开始查找$APK"
echo
#提取
grep -e "<package name=" -e "<shortcut id=" -e "<intent intent-base=" -e "<boolean name=" -e "<string name=" -e "<int name=" -e "</shortcut>" -e "</package>" $ss > $ff

#部分特殊符号处理
sed -i 's/\&quot;/\\\"/g' $ff
sed -i 's/\&amp;/\\\&/g' $ff
sed -i 's/\&lt;/\\\</g' $ff
sed -i 's/\&gt;/\\\>/g' $ff

#标题
sed -i 's/<package name=\"\(.*\)\" call-count=\".*\".*>/# \1<包名>/g' $ff

#sed -i 's/<shortcut.*activity=\"\(.*\)\".*title=\"\(.*\)\" titleid=.*>/#\2→活动:am start -n \1<标题>am start \"intent:/g' $ff
sed -i 's/<shortcut.*title=\"\([^"]*\)\" titleid=.*>/# \1<标题>am start \"intent:/g' $ff

#处理并标记
sed -i 's/<intent intent-base=\"#\(.*\);end\".*>/#\1/g' $ff
sed -i 's/<intent intent-base=\"\(.*\)\".*>/intent:\1#Intent;end<二次>/g' $ff



sed -i 's/<boolean name=\"\(.*\)\".*value="\(.*\)\".*>/;B.\1=\"\2\"/g' $ff

#局部处理 ; 和 空格
sed -i '/<string name=\"/{ s/\;/\%3B/g; s/<string name=\"\([^"]*\)\">\(.*\)<\/string>/;S.\1=\"\2\"/g; s/ /\\\ /g }' $ff

sed -i 's/<int name=\"\(.*\)\".*value="\(.*\)\".*>/;i.\1=\"\2\"/g' $ff

#处理标记
sed -i 's/<\/shortcut>/;end\"<\/shortcut>/g' $ff

#合并为一行
sed -i ':lo ; N ; $!b lo ; s/\n//g' $ff

#处理标记
sed -i 's/<\/shortcut>/\n/g' $ff
sed -i 's/<标题>/\n/g' $ff

sed -i 's/am start \"intent:\(.*\)<二次>;end\"/am start \"\1\"/g' $ff
sed -i 's/;end#Intent;end/;end/g' $ff
sed -i 's/<\/package>/\n\n/g' $ff
sed -i 's/<包名>/\n/g' $ff

#修补
sed -i 's/intent:intent:/intent:/g' $ff
sed -i 's/;end<二次>;/;/g' $ff
#sed -i 's/^# /;/g' $ff
sed -i '/# /s/\\\&/\&/g ' $ff



#如果无法运行，且参数包含特殊符号之类的，请URL转换试试
#echo " 完成了，保存在$ff "

grep -A 1 -e "$APK" $ff
rm -f $ff
;;

intent)
ff="$ee/shortcuts1.sh"
cp -f $ss $ff
echo "正在提取，请骚等……"
echo
#提取
grep -e "<package name=" -e "<shortcut id=" -e "<intent intent-base=" -e "<boolean name=" -e "<string name=" -e "<int name=" -e "</shortcut>" -e "</package>" $ss > $ff

#部分特殊符号处理
sed -i 's/\&quot;/\\\"/g' $ff
sed -i 's/\&amp;/\\\&/g' $ff
sed -i 's/\&lt;/\\\</g' $ff
sed -i 's/\&gt;/\\\>/g' $ff

#标题
sed -i 's/<package name=\"\(.*\)\" call-count=\".*\".*>/# \1<包名>/g' $ff

#sed -i 's/<shortcut.*activity=\"\(.*\)\".*title=\"\(.*\)\" titleid=.*>/#\2→活动:am start -n \1<标题>am start \"intent:/g' $ff
sed -i 's/<shortcut.*title=\"\([^"]*\)\" titleid=.*>/# \1<标题>am start \"intent:/g' $ff

#处理并标记
sed -i 's/<intent intent-base=\"#\(.*\);end\".*>/#\1/g' $ff
sed -i 's/<intent intent-base=\"\(.*\)\".*>/intent:\1#Intent;end<二次>/g' $ff



sed -i 's/<boolean name=\"\(.*\)\".*value="\(.*\)\".*>/;B.\1=\"\2\"/g' $ff

#局部处理 ; 和 空格
sed -i '/<string name=\"/{ s/\;/\%3B/g; s/<string name=\"\([^"]*\)\">\(.*\)<\/string>/;S.\1=\"\2\"/g; s/ /\\\ /g }' $ff

sed -i 's/<int name=\"\(.*\)\".*value="\(.*\)\".*>/;i.\1=\"\2\"/g' $ff

#处理标记
sed -i 's/<\/shortcut>/;end\"<\/shortcut>/g' $ff

#合并为一行
sed -i ':lo ; N ; $!b lo ; s/\n//g' $ff

#处理标记
sed -i 's/<\/shortcut>/\n/g' $ff
sed -i 's/<标题>/\n/g' $ff

sed -i 's/am start \"intent:\(.*\)<二次>;end\"/am start \"\1\"/g' $ff
sed -i 's/;end#Intent;end/;end/g' $ff
sed -i 's/<\/package>/\n\n/g' $ff
sed -i 's/<包名>/\n/g' $ff

#修补
sed -i 's/intent:intent:/intent:/g' $ff
sed -i 's/;end<二次>;/;/g' $ff



#如果无法运行，且参数包含特殊符号之类的，请URL转换试试
echo " 完成了，保存在$ff "

#grep -A 1 -e "^# 扫描" $ff
;;

Commands)
ff="$ee/shortcuts2.sh"
cp -f $ss $ff

echo "正在提取，请骚等……"
echo

#提取
grep -e "<package name=" -e "<shortcut id=" -e "<intent intent-base=" -e "<long name=" -e "<null name=" -e "<boolean name=" -e "<string name=" -e "<int name=" -e "</shortcut>" -e "</package>" $ss > $ff

#部分特殊符号处理
sed -i 's/\&quot;/\"/g' $ff
sed -i 's/\&amp;/\&/g' $ff
sed -i 's/\&lt;/\</g' $ff
sed -i 's/\&gt;/\>/g' $ff

#标题
sed -i 's/<package name=\"\(.*\)\" call-count=\".*\".*>/# \1<包名>/g' $ff

sed -i 's/<shortcut.*title=\"\(.*\)\" titleid=.*>/# \1<标题>am start/g' $ff

# 处理并标记
sed -i '/<intent intent-base/s/\;/;<分隔>;/g ' $ff

sed -i 's/;action=;/;-a android.intent.action.VIEW;/g' $ff
sed -i 's/;action=\([^;]*\);/;-a \1;/g' $ff

sed -i 's/;category=\([^;]*\);/;-c \1;/g' $ff
sed -i 's/;launchFlags=\([^;]*\);/;-f \1;/g' $ff
sed -i 's/;component=\([^;]*\);/;-n \1;/g' $ff
sed -i 's/;package=\([^;]*\);/;-p \1;/g' $ff
sed -i 's/;type=\([^;]*\);/;-t \1;/g' $ff

sed -i 's/<intent intent-base=\"#Intent;/;/g' $ff
sed -i 's/<intent intent-base=\"\(.*\)#Intent;/;<分隔>;-d <引>\1<引>;/g' $ff
sed -i 's/<intent intent-base=\"\(.*\)\".*>/;<分隔>;-a android.intent.action.VIEW -d \"\1\";<分隔>;/g' $ff



#中部
sed -i 's/<string name=\"\([^"]*\)\">\(.*\)<\/string>/;<分隔>;--es \1 <引>\2<引>/g' $ff

sed -i 's/<long name=\"\(.*\)\".*value="\(.*\)\".*>/;<分隔>;--el \1 <引>\2<引>/g' $ff
sed -i 's/<null name=\"\(.*\)\".*>/;<分隔>;--esn <引>\1<引>/g' $ff

sed -i 's/<boolean name=\"\(.*\)\".*value="\(.*\)\".*>/;<分隔>;--ez \1 <引>\2<引>/g' $ff
sed -i 's/<int name=\"\(.*\)\".*value="\(.*\)\".*>/;<分隔>;--ei \1 <引>\2<引>/g' $ff


# #处理尾部
sed -i "s/<引>/\'/g" $ff
sed -i 's/;<分隔>;end\" \/>//g' $ff
sed -i 's/;<分隔>;end\">//g' $ff
sed -i 's/;end#Intent;/;;/g' $ff



# 
sed -i 's/;S\.\([^;]*\);/\n;<_-es><\1-_>;\n/g' $ff
sed -i 's/;l\.\([^;]*\);/\n;<_-el><\1-_>;\n/g' $ff
sed -i 's/;i\.\([^;]*\);/\n;<_-ei><\1-_>;\n/g' $ff
sed -i 's/<_-\(.*\)><\(.*\)=\(.*\)-_>/;<分隔>;--\1 \2 \3;<分隔>;/g' $ff


#合并为一行
sed -i ':lo ; N ; $!b lo ; s/\n//g' $ff





#处理标记
sed -i 's/<\/shortcut>/\n/g' $ff
sed -i 's/<标题>/\n/g' $ff
sed -i 's/<\/package>/\n\n/g' $ff
sed -i 's/<包名>/\n/g' $ff

sed -i 's/;<分隔>;;<分隔>;;<分隔>;/;<分隔>;/g' $ff
sed -i 's/;<分隔>;;<分隔>;/;<分隔>;/g' $ff
sed -i 's/;<分隔>;/\ /g' $ff

#修补
sed -i "s/am start -d \'\([^']*\)\' -t/am start -a android.intent.action.VIEW -d \'\1\' -t/g" $ff
sed -i "s/am start -d \'\([^']*\)\' -f/am start -a android.intent.action.VIEW -d \'\1\' -f/g" $ff
sed -i "s/am start -d \'\([^']*\)\' -c/am start -a android.intent.action.VIEW -d \'\1\' -c/g" $ff
sed -i "s/am start -d \'\([^']*\)\' -n/am start -a android.intent.action.VIEW -d \'\1\' -n/g" $ff


#sed -i 's/am start \(.*\)-a\(.*\) -a \(.*\)/am start \1-a\2\nam start -a \3/g' $ff

echo " 完成了，保存在$ff "

#如果无法正常运行，且参数包含特殊符号之类的，请URL转换试试 或改引号。
#如果无法正常运行，且有两个 -a 参数，请删除一个试试。
;;

esac