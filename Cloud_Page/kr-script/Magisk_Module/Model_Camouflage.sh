#感谢People11


mask -vc
mask $1
data=`date '+%F'`
model2=`getprop ro.product.model`
device2=`getprop ro.product.device`
brand2=`getprop ro.product.brand`
version2=`getprop ro.build.version.incremental`


JiXing() {
echo -e "已选择伪装成$2"
cat <<Han >$Module/system.prop
ro.product.model=$1
ro.product.brand=$3
ro.product.name=$2
ro.product.device=$2
ro.product.board=$2
ro.product.manufacturer=$3
Han

printf "id=Model_Camouflage
name=机型伪装
version=$Time
versionCode=114514
author=People11
description=伪装手机型号为：$2" >$Module_XinXi
}

prop() {
cat <<Han >$Module/system.prop
ro.product.brand=${brand:=$brand2}
ro.product.manufacturer=${brand:=$brand2}
ro.product.model=${model:=$model2}
ro.product.name=${device:=$device2}
ro.product.device=${device:=$device2}
ro.product.board=${device:=$device2}
ro.build.version.incremental=${version:=$version2}
Han
}

module_prop() {
cat <<Han >$Module_XinXi
id=Model_Camouflage
name=机型伪装
version=$Time
versionCode=114514
author=People11
description=自定义伪装手机型号：$model、 品牌：$brand、 代号：$device、 版本号：$version
Han
}

[[ ! -d $Module ]] && mkdir -p $Module

case $Device in
    MI11U)
        JiXing "M2102K1C" star Xiaomi
    ;;

    MI10S)
        JiXing "M2102J2SC" thyme Xiaomi
    ;;

    MI10P)
        JiXing "M2001J1E" cmi Xiaomi
    ;;

    MIMIXF)
        JiXing "M2011J18C" cetus Xiaomi
    ;;

    MIMIX3)
        JiXing "M1810E5A" perseus Xiaomi
    ;;

    MI6)
        JiXing "MCE16" sagit Xiaomi
    ;;

    MICC9P)
        JiXing "M1910F4E" tucana Xiaomi
    ;;

    RMIK40P)
        JiXing "M2012K11C" haydn Xiaomi
    ;;

    RMIK40G)
        JiXing "M2012K10C" ares Xiaomi
    ;;

    RMIK30S)
        JiXing "M2007J3SC" apollo Xiaomi
    ;;

    RMIK30)
        JiXing "M2006J10C" cezanne Xiaomi
    ;;

    RMIK30PC)
        JiXing "M2001J11C" lmipro Xiaomi
    ;;

    RMIK30P)
        JiXing "M2001J11C" lmi Xiaomi
    ;;

    RMIN10P)
        JiXing "M2104K10AC" chopin Xiaomi
    ;;

    HWP50P)
        JiXing "JAD-AL50" jade HUAWEI
    ;;

    HWP40PP)
        JiXing "ELS-AN10" elsa HUAWEI
    ;;

    HWP40P)
        JiXing "ELS-AN00" elsa HUAWEI
    ;;

    HWM40RS)
        JiXing "NOP-AN00" noahp HUAWEI
    ;;

    HWM40P)
        JiXing "NOH-AN00" noah HUAWEI
    ;;

    HWMX2)
        JiXing "TET-AN00" teton HUAWEI
    ;;

    HWMP11)
        JiXing "DBY-W09" HWDBY HUAWEI
    ;;

    HWMXS)
        JiXing "TAH-AN00m" tahiti HUAWEI
    ;;

    HWMX)
        JiXing "TAH-AN00" tahiti HUAWEI
    ;;

    IQ7)
        JiXing "V2049A" PD2049 vivo
    ;;

    IQN5)
        JiXing "V2055A" PD2055 vivo
    ;;

    IQ5P)
        JiXing "V2025A" PD2025 vivo
    ;;

    SHARK4P)
        JiXing "SHARK KSR-A0" kaiser Xiaomi
    ;;

    SHARK4)
        JiXing "SHARK PRS-A0" penrose Xiaomi
    ;;

    SHARK3S)
        JiXing "SHARK KLE-A0" klein Xiaomi
    ;;

    OP9P)
        JiXing "LE2120" lemonadep OnePlus
    ;;

    OP9R)
        JiXing "LE2100" lemonades OnePlus
    ;;

    OP9)
        JiXing "LE2110" lemonade OnePlus
    ;;

    OP8P)
        JiXing "IN2020" instantnoodlep OnePlus
    ;;

    OP8T)
        JiXing "KB2000" kebabt OnePlus
    ;;

    OP8)
        JiXing "IN2010" instantnoodle OnePlus
    ;;

    MZ18P)
        JiXing "M191Q" m2191 Meizu
    ;;

    MZ18)
        JiXing "M181Q" m2181 Meizu
    ;;

    MZ17P)
        JiXing "M091Q" m2091 Meizu
    ;;

    STSR2)
        JiXing "DT2002C" darwin Smartisan
    ;;

    STSR1)
        JiXing "DE106" trident Smartisan
    ;;

    STSP3)
        JiXing "DT1902A" delta Smartisan
    ;;

    STSP2S)
        JiXing "OE106" ocean Smartisan
    ;;

    STST2)
        JiXing "SM801" icesky Smartisan
    ;;

    STST1)
        JiXing "SM705" sfo Smartisan
    ;;

    APP12PM)
        JiXing "A2412" iPhone13,4 Apple
    ;;

    APPIPP129)
        JiXing "A2462" iPad13,11 Apple
    ;;

    APPIPM5)
        JiXing "A2125" iPad11,2 Apple
    ;;

    APPWS6)
        JiXing "A2376" Watch6,4 Apple
    ;;

    SAMS21U)
        JiXing "SM-G9980" p3q Samsung
    ;;

    SAMS21P)
        JiXing "SM-G9960" t2q Samsung
    ;;

    SAMS21)
        JiXing "SM-G9910" o1q Samsung
    ;;

    SAMN20U)
        JiXing "SM-N9860" c2q Samsung
    ;;

    SAMN20)
        JiXing "SM-N9810" c1q Samsung
    ;;

    SAMZF2)
        JiXing "SM-F9160" f2q Samsung
    ;;

    SAMZFL5G)
        JiXing "SM-F7070" bloomxq Samsung
    ;;

    SAMF)
        JiXing "SM-F9000" winner Samsung
    ;;

    NOKC20P)
        JiXing "TA-1388" sirius Nokia
    ;;

    GGP)
        JiXing "Pixel" sailfish Google
    ;;

    GGP2)
        JiXing "Pixel 2" walleye Google
    ;;

    GGP2XL)
        JiXing "Pixel 2 XL" taimen Google
    ;;

    GGP3)
        JiXing "Pixel 3" blueline Google
    ;;

    GGP3XL)
        JiXing "Pixel 3 XL" crosshatch Google
    ;;

    GGP3A)
        JiXing "Pixel 3a" sargo Google
    ;;

    GGP3AXL)
        JiXing "Pixel 3a XL" bonito Google
    ;;

    GGP4)
        JiXing "Pixel 4" flame Google
    ;;

    GGP4XL)
        JiXing "Pixel 4 XL" coral Google
    ;;

    GGP4A)
        JiXing "Pixel 4a" sunfish Google
    ;;

    GGP4A5G)
        JiXing "Pixel 4a (5G)" bramble Google
    ;;

    GGP5)
        JiXing "Pixel 5" redfin Google
    ;;

    GGPC)
        JiXing "Pixel C" dragon Google
    ;;

    Customize)
    prop >$Module/system.prop
    module_prop >$Module_XinXi
    ;;
esac

    [[ -f $Module/system.prop ]] && echo "「机型伪装」模块创建完成，模块将在下次重启时生效" && CQ
