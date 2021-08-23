#本脚本由　by Han | 情非得已c，编写
#应用于搞机助手上


az() {
    sh $install_MOD -Do_Not_Check $Compatible $Error "$1" 0
    echo -e "---------------------------------------------------------\n\n"
}


echo "$File_Dir" > $Data_Dir/Add_Modules.log
mask -vc
ChongQi2=$ChongQi
ChongQi=0

case $Search_Dir in
    0)
        echo "- 已选择不搜索子目录模块"
        ls "$File_Dir"/*.zip &>/dev/null
        [[ $? -ne 0 ]] && abort "！$File_Dir目录里未找到zip文件模块"
        
        ls "$File_Dir"/*.zip | while read line; do
            az "$line"
        done
    ;;
    
    1)
        echo "- 已选择搜索子目录模块"
        o=`find ${File_Dir} -name *.zip`
        [[ -z $o ]] && abort "！$File_Dir目录和子目录下未找到zip文件模块"
        
        for i in `find ${File_Dir} -name '*.zip'`; do
            az "$i"
        done
    ;;
esac

    ChongQi=$ChongQi2
    CQ