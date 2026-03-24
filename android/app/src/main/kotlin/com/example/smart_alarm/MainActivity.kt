package com.example.smart_alarm

import android.app.KeyguardManager
import android.content.Context
import android.content.Intent
import android.media.MediaPlayer
import android.media.RingtoneManager
import android.net.Uri
import android.os.PowerManager
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private val CHANNEL = "com.example.smart_alarm/screen_state"
    private val RINGTONE_CHANNEL = "com.example.smart_alarm/ringtone"

    private var mediaPlayer: MediaPlayer? = null
    private var alarmPlayer: MediaPlayer? = null

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        // Ekran durumu kanalı
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)
            .setMethodCallHandler { call, result ->
                when (call.method) {
                    "isScreenOn" -> {
                        val powerManager = getSystemService(Context.POWER_SERVICE) as PowerManager
                        result.success(powerManager.isInteractive)
                    }
                    "isDeviceLocked" -> {
                        val keyguardManager = getSystemService(Context.KEYGUARD_SERVICE) as KeyguardManager
                        result.success(keyguardManager.isDeviceLocked)
                    }
                    "startScreenService" -> {
                        val intent = Intent(this, ScreenStateService::class.java)
                        startService(intent)
                        result.success(true)
                    }
                    "stopScreenService" -> {
                        val intent = Intent(this, ScreenStateService::class.java)
                        stopService(intent)
                        result.success(true)
                    }
                    else -> result.notImplemented()
                }
            }

        // Zil sesi kanalı
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, RINGTONE_CHANNEL)
            .setMethodCallHandler { call, result ->
                when (call.method) {
                    "getRingtones" -> {
                        val typeStr = call.argument<String>("type") ?: "alarm"
                        val type = when (typeStr) {
                            "alarm" -> RingtoneManager.TYPE_ALARM
                            "notification" -> RingtoneManager.TYPE_NOTIFICATION
                            "ringtone" -> RingtoneManager.TYPE_RINGTONE
                            "all" -> RingtoneManager.TYPE_ALL
                            else -> RingtoneManager.TYPE_ALARM
                        }
                        val ringtones = getRingtoneList(type)
                        result.success(ringtones)
                    }
                    "getDefaultAlarmUri" -> {
                        val uri = RingtoneManager.getDefaultUri(RingtoneManager.TYPE_ALARM)
                        result.success(uri?.toString() ?: "")
                    }
                    "playPreview" -> {
                        val uriStr = call.argument<String>("uri")
                        if (uriStr != null) {
                            playRingtonePreview(uriStr)
                            result.success(true)
                        } else {
                            result.error("INVALID_URI", "URI is null", null)
                        }
                    }
                    "stopPreview" -> {
                        stopRingtonePreview()
                        result.success(true)
                    }
                    "playAlarm" -> {
                        val uriStr = call.argument<String>("uri")
                        if (uriStr != null) {
                            playAlarmSound(uriStr)
                            result.success(true)
                        } else {
                            result.error("INVALID_URI", "URI is null", null)
                        }
                    }
                    "stopAlarm" -> {
                        stopAlarmSound()
                        result.success(true)
                    }
                    else -> result.notImplemented()
                }
            }
    }

    private fun getRingtoneList(type: Int): List<Map<String, String>> {
        val list = mutableListOf<Map<String, String>>()

        // Varsayılan alarm sesini ekle
        val defaultUri = RingtoneManager.getDefaultUri(type)
        if (defaultUri != null) {
            list.add(
                mapOf(
                    "title" to "Varsayılan Alarm Sesi",
                    "uri" to defaultUri.toString()
                )
            )
        }

        try {
            val manager = RingtoneManager(this)
            manager.setType(type)
            val cursor = manager.cursor

            while (cursor.moveToNext()) {
                val title = cursor.getString(RingtoneManager.TITLE_COLUMN_INDEX)
                val uri = manager.getRingtoneUri(cursor.position).toString()

                // Varsayılan ile aynı URI değilse ekle (çift kayıt olmasın)
                if (uri != defaultUri?.toString()) {
                    list.add(mapOf("title" to title, "uri" to uri))
                }
            }
        } catch (e: Exception) {
            // Bazı cihazlarda RingtoneManager hata verebilir
            e.printStackTrace()
        }

        return list
    }

    private fun playRingtonePreview(uriStr: String) {
        stopRingtonePreview()
        try {
            mediaPlayer = MediaPlayer().apply {
                setDataSource(this@MainActivity, Uri.parse(uriStr))
                isLooping = false
                prepare()
                start()
            }
        } catch (e: Exception) {
            e.printStackTrace()
        }
    }

    private fun stopRingtonePreview() {
        try {
            mediaPlayer?.apply {
                if (isPlaying) stop()
                release()
            }
            mediaPlayer = null
        } catch (_: Exception) {}
    }

    private fun playAlarmSound(uriStr: String) {
        stopAlarmSound()
        try {
            alarmPlayer = MediaPlayer().apply {
                setDataSource(this@MainActivity, Uri.parse(uriStr))
                isLooping = true
                setAudioAttributes(
                    android.media.AudioAttributes.Builder()
                        .setUsage(android.media.AudioAttributes.USAGE_ALARM)
                        .setContentType(android.media.AudioAttributes.CONTENT_TYPE_SONIFICATION)
                        .build()
                )
                prepare()
                start()
            }
        } catch (e: Exception) {
            e.printStackTrace()
            // Fallback: varsayılan alarm sesi
            try {
                val defaultUri = RingtoneManager.getDefaultUri(RingtoneManager.TYPE_ALARM)
                alarmPlayer = MediaPlayer().apply {
                    setDataSource(this@MainActivity, defaultUri)
                    isLooping = true
                    setAudioAttributes(
                        android.media.AudioAttributes.Builder()
                            .setUsage(android.media.AudioAttributes.USAGE_ALARM)
                            .setContentType(android.media.AudioAttributes.CONTENT_TYPE_SONIFICATION)
                            .build()
                    )
                    prepare()
                    start()
                }
            } catch (e2: Exception) {
                e2.printStackTrace()
            }
        }
    }

    private fun stopAlarmSound() {
        try {
            alarmPlayer?.apply {
                if (isPlaying) stop()
                release()
            }
            alarmPlayer = null
        } catch (_: Exception) {}
    }

    override fun onDestroy() {
        stopRingtonePreview()
        stopAlarmSound()
        super.onDestroy()
    }
}
