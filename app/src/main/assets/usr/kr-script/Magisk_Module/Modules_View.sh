#本脚本由　by Han | 情非得已c，编写
#应用于搞机助手上


for i in `find $Modules_Dir -name module.prop`; do
    cat $i | sed -e "s#^id=#模块路径：$Modules_Dir/#" -e 's/^name=/模块名称：/' -e 's/^version=/版本：/' -e 's/^versionCode=/版本号：/' -e s'/^author=/作者：/' -e 's/^description=/说明描述：/'
    echo -e "\n\n\n"
done