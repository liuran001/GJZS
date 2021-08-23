#本脚本由　by Han | 情非得已c，编写
#应用于搞机助手上


Clean_install

find /system /vendor -name WCNSS_qcom_cfg.ini | while read i; do
    [[ -L "$i" ]] && continue
    if [[ -f "$i" ]]; then
        dir=`dirname $Module/$i`
        file="$Module/$i"
        mkdir -p "$dir"
        cp -af "$i" "$file"
        sed -i '/gChannelBondingMode24GHz=/d;/gChannelBondingMode5GHz=/d;/gForce1x1Exception=/d;s/^END$/gChannelBondingMode24GHz=1\ngChannelBondingMode5GHz=1\ngForce1x1Exception=0\nEND/g' "$file"
    fi
done

    if [[ -d $Module ]]; then
        if [[ $Module/vendor ]]; then
            mkdir -p $Module/system
            mv -f $Module/vendor $Module/system/vendor
        fi
    else
        abort "- 安装失败！在您的设备上未找到WCNSS_qcom_cfg.ini文件"
    fi


module_prop
[[ -f $Module_XinXi ]] && ui_print "- $name模块安装完成" || abort "！$name模块安装失败"
exit 0
