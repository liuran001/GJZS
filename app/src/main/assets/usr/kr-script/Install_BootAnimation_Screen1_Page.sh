jian=$PeiZhi_File/BootAnimation_Screen1/Customize/Configuration.log


cat <<Han
<?xml version="1.0" encoding="utf-8"?>

<group>
    <action auto-off="t2rue" interruptible="false" reload="true">
        <title>生成配置</title>
        <desc>生成自定义制作的配置文件，并查看您的设备第一屏在哪个分区，请确保您使用此功能前请确保您的设备第一屏为正常状态，否则会造成配置错误。&#x000A;注：此过程会很漫长，请耐心等待，生成一次后无需重复生成配置</desc>
        <set>. ./Install_BootAnimation_Screen1_Format.sh</set>
            <param name="IMG" title="请选择分区：" options-sh=". ./Install_BootAnimation_Screen1_Block.sh" required="true"/>
    </action>

Han

if [[ ! -f $jian ]]; then
cat <<Han
</group>

<group>
    <text>
      <slices>
        <slice size="18" color="#FFFF0000">请点击「生成配置」</slice>
      </slices>
    </text>
</group>
Han
exit 1
fi

. $jian
cat <<Han
    <action interruptible="false" >
        <title>自定义制作$IMG_Name分区里所有图片</title>
        <desc>已从$IMG_Name分区解析出$Picture张图，请前往下面这个目录查看$IMG_Name分区的所有图片并个性化修改&#x000A;路径：$GJZS/Customize_BootAnimation_Screen1</desc>
        <set>. ./Install_BootAnimation_Screen1_Brush_in.sh</set>
        <params>
            <param name="ChongQi" label="是否刷完自动重启系统" desc="选择制作并刷入时生效" type="switch" />
            <param name="Way" label="选择制作方式" options-sh="printf 'zs|制作并刷入\nz|仅制作'" required="true"/>
Han

for i in `seq $Picture`; do
cat <<Han
            <param name="bmp$i" title="${i}.bmp图片，最大不能大于${bmp_max[$i]}b/字节" type="file" suffix="bmp" editable="true" required="true" value="$GJZS/Customize_BootAnimation_Screen1/$i.bmp" />
Han
done
cat <<Han
            <param name="x" value="可输入bmp图片绝对路径，也可以使用文件选择器选择文件，&#x000A;温馨提示：可用「MT管理器」长按目录或文件 -->点属性 -->点击目录即可复制目录绝对路径，长按目录或长按名称即可复制文件绝对路径" readonly="readonly" />
        </params>
    </action>
</group>
Han
cat <<Han
<group>
    <action interruptible="false" >
        <title>自选logo分区里提取图片</title>
        <desc>从选定的logo镜像中提取出图片</desc>
        <set>. ./Install_BootAnimation_Screen1_Format2.sh</set>
        <params>
            <param name="img" type="file" suffix="img" editable="true" required="true" title="选择提取的logo镜像" desc="温馨提示：可用「MT管理器」长按目录或文件 -->点属性 -->点击目录即可复制目录绝对路径，长按目录或长按名称即可复制文件绝对路径" required="true"/>
            <param name="Pic_Dir" title="选择图片输出目录" type="folder" editable="true" required="true" desc="温馨提示：可用「MT管理器」长按目录或文件 --&gt;点属性 --&gt;点击目录即可复制目录绝对路径，长按目录或长按名称即可复制文件绝对路径" />
        </params>
    </action>
</group>

<group title="在线转换图片格式" >
    <page link="https://convertio.co/zh/jpg-bmp/">
        <title>jpg转bmp①</title>
    </page>
    <page link="https://convertio.co/zh/png-bmp/">
        <title>png转bmp</title>
    </page>
    <page link="https://www.sojson.com/image/format.html">
        <title>png/jpg转bmp②</title>
    </page>
</group>
Han