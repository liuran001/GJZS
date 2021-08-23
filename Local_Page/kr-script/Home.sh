#本脚本由　by Han | 情非得已c，编写
#应用于搞机助手上


QiTa() {
cat <<Han
<group title="其它">
    <action confirm="true" auto-off="true">
        <title>卸载搞机助手</title>
        <set>pm uninstall $Package_name</set>
    </action>
    <action>
        <title>脚本执行器</title>
        <params>
            <param name="CMD" title="输入命令点击确认即可，多行命令用键盘上的回车换行" desc="可通过which 命令、去查找命令是否存在" required="true" value-sh="cat $ShellScript/Shell2.sh" />
        </params>
        <set>. ./Shell.sh</set>
    </action>
    <text>
        <slices>
            <slice run="am force-stop $Package_name" size="15" color="#FF0366D6" u="1">完全退出</slice>
            <slice>　　　</slice>
            <slice run="am start -S $Package_name/com.projectkr.shell.SplashActivity" size="15" color="#FF0366D6" u="1">重启搞机助手</slice>
        </slices>
    </text>
</group>
Han
exit 1
}

install_KJ() {
    if [[ $1 = curl ]]; then
        lock=true
    else
        lock=false
    fi
cat <<Han
</group>

<group title="解决方法①">
    <page html="https://qqcn.lanzoui.com/iWWB4pnr9ba">
        <title>下载curl for Android NDK.zip</title>
        <desc>点击跳转蓝奏云下载curl for Android NDK.zip，下载完成后再在下面安装）</desc>
        <summary>链接：https://qqcn.lanzoui.com/iWWB4pnr9ba&#x000A;密码：没有密码</summary>
        <lock>if [[ $lock = false ]]; then echo '您的系统未缺少curl，功能暂不可用'; else echo 'unlocked'; fi</lock>
    </page>
    <action interruptible="false">
        <title>把curl for Android NDK安装到搞机助手私有目录</title>
        <desc>已下载完成后请点击此处安装curl</desc>
        <lock>if [[ $lock = false ]]; then echo '您的系统未缺少curl，功能暂不可用'; else echo 'unlocked'; fi</lock>
        <set>. ./Install_Command.sh $Package_name</set>
    </action>
Han
if $Have_ROOT; then
cat <<Han
</group>

<group title="解决方法②">
    <page html="https://qqcn.lanzoui.com/iWWB4pnr9ba">
        <title>下载curl for Android NDK.zip</title>
        <desc>点击跳转蓝奏云下载curl for Android NDK.zip，下载完成后再在下面安装</desc>
        <summary>链接：https://qqcn.lanzoui.com/iWWB4pnr9ba&#x000A;密码：没有密码</summary>
        <lock>if [[ $lock = false ]]; then echo '您的系统未缺少curl，功能暂不可用'; elif [[ -z `which magisk` ]]; then echo '未安装Magisk，功能暂不可用'; else echo 'unlocked'; fi</lock>
    </page>
    <action interruptible="false">
        <title>把curl for Android NDK.zip安装成Magisk模块</title>
        <desc>已下载完成后请点击此处安装curl for Android NDK模块，只有在有Magisk的情况下比功能才可用</desc>
        <lock>if [[ $lock = false ]]; then echo '您的系统未缺少curl，功能暂不可用'; elif [[ -z `which magisk` ]]; then echo '未安装Magisk，功能暂不可用'; else echo 'unlocked'; fi</lock>
        <set>. ./Install_Command.sh dump</set>
    </action>
</group>

<group title="解决方法③">
      <text>
          <slice size="15" color="#FF00A293">从下面方案里安装「MT管理器」，并在安装成功后，在侧边栏「工具」里点击「终端模拟器」（或者在主页右上角菜单里点击「打开终端」）一次&#x000A;&#x000A;然后等待初始化完毕即可，最后点下面的「重启搞机助手」或者手动重启一下「搞机助手」即可 &#x000A;&#x000A;以后即可正常的享受云端服务。</slice>
      </text>
      <page title="安装MT管理器" link="http://d.binmt.cc/" />
      <action interruptible="false">
          <title>其它安装方法</title>
          <set>echo -e '- 1.手动在网址里输入d.binmt.cc\n- 2.从酷安里搜索下载MT管理器，链接：https://www.coolapk.com/apk/bin.mt.plus\n- 3.从MT论坛下载：https://bbs.binmt.cc/forum-2-1.html'</set>
      </action>
</group>

<group title="解决方法④">
    <pages>
        <page link="https://github.com/helloklf/vtools/releases">
            <title>下载Scene后安装打开Scene即可</title>
            <desc>https://github.com/helloklf/vtools/releases</desc>
            <lock>if [[ $lock = true ]]; then echo 'Scene里没有curl，功能暂不可用'; else echo 'unlocked'; fi</lock>
        </page>
        <page activity="com.omarea.vtools/com.omarea.vtools.activities.ActivityStartSplash">
            <title>打开Scene</title>
            <lock>if [[ $lock = true ]]; then echo 'Scene里没有curl，功能暂不可用'; else echo 'unlocked'; fi</lock>
        </page>
    </pages>
</group>

<group title="解决方法⑤">
    <pages>
        <page link="https://f-droid.org/packages/com.termux/">
            <title>安装Termux后打开Termux即可</title>
            <desc>https://f-droid.org/packages/com.termux/</desc>
        </page>
        <page title="打开Termux" activity="com.termux/com.termux.app.TermuxActivity" />
    </pages>
</group>

<group title="解决方法⑥">
    <action>
        <title>自定义 curl 命令</title>
        <desc>如果你会linux shell可以自定义curl命令调用执行</desc>
        <param name="Custom_CMD" title="自定义curl命令，格式：文件绝对路径 &#34;\$@&#34;&#x000A;如果是动态库命令需要设置export LD_LIBRARY_PATH变量" desc="可在主页脚本执行器测试是否能执行，然后再设置！如果需要删除请留空然后点击确定，温馨提示：可用「MT管理器」长按目录或文件 -->点属性 -->点击目录即可复制目录绝对路径，长按目录或长按名称即可复制文件绝对路径" value-sh="cat $ELF1_Path/curl2"/>
        <lock>if [[ $lock = false ]]; then echo '您的系统未缺少curl，功能暂不可用'; else echo 'unlocked'; fi</lock>
        <set>. ./Custom_CMD.sh curl2</set>
    </action>
</group>
Han
else
echo '</group>'
fi

QiTa
}

YiChang() {
if [[ $Status = 0 ]]; then
    return 0
elif [[ $Status = 6 ]]; then
cat <<Han
<text>
    <title>$1未连接到互联网，连接服务器失败</title>
</text>
Han
QiTa
else
cat <<Han
    <text>
        <slice size="15" color="#FF0F9D58">$1已检测到您的系统`curl -where`命令文件存在异常，无法访问https网址，导致无法下载云端页面&#x000A;&#x000A;</slice>
    </text>
Han
install_KJ curl
fi
}

Print() {
    . "$Pages/Home.xml"
    exit 0
}

Missing() {
cat <<Han
    <text>
        <slice size="15" color="#FF0F9D58">已检测到您的系统缺少$1命令文件，连接服务器失败！</slice>
    </text>
Han
install_KJ $1
}


##
if [[ -f $Pages/Home.xml ]]; then
    unzip --help &>/dev/null && echo '1' | grep 1 | sed -n '/1/p' | md5sum &>/dev/null && Print
fi

rm -rf ~/downloader/path/*
cat <<Han
<?xml version="1.0" encoding="utf-8"?>
<resource dir="file:///android_asset/kr-script" />

<group>
    <text>
        <slice size="18" color="#FFFF0000">当前版本：$Version_Name（$Version_code）</slice>
        <slice size="18" color="#FFFF0000">&#x000A;连接服务器失败、无法加载云端页面！</slice>
    </text>
Han


if [[ -n `curl -where` ]]; then
    curl www.baidu.com &>/dev/null
    Status=$?
    YiChang ①
    
    curl 'https://www.baidu.com' &>/dev/null
    Status=$?
    YiChang ②
else
cat <<Han
    <text>
        <slice size="15" color="#FF0F9D58">已检测到您的系统缺少curl命令文件，连接服务器失败！</slice>
    </text>
Han
install_KJ curl
fi


    unzip --help &>/dev/null || Missing unzip
    if [[ $? -eq 0 ]]; then
        echo '1' | md5sum &>/dev/null || Missing md5sum
        if [[ $? -eq 0 ]]; then
            echo '1' | sed '/1/p' &>/dev/null || Missing sed
        fi
    fi

cat <<Han
</group>

<group>
    <text>
        <title>读取云端页面异常</title>
        <summary sh=". ./DEBUG.sh" />
    </text>
</group>
Han
QiTa
