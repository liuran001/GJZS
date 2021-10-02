package gjzs.online

import android.Manifest
import android.app.Activity
import android.content.Context
import android.content.Intent
import android.graphics.Color
import android.os.Build
import android.os.Bundle
import android.os.Handler
import android.os.Looper
import androidx.core.app.ActivityCompat
import androidx.core.content.PermissionChecker
import android.util.TypedValue
import android.view.View
import android.widget.TextView
import com.omarea.common.shell.ShellExecutor
import com.omarea.krscript.executor.ScriptEnvironmen
import gjzs.online.permissions.CheckRootStatus
import kotlinx.android.synthetic.main.activity_splash.*
import java.io.BufferedReader
import java.io.DataOutputStream

class SplashActivity : Activity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        if (ScriptEnvironmen.isInited()) {
            if (isTaskRoot) {
                gotoHome()
            }
            return
        }

        setContentView(R.layout.activity_splash)
        updateThemeStyle()

        checkPermissions()
    }

    /**
     * 界面主题样式调整
     */
    private fun updateThemeStyle() {
        getWindow().setNavigationBarColor(getColorAccent())
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            window.setNavigationBarColor(getColor(R.color.splash_bg_color))
        } else {
            window.setNavigationBarColor(resources.getColor(R.color.splash_bg_color))
        }

        //  得到当前界面的装饰视图
        if (Build.VERSION.SDK_INT >= 21) {
            val decorView = getWindow().getDecorView();
            //让应用主题内容占用系统状态栏的空间,注意:下面两个参数必须一起使用 stable 牢固的
            val option = View.SYSTEM_UI_FLAG_LAYOUT_FULLSCREEN or View.SYSTEM_UI_FLAG_LAYOUT_STABLE
            decorView.setSystemUiVisibility(option);
            //设置状态栏颜色为透明
            getWindow().setStatusBarColor(Color.TRANSPARENT)
        }
    }

    private fun getColorAccent(): Int {
        val typedValue = TypedValue()
        this.theme.resolveAttribute(R.attr.colorAccent, typedValue, true)
        return typedValue.data
    }

    /**
     * 开始检查必需权限
     */
    private fun checkPermissions() {
        start_logo.visibility = View.VISIBLE
        checkRoot(Runnable {
            start_state_text.text = getString(R.string.pio_permission_checking)
            hasRoot = true

            /*
            checkFileWrite(Runnable {
                startToFinish()
            })
            */
            startToFinish()
        })
    }

    private fun checkPermission(permission: String): Boolean = PermissionChecker.checkSelfPermission(this.applicationContext, permission) == PermissionChecker.PERMISSION_GRANTED

    /**
     * 检查权限 主要是文件读写权限
     */
    private fun checkFileWrite(next: Runnable) {
        Thread(Runnable {
            CheckRootStatus.grantPermission(this)
            if (!(checkPermission(Manifest.permission.READ_EXTERNAL_STORAGE) && checkPermission(Manifest.permission.WRITE_EXTERNAL_STORAGE))) {
                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
                    ActivityCompat.requestPermissions(
                            this@SplashActivity,
                            arrayOf(
                                    Manifest.permission.READ_EXTERNAL_STORAGE,
                                    Manifest.permission.WRITE_EXTERNAL_STORAGE,
                                    Manifest.permission.MOUNT_UNMOUNT_FILESYSTEMS,
                                    Manifest.permission.REQUEST_IGNORE_BATTERY_OPTIMIZATIONS,
                                    Manifest.permission.WAKE_LOCK
                            ),
                            0x11
                    )
                } else {
                    ActivityCompat.requestPermissions(
                            this@SplashActivity,
                            arrayOf(
                                    Manifest.permission.READ_EXTERNAL_STORAGE,
                                    Manifest.permission.WRITE_EXTERNAL_STORAGE,
                                    Manifest.permission.MOUNT_UNMOUNT_FILESYSTEMS,
                                    Manifest.permission.WAKE_LOCK
                            ),
                            0x11
                    )
                }
            }
            myHandler.post {
                next.run()
            }
        }).start()
    }

    private var hasRoot = false
    private var myHandler = Handler()

    private fun checkRoot(next: Runnable) {
        CheckRootStatus(this, next).forceGetRoot()
    }

    /**
     * 启动完成
     */
    private fun startToFinish() {
        start_state_text.text = getString(R.string.pop_started)

        val config = KrScriptConfig().init(this)
        if (config.beforeStartSh.isNotEmpty()) {
            BeforeStartThread(this, config, UpdateLogViewHandler(start_state_text, Runnable {
                gotoHome()
            })).start()
        } else {
            gotoHome()
        }
    }

    private fun gotoHome() {
        if (this.intent != null && this.intent.hasExtra("JumpActionPage") && this.intent.getBooleanExtra("JumpActionPage", false)) {
            val actionPage = Intent(this.applicationContext, ActionPage::class.java)
            actionPage.putExtras(this.intent)
            startActivity(actionPage)
        } else {
            val home = Intent(this.applicationContext, MainActivity::class.java)
            startActivity(home)
        }
        finish()
    }

    private class UpdateLogViewHandler(private var logView: TextView, private val onExit: Runnable) {
        private val handler = Handler(Looper.getMainLooper())
        private var notificationMessageRows = ArrayList<String>()
        private var someIgnored = false

        fun onLogOutput(log: String) {
            handler.post {
                synchronized(notificationMessageRows) {
                    if (notificationMessageRows.size > 6) {
                        notificationMessageRows.remove(notificationMessageRows.first())
                        someIgnored = true
                    }
                    notificationMessageRows.add(log)
                    logView.setText(notificationMessageRows.joinToString("\n", if (someIgnored) "……\n" else "").trim())
                }
            }
        }

        fun onExit() {
            handler.post { onExit.run() }
        }
    }

    private class BeforeStartThread(private var context: Context, private val config: KrScriptConfig, private var updateLogViewHandler: UpdateLogViewHandler) : Thread() {
        val params = config.getVariables();

        override fun run() {
            try {
                val process = if (CheckRootStatus.lastCheckResult) ShellExecutor.getSuperUserRuntime() else ShellExecutor.getRuntime()
                if (process != null) {
                    val outputStream = DataOutputStream(process.outputStream)

                    ScriptEnvironmen.executeShell(context, outputStream, config.beforeStartSh, params, null, "pio-splash")

                    StreamReadThread(process.inputStream.bufferedReader(), updateLogViewHandler).start()
                    StreamReadThread(process.errorStream.bufferedReader(), updateLogViewHandler).start()

                    process.waitFor()
                    updateLogViewHandler.onExit()
                } else {
                    updateLogViewHandler.onExit()
                }
            } catch (ex: Exception) {
                updateLogViewHandler.onExit()
            }
        }
    }

    private class StreamReadThread(private var reader: BufferedReader, private var updateLogViewHandler: UpdateLogViewHandler) : Thread() {
        override fun run() {
            var line: String? = ""
            while (true) {
                line = reader.readLine()
                if (line == null) {
                    break
                } else {
                    updateLogViewHandler.onLogOutput(line)
                }
            }
        }
    }
}