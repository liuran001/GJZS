#本脚本由　by Han | 情非得已c，编写
#应用于搞机助手上


[[ -f $Load ]] && . $Load EdXposed; echo "已上传的版本：$List"

Modules_Dir=$Frame_Dir
if [[ -d $Modules_Dir/riru_edxposed ]]; then
    mask riru_edxposed
    name=`grep_prop name $Module_XinXi`
    echo -e "\n已安装${name}-${version}"
elif [[ -d $Modules_Dir/riru_edxposed_sandhook ]]; then
    mask riru_edxposed_sandhook
    name=`grep_prop name $Module_XinXi`
    echo -e "\n已安装${name}-${version}"
else
    [[ ! -d $Modules_Dir/riru_edxposed ]] && echo -e "\n未安装Riru - EdXposed-YAHFA"
    [[ ! -d $Modules_Dir/riru_edxposed_sandhook ]] && echo "未安装Riru - EdXposed-SandHook"
fi