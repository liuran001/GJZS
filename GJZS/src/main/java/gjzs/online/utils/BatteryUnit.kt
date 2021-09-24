package com.omarea.shell.units

import com.omarea.common.shell.KeepShellPublic
import com.omarea.common.shell.KernelProrp
import com.omarea.common.shell.RootFile
import gjzs.online.BatteryStatus
import java.io.File

/**
 * Created by Hello on 2017/11/01.
 */

class BatteryUnit {
    //是否兼容此设备
    val isSupport: Boolean
        get() = RootFile.itemExists("/sys/class/power_supply/bms/uevent") || qcSettingSuupport() || bpSettingSuupport() || pdSupported()

    //获取电池信息
    /*else if (info.startsWith("POWER_SUPPLY_TIME_TO_EMPTY_AVG=")) {
                        stringBuilder.append("平均耗尽 = ");
                        int val = Integer.parseInt(info.substring(keyrowd.length(), info.length()));
                        stringBuilder.append(((val / 3600.0) + "    ").substring(0, 4));
                        stringBuilder.append("小时");
                    } else if (info.startsWith("POWER_SUPPLY_TIME_TO_FULL_AVG=")) {
                        stringBuilder.append("平均充满 = ");
                        int val = Integer.parseInt(info.substring(keyrowd.length(), info.length()));
                        stringBuilder.append(((val / 3600.0) + "    ").substring(0, 4));
                        stringBuilder.append("小时");
                    }*/
    val batteryInfo: String
        get() {
            if (RootFile.fileExists("/sys/class/power_supply/bms/uevent")) {
                val batteryInfos = KernelProrp.getProp("/sys/class/power_supply/bms/uevent")
                val infos = batteryInfos.split("\n".toRegex()).dropLastWhile { it.isEmpty() }.toTypedArray()
                val stringBuilder = StringBuilder()
                var io = ""
                var mahLength = 0
                for (info in infos) {
                    try {
                        if (info.startsWith("POWER_SUPPLY_CHARGE_FULL=")) {
                            val keyrowd = "POWER_SUPPLY_CHARGE_FULL="
                            stringBuilder.append("充满容量 = ")
                            stringBuilder.append(info.substring(keyrowd.length, keyrowd.length + 4))
                            if (mahLength == 0) {
                                val value = info.substring(keyrowd.length, info.length)
                                mahLength = value.length
                            }
                            stringBuilder.append("mAh")
                        } else if (info.startsWith("POWER_SUPPLY_CHARGE_FULL_DESIGN=")) {
                            val keyrowd = "POWER_SUPPLY_CHARGE_FULL_DESIGN="
                            stringBuilder.append("设计容量 = ")
                            stringBuilder.append(info.substring(keyrowd.length, keyrowd.length + 4))
                            stringBuilder.append("mAh")
                            val value = info.substring(keyrowd.length, info.length)
                            mahLength = value.length
                        } else if (info.startsWith("POWER_SUPPLY_TEMP=")) {
                            val keyrowd = "POWER_SUPPLY_TEMP="
                            stringBuilder.append("电池温度 = ")
                            stringBuilder.append(info.substring(keyrowd.length, keyrowd.length + 2))
                            stringBuilder.append("°C")
                        } else if (info.startsWith("POWER_SUPPLY_TEMP_WARM=")) {
                            val keyrowd = "POWER_SUPPLY_TEMP_WARM="
                            stringBuilder.append("警戒温度 = ")
                            val value = Integer.parseInt(info.substring(keyrowd.length, info.length))
                            stringBuilder.append(value / 10)
                            stringBuilder.append("°C")
                        } else if (info.startsWith("POWER_SUPPLY_TEMP_COOL=")) {
                            val keyrowd = "POWER_SUPPLY_TEMP_COOL="
                            stringBuilder.append("低温温度 = ")
                            val value = Integer.parseInt(info.substring(keyrowd.length, info.length))
                            stringBuilder.append(value / 10)
                            stringBuilder.append("°C")
                        } else if (info.startsWith("POWER_SUPPLY_VOLTAGE_NOW=")) {
                            val keyrowd = "POWER_SUPPLY_VOLTAGE_NOW="
                            stringBuilder.append("当前电压 = ")
                            val v = Integer.parseInt(info.substring(keyrowd.length, keyrowd.length + 2))
                            stringBuilder.append(v / 10.0f)
                            stringBuilder.append("v")
                        } else if (info.startsWith("POWER_SUPPLY_VOLTAGE_MAX_DESIGN=")) {
                            val keyrowd = "POWER_SUPPLY_VOLTAGE_MAX_DESIGN="
                            stringBuilder.append("设计电压 = ")
                            val v = Integer.parseInt(info.substring(keyrowd.length, keyrowd.length + 2))
                            stringBuilder.append(v / 10.0f)
                            stringBuilder.append("v")
                        } else if (info.startsWith("POWER_SUPPLY_BATTERY_TYPE=")) {
                            val keyrowd = "POWER_SUPPLY_BATTERY_TYPE="
                            stringBuilder.append("电池类型 = ")
                            stringBuilder.append(info.substring(keyrowd.length, info.length))
                        } else if (info.startsWith("POWER_SUPPLY_CYCLE_COUNT=")) {
                            val keyrowd = "POWER_SUPPLY_CYCLE_COUNT="
                            stringBuilder.append("循环次数 = ")
                            stringBuilder.append(info.substring(keyrowd.length, info.length))
                        } else if (info.startsWith("POWER_SUPPLY_CONSTANT_CHARGE_VOLTAGE=")) {
                            val keyrowd = "POWER_SUPPLY_CONSTANT_CHARGE_VOLTAGE="
                            stringBuilder.append("充电电压 = ")
                            val v = Integer.parseInt(info.substring(keyrowd.length, keyrowd.length + 2))
                            stringBuilder.append(v / 10.0f)
                            stringBuilder.append("v")
                        } else if (info.startsWith("POWER_SUPPLY_CAPACITY=")) {
                            val keyrowd = "POWER_SUPPLY_CAPACITY="
                            stringBuilder.append("电池电量 = ")
                            stringBuilder.append(info.substring(keyrowd.length, if (keyrowd.length + 2 > info.length) info.length else keyrowd.length + 2))
                            stringBuilder.append("%")
                        } else if (info.startsWith("POWER_SUPPLY_CURRENT_NOW=")) {
                            val keyrowd = "POWER_SUPPLY_CURRENT_NOW="
                            io = info.substring(keyrowd.length, info.length)
                            continue
                        } else {
                            continue
                        }
                        stringBuilder.append("\n")
                    } catch (ignored: Exception) {
                    }
                }

                if (io.isNotEmpty() && mahLength != 0) {
                    val `val` = if (mahLength < 5) Integer.parseInt(io) else (Integer.parseInt(io) / Math.pow(10.0, (mahLength - 4).toDouble())).toInt()
                    stringBuilder.insert(0, "放电速度 = " + `val` + "mA\n")
                }

                return stringBuilder.toString()
            } else {
                return ""
            }
        }

    //获取电池容量
    /*
            POWER_SUPPLY_NAME=bms
            POWER_SUPPLY_CAPACITY=30
            POWER_SUPPLY_CAPACITY_RAW=77
            POWER_SUPPLY_TEMP=320
            POWER_SUPPLY_VOLTAGE_NOW=3697500
            POWER_SUPPLY_VOLTAGE_OCV=3777837
            POWER_SUPPLY_CURRENT_NOW=440917
            POWER_SUPPLY_RESISTANCE_ID=58000
            POWER_SUPPLY_RESISTANCE=200195
            POWER_SUPPLY_BATTERY_TYPE=sagit_atl
            POWER_SUPPLY_CHARGE_FULL_DESIGN=3349000
            POWER_SUPPLY_VOLTAGE_MAX_DESIGN=4400000
            POWER_SUPPLY_CYCLE_COUNT=69
            POWER_SUPPLY_CYCLE_COUNT_ID=1
            POWER_SUPPLY_CHARGE_NOW_RAW=1244723
            POWER_SUPPLY_CHARGE_NOW=0
            POWER_SUPPLY_CHARGE_FULL=3272000
            POWER_SUPPLY_CHARGE_COUNTER=1036650
            POWER_SUPPLY_TIME_TO_FULL_AVG=26438
            POWER_SUPPLY_TIME_TO_EMPTY_AVG=30561
            POWER_SUPPLY_SOC_REPORTING_READY=1
            POWER_SUPPLY_DEBUG_BATTERY=0
            POWER_SUPPLY_CONSTANT_CHARGE_VOLTAGE=4389899
            POWER_SUPPLY_CC_STEP=0
            POWER_SUPPLY_CC_STEP_SEL=0
            */ val batteryMAH: String
        get() {
            var path = ""
            if (RootFile.fileExists("/sys/class/power_supply/bms/uevent")) {
                val batteryInfos = KernelProrp.getProp("/sys/class/power_supply/bms/uevent")

                val arr = batteryInfos.split("\n".toRegex()).dropLastWhile { it.isEmpty() }.toTypedArray()
                val keywords = arrayOf("POWER_SUPPLY_CHARGE_FULL=", "POWER_SUPPLY_CHARGE_FULL_DESIGN=")
                for (k in keywords.indices) {
                    val keyword = keywords[k]
                    for (i in arr.indices) {
                        if (arr[i].startsWith(keyword)) {
                            var chargeFull = arr[i]
                            chargeFull = chargeFull.substring(keyword.length)
                            if (chargeFull.length > 4)
                                chargeFull = chargeFull.substring(0, 4)
                            return chargeFull + "mAh"
                        }
                    }
                }
            } else {
                if (File("/sys/class/power_supply/battery/charge_full").exists()) {
                    path = "/sys/class/power_supply/battery/charge_full"
                } else if (File("/sys/class/power_supply/battery/charge_full_design").exists()) {
                    path = "/sys/class/power_supply/battery/charge_full_design"
                } else if (File("/sys/class/power_supply/battery/full_bat").exists()) {
                    path = "/sys/class/power_supply/battery/full_bat"
                } else {
                    return "? mAh"
                }
                val txt = KernelProrp.getProp(path)
                if (txt.trim { it <= ' ' }.isEmpty())
                    return "? mAh"
                return if (txt.length > 4) txt.substring(0, 4) + " mAh" else "$txt mAh"
            }
            return "? mAh"
        }

    //快充是否支持修改充电速度设置
    fun qcSettingSuupport(): Boolean {
        return RootFile.itemExists("/sys/class/power_supply/battery/constant_charge_current_max")
    }

    fun getqcLimit(): String {
        var limit = KernelProrp.getProp("/sys/class/power_supply/battery/constant_charge_current_max")
        if (limit.length > 3) {
            limit = limit.substring(0, limit.length - 3) + "mA"
        } else if (limit.isNotEmpty()) {
            try {
                if (Integer.parseInt(limit) == 0) {
                    limit = "0"
                }
            } catch (ignored: Exception) {
            }

        } else {
            return "?mA"
        }
        return limit
    }

    //快充是否支持电池保护
    fun bpSettingSuupport(): Boolean {
        return RootFile.itemExists("/sys/class/power_supply/battery/battery_charging_enabled") || RootFile.itemExists("/sys/class/power_supply/battery/input_suspend")
    }

    //修改充电速度限制
    fun setChargeInputLimit(limit: Int) {
        val cmd = "echo 0 > /sys/class/power_supply/battery/restricted_charging;" +
                "echo 0 > /sys/class/power_supply/battery/safety_timer_enabled;" +
                "chmod 755 /sys/class/power_supply/bms/temp_warm;" +
                "echo 480 > /sys/class/power_supply/bms/temp_warm;" +
                "chmod 755 /sys/class/power_supply/battery/constant_charge_current_max;" +
                "echo 2000000 > /sys/class/power_supply/battery/constant_charge_current_max;" +
                "echo 2500000 > /sys/class/power_supply/battery/constant_charge_current_max;" +
                "echo 3000000 > /sys/class/power_supply/battery/constant_charge_current_max;" +
                "echo 3500000 > /sys/class/power_supply/battery/constant_charge_current_max;" +
                "echo 4000000 > /sys/class/power_supply/battery/constant_charge_current_max;" +
                "echo 4500000 > /sys/class/power_supply/battery/constant_charge_current_max;" +
                "echo 5000000 > /sys/class/power_supply/battery/constant_charge_current_max;" +
                "echo " + limit + "000 > /sys/class/power_supply/battery/constant_charge_current_max;"

        KeepShellPublic.doCmdSync(cmd)
    }

    fun pdSupported(): Boolean {
        return RootFile.fileExists("/sys/class/power_supply/usb/pd_allowed")
    }

    fun pdAllowed(): Boolean {
        return KernelProrp.getProp("/sys/class/power_supply/usb/pd_allowed") == "1"
    }

    fun setAllowed(boolean: Boolean): Boolean {
        val builder = java.lang.StringBuilder()
        builder.append("chmod 777 /sys/class/power_supply/usb/pd_allowed\n")
        builder.append("echo ${if (boolean) "1" else "0"}> /sys/class/power_supply/usb/pd_allowed\n")
        builder.append("chmod 777 /sys/class/power_supply/usb/pd_active\n")
        builder.append("echo 1 > /sys/class/power_supply/usb/pd_active\n")
        return KeepShellPublic.doCmdSync(builder.toString()) != "error"
    }

    fun pdActive(): Boolean {
        return KernelProrp.getProp("/sys/class/power_supply/usb/pd_active") == "1"
    }

    /**
     * 获取电池温度
     */
    fun getBatteryTemperature(): BatteryStatus {
        val batteryInfo = KeepShellPublic.doCmdSync("dumpsys battery")
        val batteryInfos = batteryInfo.split("\n")

        // 由于部分手机相同名称的参数重复出现，并且值不同，为了避免这种情况，加个额外处理，同名参数只读一次
        var levelReaded = false
        var tempReaded = false
        var statusReaded = false
        val batteryStatus = BatteryStatus()

        for (item in batteryInfos) {
            val info = item.trim()
            val index = info.indexOf(":")
            if (index > Int.MIN_VALUE && index < info.length - 1) {
                val value = info.substring(info.indexOf(":") + 1).trim()
                try {
                    if (info.startsWith("status")) {
                        if (!statusReaded) {
                            batteryStatus.statusText = value
                            statusReaded = true
                        } else {
                            continue
                        }
                    } else if (info.startsWith("level")) {
                        if (!levelReaded) {
                            batteryStatus.level = value.toInt()
                            levelReaded = true
                        } else continue
                    } else if (info.startsWith("temperature")) {
                        if (!tempReaded) {
                            tempReaded = true
                            batteryStatus.temperature = (value.toFloat() / 10.0).toFloat()
                        } else continue
                    }
                } catch (ex: java.lang.Exception) {

                }
            }
        }
        return batteryStatus
    }
}
