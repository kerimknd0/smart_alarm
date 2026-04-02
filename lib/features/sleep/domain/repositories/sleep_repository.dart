import '../entities/sleep_analysis.dart';
import '../entities/sleep_record.dart';

/// Uyku kayıt repository arayüzü.
abstract class SleepRepository {
  /// Yeni bir uyku kaydı kaydeder.
  Future<void> saveSleepRecord(SleepRecord record);

  /// Belirtilen tarihe ait kaydı döndürür. Yoksa null.
  Future<SleepRecord?> getSleepRecordByDate(DateTime date);

  /// Son [limit] kaydı yeniden eskiye sıralar.
  Future<List<SleepRecord>> getSleepHistory({int limit = 30});

  /// Belirli tarih aralığındaki kayıtları döndürür.
  Future<List<SleepRecord>> getSleepRecordsBetween({
    required DateTime from,
    required DateTime to,
  });

  /// [weekStart] ile başlayan haftanın istatistiklerini döndürür.
  Future<WeeklySleepStats?> getWeeklyStats(DateTime weekStart);

  /// Tüm anomalileri döndürür (son 30 günden).
  Future<List<SleepAnomaly>> getAnomalies();

  /// Tüm kayıtları siler (test / debug).
  Future<void> clearAll();
}
