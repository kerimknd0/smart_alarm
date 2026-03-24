package com.example.smart_alarm

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import java.text.SimpleDateFormat
import java.util.Date
import java.util.Locale

/**
 * Ekran açılma/kapanma olaylarını dinler ve
 * SharedPreferences'a yazar. Arka plan servisi (Dart isolate)
 * bu değeri okuyarak gerçek ekran durumunu öğrenir.
 */
class ScreenStateReceiver : BroadcastReceiver() {

    companion object {
        // Dart tarafındaki _prefScreenState ile aynı key
        // Flutter shared_preferences Android'de "FlutterSharedPreferences"
        // dosyasına "flutter." prefix'i ile yazar.
        private const val PREF_NAME = "FlutterSharedPreferences"
        private const val KEY_SCREEN_STATE = "flutter.bg_screen_state"
        private const val KEY_SCREEN_OFF_TIME = "flutter.bg_screen_off_time"
        private const val KEY_LAST_INTERACTION = "flutter.bg_last_interaction"
        private const val KEY_SLEEP_DETECTED = "flutter.bg_sleep_detected"
        private const val KEY_ALARM_FIRING = "flutter.bg_alarm_firing"
    }

    private fun nowIso(): String {
        // Dart'ın DateTime.now().toIso8601String() ile uyumlu format
        val sdf = SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS", Locale.US)
        return sdf.format(Date())
    }

    override fun onReceive(context: Context, intent: Intent) {
        val prefs = context.getSharedPreferences(PREF_NAME, Context.MODE_PRIVATE)
        val now = nowIso()

        // Alarm çalıyorsa ekran olayları ile state'i bozmayalım
        val isAlarmFiring = prefs.getBoolean(KEY_ALARM_FIRING, false)

        when (intent.action) {
            Intent.ACTION_SCREEN_OFF -> {
                if (!isAlarmFiring) {
                    val editor = prefs.edit()
                    editor.putString(KEY_SCREEN_STATE, "off")
                    editor.putString(KEY_SCREEN_OFF_TIME, now)
                    editor.apply()
                }
            }
            Intent.ACTION_SCREEN_ON -> {
                if (!isAlarmFiring) {
                    val editor = prefs.edit()
                    editor.putString(KEY_SCREEN_STATE, "on")
                    editor.remove(KEY_SCREEN_OFF_TIME)
                    editor.putString(KEY_LAST_INTERACTION, now)
                    editor.putBoolean(KEY_SLEEP_DETECTED, false)
                    editor.apply()
                }
            }
            Intent.ACTION_USER_PRESENT -> {
                if (!isAlarmFiring) {
                    val editor = prefs.edit()
                    // Kullanıcı kilit ekranını açtı
                    editor.putString(KEY_SCREEN_STATE, "on")
                    editor.remove(KEY_SCREEN_OFF_TIME)
                    editor.putString(KEY_LAST_INTERACTION, now)
                    editor.putBoolean(KEY_SLEEP_DETECTED, false)
                    editor.apply()
                }
            }
        }
    }
}
