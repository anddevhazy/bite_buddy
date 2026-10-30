package com.example.bite_buddy

import android.app.PendingIntent
import android.appwidget.AppWidgetManager
import android.content.Context
import android.content.Intent
import android.content.SharedPreferences
import android.graphics.Bitmap
import android.graphics.BitmapFactory
import android.view.View
import android.widget.RemoteViews
import es.antonborri.home_widget.HomeWidgetProvider
import java.util.Calendar

// The home-screen widget. The app saves the buddy's details whenever it loads
// the pet (lib/features/global/services/pet_widget_service.dart); the mood is
// worked out here from the last meal time, so it stays right between app
// opens. Android redraws it every 30 minutes (res/xml/buddy_widget_info.xml).
class BuddyWidgetProvider : HomeWidgetProvider() {
    override fun onUpdate(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetIds: IntArray,
        widgetData: SharedPreferences,
    ) {
        for (id in appWidgetIds) {
            val views = RemoteViews(context.packageName, R.layout.buddy_widget)
            val name = widgetData.getString("petName", null)

            if (name == null) {
                views.setTextViewText(R.id.widget_name, "Bite Buddy")
                views.setTextViewText(R.id.widget_mood, "Open the app to meet your buddy")
                views.setViewVisibility(R.id.widget_streak, View.GONE)
            } else {
                val lastFedAt = widgetData.getString("lastFedAt", "")?.toLongOrNull()
                val meals = widgetData.getInt("mealsEaten", 0)
                views.setTextViewText(R.id.widget_name, name)
                views.setTextViewText(R.id.widget_mood, mood(meals, lastFedAt))

                val streak = liveStreak(widgetData.getInt("streak", 0), lastFedAt)
                if (streak > 0) {
                    views.setTextViewText(R.id.widget_streak, "🔥 $streak-day streak")
                    views.setViewVisibility(R.id.widget_streak, View.VISIBLE)
                } else {
                    views.setViewVisibility(R.id.widget_streak, View.GONE)
                }
            }

            widgetData.getString("petImage", null)?.let { path ->
                loadScaled(path, 256)?.let { views.setImageViewBitmap(R.id.widget_pet, it) }
            }

            // Tapping the widget opens the app
            val launch = Intent(context, MainActivity::class.java)
            views.setOnClickPendingIntent(
                R.id.widget_root,
                PendingIntent.getActivity(
                    context,
                    0,
                    launch,
                    PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE,
                ),
            )
            appWidgetManager.updateAppWidget(id, views)
        }
    }

    // Same 8-hour hunger grace as the server (utils/pet_stats.dart)
    private fun mood(mealsEaten: Int, lastFedAt: Long?): String {
        if (mealsEaten == 0 || lastFedAt == null) return "Hungry! Scan your first meal 🍽️"
        val hours = (System.currentTimeMillis() - lastFedAt) / 3_600_000.0
        return when {
            hours < 4 -> "Happy and full 😊"
            hours < 8 -> "Getting peckish 🙂"
            hours < 24 -> "Hungry! Feed me 🍽️"
            else -> "Starving and feeling weak 😢"
        }
    }

    // A streak ends once a whole day passes with no meal
    private fun liveStreak(streak: Int, lastFedAt: Long?): Int {
        if (streak == 0 || lastFedAt == null) return 0
        val fed = Calendar.getInstance().apply { timeInMillis = lastFedAt }
        val yesterday = Calendar.getInstance().apply { add(Calendar.DAY_OF_YEAR, -1) }
        val fedDay = fed.get(Calendar.YEAR) * 1000 + fed.get(Calendar.DAY_OF_YEAR)
        val yesterdayDay = yesterday.get(Calendar.YEAR) * 1000 + yesterday.get(Calendar.DAY_OF_YEAR)
        return if (fedDay >= yesterdayDay) streak else 0
    }

    // Widgets have a small memory budget, so the picture is shrunk first
    private fun loadScaled(path: String, maxSize: Int): Bitmap? {
        val bounds = BitmapFactory.Options().apply { inJustDecodeBounds = true }
        BitmapFactory.decodeFile(path, bounds)
        if (bounds.outWidth <= 0) return null
        var sample = 1
        while (bounds.outWidth / (sample * 2) >= maxSize) sample *= 2
        return BitmapFactory.decodeFile(path, BitmapFactory.Options().apply { inSampleSize = sample })
    }
}
