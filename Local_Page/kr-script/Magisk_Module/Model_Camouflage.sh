#本脚本由　by Han | 情非得已c，编写
#应用于搞机助手上


mask -vc
mask $1
data=`date '+%F'`
model2=`getprop ro.product.model`
device2=`getprop ro.product.device`
brand2=`getprop ro.product.brand`
version2=`getprop ro.build.version.incremental`


JiXing() {
echo -e "已选择伪装成$1\n"
cat <<Han >$Module/system.prop
ro.product.model=$1
ro.product.brand=$3
ro.product.name=$2
ro.product.device=$2
ro.product.manufacturer=$3
Han

printf "id=Model_Camouflage
name=机型伪装成：$1
version=$Time
versionCode=2
author=by：Han | 情非得已c
description=已伪装手机型号为：$1" >$Module_XinXi
}

prop() {
cat <<Han >$Module/system.prop
ro.product.brand=${brand:=$brand2}
ro.product.manufacturer=${brand:=$brand2}
ro.product.model=${model:=$model2}
ro.product.name=${device:=$device2}
ro.product.device=${device:=$device2}
ro.build.version.incremental=${version:=$version2}
Han
}

module_prop() {
cat <<Han >$Module_XinXi
id=Model_Camouflage
name=机型伪装成：${model:=$model2}
version=$Time
versionCode=1
author=by：Han | 情非得已c
description=已自定义伪装手机型号为：$model、品牌为：$brand、设备代号为：$device、版本号为：$version
Han
}

[[ ! -d $Module ]] && mkdir -p $Module

case $Device in
    venus)
        JiXing "M2011K2C" venus Xiaomi
    ;;
    
    draco)
        JiXing "MIX Alpha" draco Xiaomi
    ;;
    
    sirius)
        JiXing "MI 8 SE" sirius Xiaomi
    ;;
    
    picasso)
        JiXing "Redmi K30 5G" picasso Xiaomi
    ;;
    
    cas)
    JiXing "M2007J1SC" cas Xiaomi
    ;;
    
    cmi)
    JiXing "Mi 10 Pro" cmi Xiaomi
    ;;
    
    umi)
    JiXing "Mi 10" umi Xiaomi
    ;;
    
    Customize)
    prop >$Module/system.prop
    module_prop >$Module_XinXi
    ;;
esac

    [[ -f $Module/system.prop ]] && echo "「机型伪装」模块创建完成，模块将在下次重启时生效" && CQ
