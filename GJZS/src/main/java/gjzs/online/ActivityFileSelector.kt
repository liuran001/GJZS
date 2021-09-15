package gjzs.online

import android.Manifest
import android.app.Activity
import android.content.Intent
import android.content.pm.PackageManager
import android.os.Bundle
import android.os.Environment
import android.view.KeyEvent
import android.view.View
import android.widget.Toast
import androidx.appcompat.app.AppCompatActivity
import androidx.appcompat.widget.Toolbar
import androidx.core.app.ActivityCompat
import androidx.core.content.PermissionChecker
import com.omarea.common.ui.ProgressBarDialog
import gjzs.online.R
import gjzs.online.ui.AdapterFileSelector
import kotlinx.android.synthetic.main.activity_file_selector.*
import java.io.File

class ActivityFileSelector : AppCompatActivity() {
    companion object {
        val MODE_FILE = 0
        val MODE_FOLDER = 1
    }

    private var adapterFileSelector: gjzs.online.ui.AdapterFileSelector? = null
    var extension = ""
    var mode = MODE_FILE

    override fun onCreate(savedInstanceState: Bundle?) {
        // TODO:ThemeSwitch.switchTheme(this)

        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_file_selector)

        val toolbar = findViewById<View>(R.id.toolbar) as Toolbar
        setSupportActionBar(toolbar)
        // setTitle(R.string.app_name)

        // 显示返回按钮
        supportActionBar!!.setHomeButtonEnabled(true)
        supportActionBar!!.setDisplayHomeAsUpEnabled(true)
        toolbar.setNavigationOnClickListener { _ ->
            finish()
        }

        intent.extras?.run {
            if (containsKey("extension") == true) {
                extension = "" + intent.extras.getString("extension")
                if (!extension.startsWith(".")) {
                    extension = ".$extension"
                }
                if (extension.isNotEmpty()) {
                    title = title.toString() + "($extension)"
                }
            }
            if (containsKey("mode") == true) {
                mode = getInt("mode")
                if (mode == MODE_FOLDER) {
                    title = getString(R.string.title_activity_folder_selector)
                }
            }
        }
    }

    override fun onKeyDown(keyCode: Int, event: KeyEvent?): Boolean {
        if (keyCode == KeyEvent.KEYCODE_BACK && adapterFileSelector != null && adapterFileSelector!!.goParent()) {
            return true
        } else {
            setResult(Activity.RESULT_CANCELED, Intent())
        }
        return super.onKeyDown(keyCode, event)
    }

    override fun onRequestPermissionsResult(requestCode: Int, permissions: Array<out String>, grantResults: IntArray) {
        super.onRequestPermissionsResult(requestCode, permissions, grantResults)

        var grant = true
        for (result in grantResults) {
            if (result == PackageManager.PERMISSION_DENIED) {
                grant = false;
            }
        }

        if (requestCode == 111) {
            if (grant == false) {
                Toast.makeText(applicationContext, "没有读取文件的权限！", Toast.LENGTH_LONG).show()
            } else {
                loadData()
            }
        }
    }

    private fun checkPermission(permission: String): Boolean = PermissionChecker.checkSelfPermission(this, permission) == PermissionChecker.PERMISSION_GRANTED
    private fun requestPermissions() {
        ActivityCompat.requestPermissions(this, arrayOf(Manifest.permission.READ_EXTERNAL_STORAGE, Manifest.permission.WRITE_EXTERNAL_STORAGE), 111);
    }

    override fun onResume() {
        super.onResume()
        loadData()
    }

    private fun loadData() {
        if (checkPermission(Manifest.permission.READ_EXTERNAL_STORAGE) && checkPermission(Manifest.permission.WRITE_EXTERNAL_STORAGE)) {
            val sdcard = File(Environment.getExternalStorageDirectory().absolutePath)
            if (sdcard.exists() && sdcard.isDirectory) {
                val list = sdcard.listFiles()
                if (list == null) {
                    Toast.makeText(applicationContext, "获取文件列表失败！", Toast.LENGTH_LONG).show()
                    return
                }
                val onSelected =  Runnable {
                    val file: File? = adapterFileSelector!!.selectedFile
                    if (file != null) {
                        this.setResult(Activity.RESULT_OK, Intent().putExtra("file", file.absolutePath))
                        this.finish()
                    }
                }
                adapterFileSelector = if (mode == MODE_FOLDER) {
                    gjzs.online.ui.AdapterFileSelector.FolderChooser(sdcard, onSelected, ProgressBarDialog(this))
                } else {
                    gjzs.online.ui.AdapterFileSelector.FileChooser(sdcard, onSelected, ProgressBarDialog(this), extension)
                }

                file_selector_list.adapter = adapterFileSelector
            }
        } else {
            requestPermissions()
        }
    }
}
