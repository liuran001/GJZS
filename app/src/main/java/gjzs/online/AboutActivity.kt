package gjzs.online

import android.Manifest
import android.content.Intent
import android.view.Menu
import android.view.MenuItem
import android.widget.ImageView
import android.widget.TextView
import android.widget.Toast
import androidx.core.content.PermissionChecker
import com.drakeet.about.*


class AboutActivity : AbsAboutActivity() {
    override fun onCreateHeader(icon: ImageView, slogan: TextView, version: TextView) {
        icon.setImageResource(R.mipmap.ic_launcher)
        slogan.setText(R.string.app_name)
        version.text = "v" + BuildConfig.VERSION_NAME
    }

    override fun onItemsCreated(items: MutableList<Any>) {
        items.add(Category("About"))
        items.add(Card(getString(R.string.card_content)))
        items.add(Category("Support and feedback"))
        items.add(Card("Website (官网):\nhttps://gjzsr.com"))
        items.add(Card("GitHub:\nhttps://github.com/liuran001/GJZS"))
        items.add(Card("Telegram Channel (TG频道):\nhttps://t.me/s/gjzs666_channel"))
        items.add(Card("Telegram Group (TG群组):\nhttps://t.me/s/gjzs666"))
        items.add(Card("QQ Channel (QQ频道):\nhttps://u.qqcn.xyz/hCmf7C"))
        items.add(Card("Mail:\nsupport@gjzsr.com"))
        items.add(Category("Developers"))
        items.add(Contributor(R.drawable.avatar_developer, "笨蛋ovo (@liuran001)", "Developer", "https://bdovo.xyz"))
        items.add(Contributor(R.drawable.avatar_qqlittleice233, "QQ little ice", "Contributor", "https://github.com/qqlittleice233"))
        items.add(Contributor(R.drawable.avatar_qwq233, "James Clef", "Contributor", "https://github.com/qwq233"))
        items.add(Contributor(R.drawable.avatar_original_developer, "情非得已c", "Original Developer", "https://u.qqcn.xyz/ZxZ3T2"))
        items.add(Contributor(R.drawable.avatar_icon_designer, "莫白の", "Icon Designer", "https://u.qqcn.xyz/RhtXwJ"))
        items.add(Category("Open Source Licenses"))
        items.add(License("MultiType", "drakeet", License.APACHE_2, "https://github.com/drakeet/MultiType"))
        items.add(License("about-page", "drakeet", License.APACHE_2, "https://github.com/drakeet/about-page"))
        items.add(License("kr-scripts", "helloklf", License.GPL_V3, "https://github.com/helloklf/kr-scripts"))
        items.add(License("appcenter-sdk-android", "microsoft", License.MIT, "https://github.com/microsoft/appcenter-sdk-android"))
        items.add(License("AndroidHiddenApiBypass", "LSPosed", License.APACHE_2, "https://github.com/LSPosed/AndroidHiddenApiBypass"))
        items.add(License("StringFog", "MegatronKing", License.APACHE_2, "https://github.com/MegatronKing/StringFog"))
        items.add(License("curl-android", "vvb2060", "No License", "https://github.com/vvb2060/curl-android"))
    }

    override fun onCreateOptionsMenu(menu: Menu): Boolean {
        menuInflater.inflate(R.menu.menu_about, menu)
        // TransparentUI
        val transparent = menu.findItem(R.id.transparent_ui)
        val themeConfig = ThemeConfig(this)
        transparent.isChecked = themeConfig.getAllowTransparentUI()
        // App Center Status
        val appcenter = menu.findItem(R.id.appcenter_switch)
        val appcenterStatus = AppCenterStatus(this)
        appcenter.isChecked = appcenterStatus.getAppCenterStatus()
        return super.onCreateOptionsMenu(menu)
    }

    override fun onOptionsItemSelected(menuItem: MenuItem): Boolean {
        return when (menuItem.itemId) {
            R.id.transparent_ui -> {
                val themeConfig = ThemeConfig(this)
                if (menuItem.isChecked) {
                    themeConfig.setAllowTransparentUI(false)
                    val intent = Intent()
                    intent.setClass(this, MainActivity::class.java).flags = Intent.FLAG_ACTIVITY_CLEAR_TASK
                    startActivity(intent)
                } else {
                    fun checkPermission(permission: String): Boolean = PermissionChecker.checkSelfPermission(this, permission) == PermissionChecker.PERMISSION_GRANTED
                    if (menuItem.isChecked && !checkPermission(Manifest.permission.READ_EXTERNAL_STORAGE)) {
                        themeConfig.setAllowTransparentUI(false)
                        Toast.makeText(this@AboutActivity, R.string.kr_write_external_storage, Toast.LENGTH_SHORT).show()
                    } else {
                        themeConfig.setAllowTransparentUI(true)
                        val intent = Intent()
                        intent.setClass(this, MainActivity::class.java).flags = Intent.FLAG_ACTIVITY_CLEAR_TASK
                        startActivity(intent)
                    }
                }
                return true
            }
            R.id.appcenter_switch -> {
                val appcenterStatus = AppCenterStatus(this)
                if (menuItem.isChecked) {
                    appcenterStatus.setAppCenterStatus(false)
                    invalidateOptionsMenu()
                } else {
                    appcenterStatus.setAppCenterStatus(true)
                    invalidateOptionsMenu()
                }
                return true
            }
            else -> super.onOptionsItemSelected(menuItem)
        }
    }
}