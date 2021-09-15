#!/data/data/com.termux/files/usr/bin/bash
#本脚本由　by Han | 情非得已c，编写
#应用于搞机助手上


export PREFIX=$Termux/usr
export HOME=$Termux/home
export TBIN=$PREFIX/bin
export BROTLI=$TBIN/brotli
export PYTHON=$TBIN/python
export BINWALK=$TBIN/binwalk
export UBUNTU=$TBIN/ubuntu
export BASH=$TBIN/bash
export SHELL=$BASH
export AM=$TBIN/am
export TMPDIR=$PREFIX/tmp
export jian=$TMPDIR/$Package_name.sh


Termux_UID() {
    local UID2=
    UID2=`pm list packages -U com.termux | cut -d : -f 3`
    [[ -z $UID2 ]] && UID2=`busybox ls -n $BASH | egrep -wo ' 10... ' | tr -d ' '`
        case $UID2 in
        10*)
            echo "- 已识别到Termux UID为：$UID2"
            User_Group=$UID2
        ;;
        
        *)
            abort "！未知的UID：$UID2"
        ;;
        esac
}

INSTALL() {
    case "$2" in
        setup-storage | DNA | update)
        echo "- 开始给Termux $1"
    ;;
    
    *)
        echo "- 未检测到Termux安装了$1，开始给Termux安装$1"
    ;;
    esac
        sleep 1
        Termux_UID

cat <<Han >$jian
#!$BASH

echo
echo "- Welcome to Termux"
echo
echo "- 请等待Termux安装完成后再操作"
sleep 2
$Content
echo "\$?" >"$TMPDIR/Status.log"
rm -f $jian
echo "- 执行完成，请返回到搞机助手"
sleep 3
Han

    chown $User_Group:$User_Group $TMPDIR/*
    chmod 755 $jian
    sleep 2
    echo "- 开始给Termux安装$1，请确保网络正常"
    echo "- 查看Termux是否在后台运行"
    error "！温馨提示：如果未跳转到Termux页面，请下拉通知栏点击Termux进入Termux应用里"
    sleep 2
    pidof com.termux &>/dev/null
    if [[ $? = 0 ]]; then
        echo "- 已在运行中"
        sleep 3
    else
        echo "- 正在打开Termux"
        sleep 1
        $AM start -n com.termux/com.termux.app.TermuxActivity >/dev/null
        sleep 3
        pidof com.termux &>/dev/null || abort "！打开Termux应用失败，请手动打开"
    fi
        $AM startservice \
        -n com.termux/com.termux.app.TermuxService \
        -a com.termux.service_execute \
        -d com.termux.file:$jian \
        -e com.termux.execute.background true >/dev/null
        echo "- 等待Termux安装完成……"
        while [[ -f $jian ]]; do :; done
            echo "- 执行完毕，返回状态码=`cat $TMPDIR/Status.log`"
            case "$2" in
                python)
                    $PYTHON --version || abort "！Termux安装$1出错了"
                ;;
                brotli)
                    $BROTLI -V &>/dev/null || abort "！Termux安装$1出错了"
                ;;
                binwalk)
                    $BINWALK --help &>/dev/null || abort "！Termux安装$1出错了"
                ;;
                protobuf)
                    $PYTHON --version &>/dev/null && ls $PREFIX/lib/python*/site-packages/protobuf-* &>/dev/null || abort "！Termux安装$1出错了"
                ;;
            esac
}

Check() {
    C=0
    case "$1" in
        setup-storage | DNA | update)
        :
    ;;
    
    *)
        echo "- 检测$1运行环境"
    ;;
    esac
    
    az=$1
    case $1 in
        python)
            Content="pkg install python -y"
            $PYTHON --version &>/dev/null && C=1
        ;;
        
        brotli)
            $BROTLI -V &>/dev/null && C=1
            Content="pkg install brotli -y"
        ;;
        
        binwalk)
            [[ -f $BINWALK ]] && C=1 || cp -f "$Download_File" "$TMPDIR/binwalk-$version.zip"
Content="
unzip -o \"$TMPDIR/binwalk-$version.zip\" -d \"$TMPDIR\"
cd \"$TMPDIR/binwalk-$version\"
python setup.py install
sleep 2
echo "安装完成"
"
        ;;
        
        protobuf)
Content="
pkg install python -y
python -m pip install --upgrade pip
python -m pip install protobuf
"
            $PYTHON --version &>/dev/null && ls $PREFIX/lib/python*/site-packages/protobuf-* &>/dev/null && C=1
            az="python和pip依赖组件$1"
        ;;
        update)
            az="更新可用软件包列表和已安装的软件包"
Content='
apt update
apt upgrade -y
'
        ;;
        
        DNA)
        # [[ -f $HOME/ubuntu/root/DNA/run.py ]] && C=1 || echo "- 已安装了DNA"
        az='安装DNA'
Content='
abort() {
    echo -e "\e[1;31m $@ \e[0m"
    echo 1 >$TMPDIR/Status.log
    sleep 3
    exit 1
}


echo "- 为Termux申请读写内部储存读写权限，已授权请输入y，不做任何操作"
termux-setup-storage
echo "- 安装一些依赖软件包"
pkg install git tar proot wget -y || abort "！安装软件包失败，请先更新一下更新可用软件包列表和已安装的软件包"
read -re -p "- 是否清理$HOME/ubuntu安装目录防止报错，y为清理：
" c
case $c in
    y|Y)
        rm -rf ~/ubuntu
    ;;
    
    *)
        echo "- 未选择清理$HOME/ubuntu安装目录"
    ;;
esac
        cd $TMPDIR
        echo "- 下载ubuntu.tar.xz及安装脚本"
        wget https://gitee.com/sharpeter/proot-ubuntu/raw/master/install_ubuntu.sh
        bash install_ubuntu.sh
        cd ~


cat <<Han >$HOME/ubuntu/tmp/Han.GJZS-ubuntu.sh
rm -f /tmp/Han.GJZS-ubuntu.sh
echo "- 更新ubuntu可用软件包列表和已安装的软件包"
sudo apt update && sudo apt upgrade -y
echo "- 安装一些依赖软件包"
sudo apt install git cpio aria2 brotli android-sdk-libsparse-utils openjdk-11-jre p7zip-full -y
echo "- 下载安装DNA"
git clone https://gitee.com/sharpeter/DNA.git --depth 1
cd DNA && python3 run.py
Han


echo "- 启动ubuntu"
ubuntu bash /tmp/Han.GJZS-ubuntu.sh
'
        ;;
        
        "DNA -run")
            Content='ubuntu'
        ;;
        
        setup-storage)
            Content='termux-setup-storage'
            az='申请读写内部储存读写权限'
        ;;
    esac
    
    
    if [[ $C -eq 0 ]]; then
        INSTALL "$az" "$1"
    fi
}

end() {
    echo "- 解包完成文件输出路径：$output_Dir"
    echo "- 查看转换后的文件变化"
    echo
    ls -lh
}
