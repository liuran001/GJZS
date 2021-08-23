#本脚本由　by Han | 情非得已c，编写
#应用于搞机助手上



Clean() {
    rm -rf "$Module"
    mkdir -p `dirname $MODFILE`
}

[[ $1 = -d ]] && File="$PeiZhi_File/mute.ogg"
[[ -z "$install_Way" ]] && install_Way=Module
[[ ! -f $File ]] && abort "！已选择的"$File"文件不存在，无法安装"

log=$Data_Dir/Add_Boot_Music.log
echo "bootaudio=$bootaudio" >$log
echo "Customize_lu=$Customize_lu" >>$log
echo "install_Way=$install_Way" >>$log

if [[ $bootaudio = Customize ]]; then
    echo "- 已选择自定义路径：$Customize_lu"
    jian="$Customize_lu"
else
    echo "- 已选择路径：$bootaudio"
    jian="$bootaudio"
fi
    if [[ $install_Way = Module ]]; then
        mask -vc
        id=Add_Boot_Music
        mask $id
        if [[ $1 = -d ]]; then
            name=删除开机音乐
            version=v1
            versionCode=1
            author='by：Han | 情非得已c'
            description="删除系统的开机音乐文件"
        else
            name=添加开机音乐
            version=v1
            versionCode=1
            author='by：Han | 情非得已c'
            description="给手机添加开机音乐"
        fi
            case $jian in
                /system/*)
            :;;
                /vendor/* | /product/*)
                jian=/system/$jian
            ;;
            
            *)
                abort "！$jian路径不支持制作Magisk模块"
            ;;
            esac
    else
        case $jian in
            /system/*)
                Mount_system && jian=${jian/\/system/$system}
        ;;
        
            /vendor/*)
                Mount_vendor && jian=${jian/\/vendor/$vendor}
        ;;
        
            /product/*)
                mount -o rw,remount /product
                [[ -w /product ]] && echo "- 挂载/product读写成功" || abort "！挂载/product读写失败"
                
        ;;
        *)
            mount -o rw,remount /
        ;;
        esac
        jian2=$jian.bak
        [[ -f $jian ]] && rm -rf $jian $jian2 && echo "删除成功" || { [[ ! -f $jian ]] && echo "您手机没有开机音乐文件"; }
        exit 0
    fi
        MODFILE="$Module/$jian"


echo "- 开始安装 $name-$version($versionCode)"
echo "- 安装目录：$Module"
echo "- 模块作者：$author"
echo "- 模块描述：$description"
echo
echo "- Powered by Magisk & topjohnwu"


Clean

cat <<Han >$Module_XinXi
id=$id
name=$name
version=$version
versionCode=$versionCode
author=$author
description=$description
Han

abort() {
    error "$@"
    rm -rf "$Module"
    sleep 3
    exit 1
}

cp -f "$File" "$MODFILE"
[[ -f $MODFILE ]] && echo "- 模块创建完成，将在下次重启时生效" || abort "！$name模块创建失败"
set_perm_recursive $Module 0 0 0755 0644
CQ
