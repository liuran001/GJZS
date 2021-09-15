#本脚本由　by Han | 情非得已c，编写
#应用于搞机助手上


DaYin() { echo -e "\n-----------------------------------------------\n"; }
abort() {
    echo "$@" 1>&2
    sleep 3
    exit 1
}


[[ $# -lt 2 ]] && abort "未提供参数✘"

    if [[ ! -s $Load && ! -s $Core ]]; then
        abort "！无数据库文件无法使用此功能"
    fi
#    . $Core
    TMPDIR0="$Script_Dir"



if [[ "$1" = Magisk ]]; then
    # stock_boot.img源文件
    # new-boot.img修补后的
    # signed.img已修补后并签名的
    # Magisk Manger修补boot.img存放文件路径/data/user_de/0/com.topjohnwu.magisk/install/
    shift
    [[ ! -x /system/bin/dalvikvm ]] && abort "！/system/bin/dalvikvm命令不存在"
    [[ $1 = -ab_root || $1 = -uninstall ]] && File=$EXECUTOR_PATH
    
    Extracting_files() {
        Choice=1
        . $Load com.topjohnwu.magisk
        
        TMPDIR="$TMPDIR0"
        log=$Data_Dir/Decompress_Magisk_versionCode.log
        MAGISKBIN=$PeiZhi_File/Magisk
        APK=$MAGISKBIN/magisk.apk
        [[ -f $log ]] && user_version=`cat $log` || user_version=0
        [[ $KEEPVERITY = 1 ]] && export KEEPVERITY=true || export KEEPVERITY=false
        [[ $KEEPFORCEENCRYPT = 1 ]] && export KEEPFORCEENCRYPT=true || export KEEPFORCEENCRYPT=false
        [[ $RECOVERYMODE = 1 ]] && export RECOVERYMODE=true || export RECOVERYMODE=false
        
            if [[ $user_version -lt $versionCode || ! -f $APK ]]; then
                echo "- 开始解压zip文件"
                echo $versionCode >$log
                BBBIN=$TMPDIR/busybox
                INSTALLER=$TMPDIR/install
                COMMONDIR=$INSTALLER/assets
                CHROMEDIR=$INSTALLER/assets/chromeos
                
                rm -rf $TMPDIR
                mkdir -p $TMPDIR
                
                unzip -o "$Download_File" lib/x86/libbusybox.so lib/armeabi-v7a/libbusybox.so -d $TMPDIR &>/dev/null
                chmod -R 755 $TMPDIR/lib
                mv -f $TMPDIR/lib/x86/libbusybox.so $BBBIN
                $BBBIN >/dev/null 2>&1 || mv -f $TMPDIR/lib/armeabi-v7a/libbusybox.so $BBBIN
                rm -rf $TMPDIR/lib
                mkdir -p $INSTALLER
                unzip -o "$Download_File" "assets/*" "lib/*" "META-INF/com/google/*" -x "lib/*/libbusybox.so" -d $INSTALLER &>/dev/null
                
                if [ ! -f $COMMONDIR/util_functions.sh ]; then
                    abort "！读取文件异常，请私信我修复"
                fi
                
                sed -i -r '/^TMPDIR=\/dev\/tmp$/d' $COMMONDIR/util_functions.sh
                . $COMMONDIR/util_functions.sh
                api_level_arch_detect
                ui_print "- 设备架构：$ARCH"
                BINDIR=$INSTALLER/lib/$ARCH32
                [ ! -d "$BINDIR" ] && BINDIR=$INSTALLER/lib/armeabi-v7a
                cd $BINDIR
                for file in lib*.so; do mv -f "$file" "${file:3:${#file}-6}"; done
                chmod -R 755 $CHROMEDIR $BINDIR

                MAGISKBIN=$PeiZhi_File/Magisk
                
                rm -rf $MAGISKBIN 2>/dev/null
                mkdir -p $MAGISKBIN 2>/dev/null
                cp -af $BINDIR/. $COMMONDIR/. $BBBIN $MAGISKBIN
                $IS64BIT && cp -f $MAGISKBIN/magisk64 $MAGISKBIN/magisk || cp -f $MAGISKBIN/magisk32 $MAGISKBIN/magisk
                cp -f $Download_File $APK
                chmod -R 755 $MAGISKBIN
                rm -rf "$TMPDIR0"
            else
                echo "- 资源文件已存在不在重复解压"
            fi
                cd $MAGISKBIN
                . ./util_functions.sh
                MAGISKBIN=$PeiZhi_File/Magisk
                TMPDIR="$TMPDIR0"
    }

    boot_verify() {
        if [[ "$SDK" -ge 21 && ! -c "$1" ]]; then
            echo -n "- "
            eval $BOOTSIGNER -verify < "$1" 2>&1 && BOOTSIGNED=true
            $BOOTSIGNED && ui_print "- Boot image is signed with AVB 1.0"
        fi
    }
    
    boot_sign() {
        [[ "$1" = -sign ]] && BOOTSIGNED=true && shift
        echo "- Generate new boot image"
        flash_image "$1" "$2"
            case $? in
            1)
                abort "! 分区大小不足"
            ;;
            2)
                abort "! $1 是只读的"
            ;;
            esac
            
    }
    
    XiuBu_boot() {
        boot_verify "$1"
        SOURCEDMODE=true
        sh ./boot_patch.sh "$1" 2>/dev/null
        [[ $? -ne 0 ]] && abort -e "！不支持的boot.img镜像文件\n已被其它未知程序修补过boot，请找到原始boot.img镜像进行操作。"
        boot_sign ./new-boot.img "$2"
        ./magiskboot cleanup &>/dev/null
        rm -f ./*.img
    }

        if [[ -z "$File" ]]; then
            abort "请选择文件路径不可为空哦﻿⊙∀⊙！"
        elif [[ ! -f "$File" ]]; then
            abort "\"${File}\"文件不存在无法使用本功能！"
        fi
            Extracting_files
            BOOTSIGNED=false
            
            case $1 in
            -patched)
                patched="$GJZS/magisk_patched_$Time.img"
                XiuBu_boot "$File" "$patched"
                [[ -f "$patched" ]] && echo -e "- 完成\n\n文件输出路径：$patched"
            ;;
            
            -ab_root)
                . $ShellScript/Switch_ab_partition.sh -c
                sh $ShellScript/Block_Device_Name.sh 1>/dev/null
                GJZS=$Script_Dir
                boot=boot_$fenqu
                lu=`sed -n "s/$boot|$boot.*//p" $Data_Dir/by_name.log`
                File=$Script_Dir/$boot.img
                patched="$Script_Dir/magisk_patched.img"
                
                rm -rf $Script_Dir
                mkdir -p $Script_Dir
                echo "- 提取$boot"
                [[ ! -L $lu/$boot ]] && abort "！$boot分区不存在无法提取"
                dd if=$lu/$boot of=$File
                XiuBu_boot "$File" "$patched"
                
                echo "- 刷入$boot分区"
                flash_image "$patched" "$lu/$boot"
                rm -rf $Script_Dir
                CQ
            ;;
            
            -verify)
                shift
                echo "开始验证\"$1\"镜像是否签名"
                boot_verify "$1"
            ;;
            
            -sign)
                shift
                boot_sign -sign "$1" "$2"
                [[ -f "$2" ]] && echo -e "- 完成\n\n- 文件输出路径："$2""
            ;;
            
            -root)
                [[ -d "$TMPDIR" ]] && rm -rf $TMPDIR
                mkdir -p $TMPDIR
                patched="$TMPDIR/magisk_patched.img"
                XiuBu_boot "$File" "$patched"
                [[ -f "$patched" ]] && echo -e "- 修补boot成功已成功注入Magisk到boot.img\n\n- 开始一键ROOT……"
                    case $Phone_Status in
                        system|Recovery)
                        echo "- 正在自动重启至FASTBOOT模式"
                        adb reboot bootloader
                        ;;
                    esac
                        unset a b
                        a=`fastboot devices 2>/dev/null`
                        if [[ -n $a ]]; then
                            echo "- 已连接 ${a/fastboot/} 设备"
                        else
                            echo "- 开始等待设备连接，如果等待1分钟后还是无法连接成功，请重新插拔数据线"
                            echo "- 如果最终都无法连接成功，请检查您的OTG是否能正常的进行文件传输"
                            until [[ -n $b ]]; do
                                b=`fastboot devices 2>/dev/null`
                                [[ -n $b ]] && echo "- 等待 ${b/fastboot/} 设备连接成功"
                            done
                        fi
                            for i in $Subarea; do
                                echo "- 开始刷入$i分区……"
                                fastboot flash $i "$patched"
                            done
                            echo "- 刷写完成，即将重启……"
                            fastboot reboot
                            echo "- 一键ROOT完成，请在对方设备重启成功后，去应用/Xposed仓库下载「Magisk Manager」应用进行ROOT管理"
                            echo "- 包名：com.topjohnwu.magisk"
                            echo "- 温馨提示：由于是修补boot注入的ROOT，首次安装这个面具软件，可能需要修复运行环境，如果嫌弃在Magisk Manager里修复慢，可在搞机助手，Magisk专区进行快速的一键修复"
                            echo "- 恭喜你ROOT成功、后会有期"
                            rm -rf "$TMPDIR" &>/dev/null
            ;;
            
            -Sign_ROM_boot)
                File1=${File%.*}
                File2=${File##*.}
                File3="${File1}_sign.$File2"
                [[ -d "$TMPDIR" ]] && rm -rf $TMPDIR
                mkdir -p $TMPDIR
                
                Check_boot() {
                    unzip -l "$File" | grep -q $1
                    return $?
                }
                
                
                if Check_boot boot.*.img; then
                    bootimg=`unzip -l "$File" | egrep boot.*.img | sed 's/.* //g'`
                    for i in $bootimg; do
                        echo "开始签名$i……"
                        unzip -oq "$File" "$i" -d "$TMPDIR"
                        echo >"$TMPDIR/${i}2"
                        boot_sign -sign "$TMPDIR/$i" "$TMPDIR/${i}2"
                        mv -f "$TMPDIR/${i}2" "$TMPDIR/$i"
                    done
                else
                    abort "！从$File里未找到boot.img镜像文件，无法使用此功能"
                fi
                cd "$TMPDIR"
                if [[ $Option = 0 ]]; then
                    echo "已选择保留源文件……"
                    cp -f "$File" "$File3"
                    echo
                    echo "开始打包……"
                    zip -rq "$File3" ./*
                    if [[ $? = 0 ]]; then
                        echo "文件已保存到：$File3"
                    else
                        error "打包失败"
                    fi
                elif [[ $Option = 1 ]]; then
                    echo "已选择不保留源文件……"
                    echo
                    echo "开始打包……"
                    zip -rq "$File" ./*
                    if [[ $? = 0 ]]; then
                        echo "文件已保存到：$File"
                    else
                        error "打包失败"
                    fi
                fi
                rm -rf "$TMPDIR" &>/dev/null
                ;;
                
                -uninstall)
                    CHROMEOS=false
                    BOOTNAND="$boot_IMG"
                    BOOTIMAGE=boot.img
                    echo "- 提取`basename $BOOTNAND`镜像"
                    dd if="$BOOTNAND" of="$BOOTIMAGE"
                    ./magiskboot unpack "$BOOTIMAGE" 2>/dev/null
                    case $? in
                        1 )
                            abort "! 不支持/未知的图像格式"
                        ;;
                        2 )
                            ui_print "- 检测到Chromeos引导映像"
                            CHROMEOS=true
                        ;;
                    esac
                    
                    BOOTIMAGE=$BOOTNAND
                    
                    ui_print "- 检查ramdisk状态"
                    if [ -e ramdisk.cpio ]; then
                        ./magiskboot cpio ramdisk.cpio test 2>/dev/null
                        STATUS=$?
                    else
                        # Stock A only system-as-root
                        STATUS=0
                    fi
                        case $((STATUS & 3)) in
                            0 )  # Stock boot
                                ui_print "- 已是官方镜像"
                            ;;
                            1 )  # Magisk patched
                                ui_print "- 检测到Magisk修补镜像"
                                . $ShellScript/Switch_ab_partition.sh -c
                                
                                # Find SHA1 of stock boot image
                                SHA1=$(./magiskboot cpio ramdisk.cpio sha1 2>/dev/null)
                                BACKUPDIR=/data/magisk_backup_$SHA1
                                if [ -d $BACKUPDIR ]; then
                                    ui_print "- 恢复库存启动镜像"
                                    flash_image $BACKUPDIR/boot.img.gz $BOOTIMAGE
                                    for name in dtb dtbo dtbs; do
                                        [ -f $BACKUPDIR/${name}.img.gz ] || continue
                                        IMAGE=$(find_block $name$SLOT)
                                        [ -z $IMAGE ] && continue
                                        ui_print "- 恢复 stock $name 镜像"
                                        flash_image $BACKUPDIR/${name}.img.gz $IMAGE
                                    done
                                else
                                    ui_print "！原厂 Boot 映像的备份不存在"
                                    ui_print "- 用内部备份恢复ramdisk"
                                    ./magiskboot cpio ramdisk.cpio restore 2>/dev/null
                                    if ! ./magiskboot cpio ramdisk.cpio "exists init" 2>/dev/null; then
                                        # A only system-as-root
                                        rm -f ramdisk.cpio
                                    fi
                                        ./magiskboot repack $BOOTIMAGE 2>/dev/null
                                        # Sign chromeos boot
                                        $CHROMEOS && sign_chromeos
                                        ui_print "- 开始恢复引导镜像"
                                        flash_image new-boot.img $BOOTIMAGE || abort "! 分区空间不足"
                                fi
                            ;;
                            2 )  # Unsupported
                                abort "! 由不支持的程序修补的引导镜像，无法恢复"
                            ;;
                        esac
                        ./magiskboot cleanup &>/dev/null
                        rm -f ./*.img
                ;;
                
                *)
                    abort "！未找到服务"
                ;;
                esac


elif [[ "$1" = mjckfy ]]; then
    shift
    . $ShellScript/Magisk_Manager_Package_name.sh
    Magisk_PATH=$DATA_DIR/$Magisk_Manager
    db_Dir=$Magisk_PATH/databases
    db_File=$db_Dir/repo.db
    TMPDIR="$TMPDIR0"
    db_sql=$TMPDIR/data.sql
    db_File2=$TMPDIR/data.db
    Piping_file="$TMPDIR/$$"
    JiaoBen=$TMPDIR/Han.sh
    case "$1" in
    
    -r)
        am force-stop $Magisk_Manager
        rm -rf "$db_File"*
        if [[ $? = 0 ]]; then
            echo "- 已恢复默认，重新打开Magisk Manager仓库刷新加载新的数据即可。"
            echo "- 如果多次刷新加载不出模块，可尝试在「设置」 --> 「点击清除仓库缓存」（清除已缓存的在线仓库信息，强制刷新在线数据）"
            echo "- 点了「清除仓库缓存」刷新还是没有模块，请检查网络是否异常！！！"
        fi
    ;;
    
    -t)
        if [[ -d "$Magisk_PATH" && ! -f "$db_File" ]]; then
            error "！未检测到Magisk Manager仓库缓存文件无法翻译，请打开Magisk Manager仓库刷新加载数据文件" 
            error "- 如果多次刷新加载不出模块，可尝试在「设置」 --> 「点击清除仓库缓存」（清除已缓存的在线仓库信息，强制刷新在线数据）" 
            abort "- 点了「清除仓库缓存」刷新还是没有模块，请检查网络是否异常！！！"
        fi
        echo "- 开始识别$Magisk_Manager UID……"
        Magisk_Manager_UID=`pm list packages -U $Magisk_Manager | cut -d : -f 3`
        [[ -z $Magisk_Manager_UID ]] && Magisk_Manager_UID=`busybox ls -n $Magisk_PATH | egrep -wo ' 10... ' | tr -d ' '`

            case $Magisk_Manager_UID in
            10*)
                echo "- 已识别到Magisk Manager UID为：$Magisk_Manager_UID"
            ;;
            
            *)
                abort "！未知的UID：$Magisk_Manager_UID"
            ;;
            esac
            [[ -d "$TMPDIR" ]] && rm -rf $TMPDIR
            mkdir -p $TMPDIR
            sqlite3 "$db_File" .dump >$db_sql
                if [[ $? != 0 ]]; then
                    error "无法加载Magisk Manager仓库数据❌，设备架构平台：`getprop ro.product.cpu.abi`" 
                    echo "开始查看sqlite3是否兼容您的设备"
                    sqlite3 --help
                    echo "请刷入Magisk模块仓库中的「SQLite3 For ARM设备」模块，然后重试"
                    exit 1
                fi
                Start_Row=`sed -n '/INSERT INTO repos VALUES(/=' "$db_sql" | sed -n '1p'`
                End_Row=`sed -n '/INSERT INTO repos VALUES(/=' "$db_sql" | sed -n '$p'`
                Sum=`sed -n '/INSERT INTO repos VALUES(/=' "$db_sql" | wc -l`
                if [[ $Sum = 0 ]]; then
                    Start_Row=`sed -n '/INSERT INTO modules VALUES(/=' "$db_sql" | sed -n '1p'`
                    End_Row=`sed -n '/INSERT INTO modules VALUES(/=' "$db_sql" | sed -n '$p'`
                    Sum=`sed -n '/INSERT INTO modules VALUES(/=' "$db_sql" | wc -l`
                    Version=New
                    echo "- 识别到新版Magisk Manger"
                else
                    Version=Old
                fi
                [[ $Sum = 0 ]]&& abort "！未找到仓库模块，请确认Magisk Manager仓库里有模块再来翻译"
                num_1=$(($Start_Row-1))
                Q=0
        
                    if [[ $Translation_Mode = Dictionary ]]; then
                        [[ -z "$Number_of_threads" ]] && abort "！未设置线程数"
                        echo "- 开始使用字典$Number_of_threads个线程进行人工翻译……"
                        DaYin
                        [[ -f $Data_Dir/Magisk_Warehouse_zh.log ]] && . $Data_Dir/Magisk_Warehouse_zh.log
                        mkfifo "$Piping_file"
                        exec 6<>"$Piping_file"
                        rm "$Piping_file"
                        
                        for o in `seq "$Number_of_threads"`;do
                            echo
                        done >&6
                            if [[ $Version = Old ]]; then
                                sed -n "${Start_Row},${End_Row}p" "$db_sql" | while read Row; do
                                    read -u6
                                    Q=$(($Q+1))
                                    echo "- 已完成：$Q/$Sum"
                                    {
                                    Tou=`echo "$Row" | sed -r "s/(.*'.*','.*','.*','.*',[0-9]+,').*',.*;/\1/g"`
                                    id=`echo "$Row" | sed -r "s/.*'(.*)','.*','.*','.*',[0-9]+,'.*',.*;/\1/g;" | tr - _ | tr . _`
                                    Mod_id=`echo "$Row" | sed -r "s/.*'(.*)','.*','.*','.*',[0-9]+,'.*',.*;/\1/g;"`
                                    Mod_name=`echo "$Row" | sed -r "s/.*'.*','(.*)','.*','.*',[0-9]+,'.*',.*;/\1/g;"`
                                    Wei=`echo "$Row" | sed -r "s/.*'.*','.*','.*','.*',[0-9]+,'.*(',.*;)/\1/g"`
                                    FYH=`eval echo "\$"$id""`
                                        if [[ -n "$FYH" ]]; then
                                            FYJG="${Tou}${FYH}${Wei}"
                                            echo "sed -i \"$(($num_1+$Q))c\\${FYJG}\" \"$db_sql\"" >>"$JiaoBen"
                                        else
                                            error "！「$Mod_id：${Mod_name}」模块未加入字典无法提供人工翻译，请私信我添加翻译即可" 
                                        fi
                                    echo >&6
                                    } &
                                done
                                wait
                                exec 6>&-
                            elif [[ $Version = New ]]; then
                                sed -n "${Start_Row},${End_Row}p" "$db_sql" | while read Row; do
                                    read -u6
                                    Q=$(($Q+1))
                                    echo "- 已完成：$Q/$Sum"
                                    {
                                    Tou=`echo "$Row" | sed -r "s/(.*'.*','.*','.*','.*',[0-9]+,').*',[0-9]+,'.*;/\1/g"`
                                    id=`echo "$Row" | sed -r "s/.*'(.*)','.*','.*','.*',[0-9]+,'.*',[0-9]+,'.*;/\1/g;" | tr - _ | tr . _`
                                    Mod_id=$id
                                    Mod_name=`echo "$Row" | sed -r "s/.*'.*','(.*)','.*','.*',[0-9]+,'.*',[0-9]+,'.*;/\1/g;"`
                                    Wei=`echo "$Row" | sed -r "s/.*'.*','.*','.*','.*',[0-9]+,'.*(',[0-9]+,'.*;)/\1/g"`
                                    FYH=`eval echo "\$"$id""`
                                        if [[ -n "$FYH" ]]; then
                                            FYJG="${Tou}${FYH}${Wei}"
                                            echo "sed -i \"$(($num_1+$Q))c\\${FYJG}\" \"$db_sql\"" >>"$JiaoBen"
                                        else
                                            error "！「$Mod_id：${Mod_name}」模块未加入字典无法提供人工翻译，请私信我添加翻译即可" 
                                        fi
                                    echo >&6
                                    } &
                                done
                                wait
                                exec 6>&-
                            fi
                
                    elif [[ $Translation_Mode = Baidu ]]; then
                        echo "- 开始联网使用「百度翻译」翻译"
                        echo "- 注：不支持多线程"
                        DaYin
                        sed -n "${Start_Row},${End_Row}p" "$db_sql" | while read Row; do
                            sleep 1
                            Q=$(($Q+1))
                            echo "- 已完成：$Q/$Sum"
                                if [[ $Version = Old ]]; then
                                    Tou=`echo "$Row" | sed -r "s/(.*'.*','.*','.*','.*',[0-9]+,').*',.*;/\1/g"`
                                    FY=`echo "$Row" | sed -r "s/.*'.*','.*','.*','.*',[0-9]+,'(.*)',.*;/\1/g" | tr -d '[+&{}#/:;]+' | tr ' ' _ | tr '/' %`
                                    Wei=`echo "$Row" | sed -r "s/.*'.*','.*','.*','.*',[0-9]+,'.*(',.*;)/\1/g"`
                                    Mod_name=`echo "$Row" | sed -r "s/.*'.*','(.*)','.*','.*',[0-9]+,'.*',.*;/\1/g;"`
                                elif [[ $Version = New ]]; then
                                    Tou=`echo "$Row" | sed -r "s/(.*'.*','.*','.*','.*',[0-9]+,').*',[0-9]+,'.*;/\1/g"`
                                    Mod_name=`echo "$Row" | sed -r "s/.*'.*','(.*)','.*','.*',[0-9]+,'.*',[0-9]+,'.*;/\1/g;"`
                                    FY=`echo "$Row" | sed -r "s/.*'.*','.*','.*','.*',[0-9]+,'(.*)',[0-9]+,'.*;/\1/g" | tr -d '[+&{}#/:;]+' | tr ' ' _ | tr '/' %`
                                    Wei=`echo "$Row" | sed -r "s/.*'.*','.*','.*','.*',[0-9]+,'.*(',[0-9]+,'.*;)/\1/g"`
                                fi
                                appid="20170831000079437"
                                key="vZWmk1G9usRAI3eFc9Mt"
                                salt="123456"
                                text="${appid}${FY}${salt}${key}"
                                sign=`echo -n "$text" | md5sum`
                                sign=`echo ${sign/ */}`
                                api="http://api.fanyi.baidu.com/api/trans/vip/translate?q=${FY}&from=en&to=zh&appid=${appid}&salt=${salt}&sign=$sign"
                                FYH=`curl -s "$api" | awk -F\" '{print $18}'`
                                FYH2=`echo "$FYH" | tr '%' /`
                                    if [[ -n "$FYH2" ]]; then
                                        FYJG="${Tou}${FYH2}${Wei}"
                                        sed -i "$(($num_1+$Q))c\\${FYJG}" "$db_sql"
                                    else
                                        error "！「${Mod_name}」模块使用「百度翻译」翻译失败❌" 
                                    fi
                        done
                    fi
                    wait
                    sleep 2
                    DaYin
                    echo "- 正在导入数据……"
                        if [[ $Translation_Mode = Dictionary ]]; then
                            sh "$JiaoBen" &>/dev/null
                            [[ $? != 0 ]] && abort -e "！导入数据失败❌，翻译失败，请降低多线程值！！！\n当前设置的多线程值$Number_of_threads大于$Sum翻译数量，导致处理不过来。"
                        fi
                                sqlite3 "$db_File2" <"$db_sql"
                                if [[ $? = 0 ]]; then
                                    chmod 660 "$db_File2"
                                    chown $Magisk_Manager_UID:$Magisk_Manager_UID "$db_File2"
                                    am force-stop $Magisk_Manager
                                    mv -f "$db_File2" "$db_File"
                                    echo "- 翻译完毕请重新打开Magisk Manager仓库即可，不要试图在仓库里刷新，否则会打回原形！！！"
                                    rm -rf "$db_File"-*
                                    echo "- 本次翻译用时：${SECONDS}s"
                                else
                                    error "！导入数据失败，本次翻译失败❌" 
                                fi
    ;;
    esac
    rm -rf "$TMPDIR" &>/dev/null

else
    abort "！未找到服务"
fi
