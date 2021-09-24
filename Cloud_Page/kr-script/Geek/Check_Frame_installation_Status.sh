#本脚本由　by Han | 情非得已c，编写
#应用于搞机助手上


Modules_Dir=$Frame_Dir
mask $1

if [[ -d $Module ]]; then
    echo -e "\n已安装了「"$2"-${version}($versionCode)」框架服务"
else
    echo -e "\n未安装「"$2"」框架服务"
fi
