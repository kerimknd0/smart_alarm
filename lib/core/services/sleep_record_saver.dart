import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

import '../../features/sleep/data/datasources/sleep_database.dart';
import '../../features/sleep/data/repositories/sleep_repository_impl.dart';
import '../../features/sleep/domain/entities/sleep_record.dart';
import '../../features/sleep/domain/services/sleep_score_engine.dart';

/// Background service veya alarm dismiss akışından çağrılır.
/// Uyku oturumunu puanlar ve veritabanına yazar.
///
/// Bu sınıf izolat dışından (UI izolası veya alarm dismiss)
/// doğrudan çağrılabilir — kendi DB bağlantısını açar.
class SleepRecordSaver {
  SleepRecordSaver._();

  // SharedPreferences anahtarları (background_service.dart ile senkron)
  static const _kSleepStart = 'bg_sleep_start_iso'; // uyku başlangıcı
  static const _kSnoozeCount = 'bg_snooze_count'; // snooze sayacı
  static const _kScreenOnTimes = 'bg_screen_on_times'; // JSON list<iso>

  /// Ekran açılma zamanını kaydet (background_service'den çağrılır).
  static Future<void> recordScreenOn(DateTime time) async {
    final prefs = await SharedPreferences.getInstance();
    final existing = prefs.getStringList(_kScreenOnTimes) ?? [];
    existing.add(time.toIso8601String());
    await prefs.setStringList(_kScreenOnTimes, existing);
  }

  /// Uyku başlangıcını kaydet.
  static Future<void> recordSleepStart(DateTime time) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_kSleepStart, time.toIso8601String());
    await prefs.setInt(_kSnoozeCount, 0);
    await prefs.remove(_kScreenOnTimes);
  }

  /// Snooze sayacını artır.
  static Future<void> incrementSnooze() async {
    final prefs = await SharedPreferences.getInstance();
    final count = prefs.getInt(_kSnoozeCount) ?? 0;
    await prefs.setInt(_kSnoozeCount, count + 1);
  }

  /// Alarm kapatıldığında (dismiss veya snooze-sonrası) uyku kaydını oluştur
  /// ve veritabanına kaydet. [dismissType] alarmın nasıl kapatıldığını belirtir.
  static Future<void> saveSleepRecord({
    required DateTime sleepEnd,
    required DismissType dismissType,
  }) async {
    final prefs = await SharedPreferences.getInstance();

    final sleepStartStr = prefs.getString(_kSleepStart);
    if (sleepStartStr == null) return; // Kayıt başlatılmamış

    final sleepStart = DateTime.tryParse(sleepStartStr);
    if (sleepStart == null) return;

    final snoozeCount = prefs.getInt(_kSnoozeCount) ?? 0;

    // Ekran açma oturumlarını al
    final screenOnStrings = prefs.getStringList(_kScreenOnTimes) ?? [];
    final sessions = <SleepSession>[];
    for (final s in screenOnStrings) {
      final t = DateTime.tryParse(s);
      if (t != null) {
        sessions.add(SleepSession(
          timestamp: t,
          type: SleepSessionType.screenOn,
        ));
      }
    }

    final totalDuration = sleepEnd.difference(sleepStart).inMinutes;
    if (totalDuration < 10) return; // Çok kısa — kaydetme

    // Skor hesapla (tutarlılık için son 7 kayıt gerekiyor — basit veri yoksa 0 kullan)
    // Repository bağımsız çalışabilmek için score engine'i doğrudan kullanıyoruz
    final scoreResult = SleepScoreEngine.calculate(
      totalDurationMinutes: totalDuration,
      wakeCount: sessions.length,
      sessions: sessions,
      sleepStart: sleepStart,
      sleepEnd: sleepEnd,
      dismissType: dismissType,
      snoozeCount: snoozeCount,
      recentRecords: const [], // İlk kayıt veya bağımsız hesap
    );

    final now = DateTime.now();
    final record = SleepRecord(
      id: const Uuid().v4(),
      date: DateTime(sleepStart.year, sleepStart.month, sleepStart.day),
      sleepStart: sleepStart,
      sleepEnd: sleepEnd,
      totalDurationMinutes: totalDuration,
      score: scoreResult.total,
      wakeCount: sessions.length,
      snoozeCount: snoozeCount,
      dismissType: dismissType,
      sessions: sessions,
      createdAt: now,
    );

    // Veritabanına yaz
    try {
      final db = SleepDatabase();
      final repo = SleepRepositoryImpl(db);
      await repo.saveSleepRecord(record);
      await db.close();
    } catch (e) {
      // Sessizce geç — uyku kaydı kritik değil
    }

    // SharedPreferences'ı temizle
    await prefs.remove(_kSleepStart);
    await prefs.remove(_kSnoozeCount);
    await prefs.remove(_kScreenOnTimes);
  }
}
