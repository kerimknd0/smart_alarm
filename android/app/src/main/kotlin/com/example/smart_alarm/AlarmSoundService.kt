package com.example.smart_alarm

import android.app.Service
import android.content.Context
import android.content.Intent
import android.content.SharedPreferences
import android.media.AudioAttributes
import android.media.MediaPlayer
import android.media.RingtoneManager
import android.net.Uri
import android.os.IBinder
import android.util.Log

/**
 * Alarm sesi çalan native Android servisi.
 *
 * SharedPreferences'taki "flutter.bg_alarm_firing" değerini dinler.
 * true olduğunda sesi başlatır, false olduğunda durdurur.
 *
 * ScreenStateService içinden de başlatılabilir veya doğrudan
 * ScreenStateReceiver'dan tetiklenebilir.
 */
class AlarmSoundService : Service() {

    companion object {
        private const val TAG = "AlarmSoundService"
        private const val PREF_NAME = "FlutterSharedPreferences"
        private const val KEY_ALARM_FIRING = "flutter.bg_alarm_firing"
        private const val KEY_ALARM_SOUND = "flutter.pref_alarm_sound"
    }

    private var mediaPlayer: MediaPlayer? = null
    private var prefsListener: SharedPreferences.OnSharedPreferenceChangeListener? = null

    override fun onCreate() {
        super.onCreate()
        Log.d(TAG, "AlarmSoundService created")

        val prefs = getSharedPreferences(PREF_NAME, Context.MODE_PRIVATE)

        // Servis başladığında alarm çalıyor mu kontrol et
        checkAndPlayAlarm(prefs)

        // SharedPreferences değişikliklerini dinle
        prefsListener = SharedPreferences.OnSharedPreferenceChangeListener { sp, key ->
            if (key == KEY_ALARM_FIRING) {
                checkAndPlayAlarm(sp)
            }
        }
        prefs.registerOnSharedPreferenceChangeListener(prefsListener)
    }

    private fun checkAndPlayAlarm(prefs: SharedPreferences) {
        val isFiring = prefs.getBoolean(KEY_ALARM_FIRING, false)
        Log.d(TAG, "checkAndPlayAlarm: isFiring=$isFiring, isPlaying=${mediaPlayer?.isPlaying}")

        if (isFiring) {
            if (mediaPlayer == null || mediaPlayer?.isPlaying == false) {
                startAlarmSound(prefs)
            }
        } else {
            stopAlarmSound()
        }
    }

    private fun startAlarmSound(prefs: SharedPreferences) {
        stopAlarmSound()

        val soundUri = prefs.getString(KEY_ALARM_SOUND, null)
        val uri: Uri = if (soundUri != null && soundUri != "default" && soundUri.isNotEmpty()) {
            Uri.parse(soundUri)
        } else {
            RingtoneManager.getDefaultUri(RingtoneManager.TYPE_ALARM)
                ?: RingtoneManager.getDefaultUri(RingtoneManager.TYPE_NOTIFICATION)
                ?: RingtoneManager.getDefaultUri(RingtoneManager.TYPE_RINGTONE)
        }

        Log.d(TAG, "Starting alarm sound: $uri")

        try {
            mediaPlayer = MediaPlayer().apply {
                setDataSource(this@AlarmSoundService, uri)
                setAudioAttributes(
                    AudioAttributes.Builder()
                        .setUsage(AudioAttributes.USAGE_ALARM)
                        .setContentType(AudioAttributes.CONTENT_TYPE_SONIFICATION)
                        .build()
                )
                isLooping = true
                prepare()
                start()
            }
            Log.d(TAG, "Alarm sound started successfully")
        } catch (e: Exception) {
            Log.e(TAG, "Failed to play alarm sound: ${e.message}", e)
            // Fallback: varsayılan alarm sesi
            try {
                val defaultUri = RingtoneManager.getDefaultUri(RingtoneManager.TYPE_ALARM)
                if (defaultUri != null) {
                    mediaPlayer = MediaPlayer().apply {
                        setDataSource(this@AlarmSoundService, defaultUri)
                        setAudioAttributes(
                            AudioAttributes.Builder()
                                .setUsage(AudioAttributes.USAGE_ALARM)
                                .setContentType(AudioAttributes.CONTENT_TYPE_SONIFICATION)
                                .build()
                        )
                        isLooping = true
                        prepare()
                        start()
                    }
                    Log.d(TAG, "Fallback alarm sound started")
                }
            } catch (e2: Exception) {
                Log.e(TAG, "Fallback alarm sound also failed: ${e2.message}", e2)
            }
        }
    }

    private fun stopAlarmSound() {
        try {
            mediaPlayer?.apply {
                if (isPlaying) stop()
                release()
            }
        } catch (e: Exception) {
            Log.e(TAG, "Error stopping alarm: ${e.message}")
        }
        mediaPlayer = null
    }

    override fun onStartCommand(intent: Intent?, flags: Int, startId: Int): Int {
        // Servis yeniden başlatıldığında tekrar kontrol et
        val prefs = getSharedPreferences(PREF_NAME, Context.MODE_PRIVATE)
        checkAndPlayAlarm(prefs)
        return START_STICKY
    }

    override fun onDestroy() {
        Log.d(TAG, "AlarmSoundService destroyed")
        stopAlarmSound()
        val prefs = getSharedPreferences(PREF_NAME, Context.MODE_PRIVATE)
        prefsListener?.let { prefs.unregisterOnSharedPreferenceChangeListener(it) }
        prefsListener = null
        super.onDestroy()
    }

    override fun onBind(intent: Intent?): IBinder? = null
}
