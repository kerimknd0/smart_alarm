package com.example.smart_alarm

import android.app.Service
import android.content.Intent
import android.content.IntentFilter
import android.os.IBinder

/**
 * Ekran durumu dinleme servisi.
 * flutter_background_service başlatıldığında bu servis de başlatılır.
 * ACTION_SCREEN_OFF / ACTION_SCREEN_ON eventlerini dinler.
 */
class ScreenStateService : Service() {

    private var receiver: ScreenStateReceiver? = null

    override fun onCreate() {
        super.onCreate()
        receiver = ScreenStateReceiver()
        val filter = IntentFilter().apply {
            addAction(Intent.ACTION_SCREEN_OFF)
            addAction(Intent.ACTION_SCREEN_ON)
            addAction(Intent.ACTION_USER_PRESENT)
        }
        registerReceiver(receiver, filter)

        // Alarm ses servisini de başlat
        val soundIntent = Intent(this, AlarmSoundService::class.java)
        startService(soundIntent)
    }

    override fun onStartCommand(intent: Intent?, flags: Int, startId: Int): Int {
        return START_STICKY
    }

    override fun onDestroy() {
        super.onDestroy()
        receiver?.let {
            unregisterReceiver(it)
        }
        receiver = null

        // Alarm ses servisini de durdur
        val soundIntent = Intent(this, AlarmSoundService::class.java)
        stopService(soundIntent)
    }

    override fun onBind(intent: Intent?): IBinder? = null
}
