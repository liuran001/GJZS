package gjzs.online

import android.app.Activity
import android.content.Context

class AppCenterStatus (private val activity: Activity) {
    private val config = activity.getSharedPreferences("AppCenter_status", Context.MODE_PRIVATE)

    fun getAppCenterStatus(): Boolean {
        return config.getBoolean("Status", true)
    }

    fun setAppCenterStatus(allow: Boolean) {
        config.edit().putBoolean("Status", allow).apply()
    }
}