package gjzs.online.ui

import android.app.Activity
import android.graphics.drawable.Drawable
import android.util.TypedValue
import android.view.View
import android.widget.ImageView
import android.widget.TabHost
import android.widget.TextView
import gjzs.online.R

class TabIconHelper(private var tabHost: TabHost, private var activity: Activity) {
    private var views = ArrayList<View>()

    fun newTabSpec(drawable: Drawable, content: Int): String {
        return newTabSpec("", drawable, content)
    }

    fun newTabSpec(text: String, drawable: Drawable, content: Int): String {
        val layout = View.inflate(activity, R.layout.list_item_tab, null)
        val imageView = layout.findViewById<ImageView>(R.id.ItemIcon)
        val textView = layout.findViewById<TextView>(R.id.ItemTitle)
        val tabId = "tab_" + views.size

        textView.text = text

        // val tintIcon = DrawableCompat.wrap(view.drawable)
        // val csl = getResources().getColorStateList(R.color.colorAccent)
        // DrawableCompat.setTintList(tintIcon, csl)
        // imageView.setImageDrawable(tintIcon)
        // imageView.setColorFilter(getColorAccent())

        if (views.size != 0) {
            layout.alpha = 0.3f
        }
        imageView.setImageDrawable(drawable)
        views.add(layout)
        // imageView.setBackgroundResource(R.drawable.tab_background)
        tabHost.addTab(tabHost.newTabSpec(tabId).setContent(content).setIndicator(layout))

        return tabId
    }

    fun getColorAccent(): Int {
        val typedValue = TypedValue()
        this.activity.theme.resolveAttribute(R.attr.colorAccent, typedValue, true)
        return typedValue.data
    }

    fun updateHighlight() {
        for (i in 0 until tabHost.tabWidget.tabCount) {
            val tab = tabHost.tabWidget.getChildAt(i)
            if (i == tabHost.currentTab) {
                tab.alpha = 1f
            } else {
                tab.alpha = 0.3f
            }
        }
    }
}
