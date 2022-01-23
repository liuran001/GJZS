TMPDIR=/dev/tmp
echo "此功能由People 11制作"
echo "- 开始检查"
echo "! 此功能仅显示模块内的相关操作，是否对设备有害请自行根据输出结果判定"
echo "! 仅支持检查未加密模块，加密模块请自行检查"
rm -rf "$TMPDIR"
unzip -q "$File" -d $TMPDIR
    [[ $Check_dd = 1 ]] && {
    echo "- 此模块包含dd操作的文件有"
    grep -y -r "dd if=" $TMPDIR | sed "s:/dev/tmp::"
    echo "================================================="
    }
    [[ $Check_rm = 1 ]] && {
    echo "- 此模块包含rm操作的文件有"
    grep -y -r "rm -" $TMPDIR | sed "s:/dev/tmp::"
    echo "================================================="
    }
rm -rf "$TMPDIR"
