import '../entities/sleep_goal.dart';
import '../../../sleep/domain/entities/sleep_record.dart';

/// Kullanıcının birikmiş uyku borcunu hesaplar.
///
/// Referans: Pilcher & Huffcutt (1996) — 7 günlük pencere yaygın kullanılan modeldir.
class SleepDebtCalculator {
  const SleepDebtCalculator._();

  /// [records] son 14 güne kadar olan kayıtlar.
  /// [goal] kullanıcı hedefi.
  /// [windowDays] kaç günlük pencere hesaba katılsın (varsayılan: 7).
  static SleepDebtResult calculate({
    required List<SleepRecord> records,
    required SleepGoal goal,
    int windowDays = 7,
  }) {
    final window = records.take(windowDays).toList();
    if (window.isEmpty) {
      return SleepDebtResult(
        totalDebtMinutes: 0,
        debtByDay: [],
        projectedRecoveryDays: 0,
        averageDeficitPerNight: 0,
      );
    }

    // Her gün için borç (negatif = fazla uyudu — kredi)
    final debtByDay = window.map((r) {
      final diff = goal.targetDurationMinutes - r.totalDurationMinutes;
      return DayDebt(date: r.date, debtMinutes: diff);
    }).toList();

    // Toplam borç (yalnızca negatif, krediyi 0 olarak say)
    final totalDebt = debtByDay.fold<int>(
      0,
      (sum, d) => sum + (d.debtMinutes > 0 ? d.debtMinutes : 0),
    );

    // Ortalama günlük açık
    final totalDeficit = debtByDay.fold<int>(0, (sum, d) => sum + d.debtMinutes);
    final avgDeficit = window.isEmpty ? 0 : (totalDeficit / window.length).round();

    // Tahmini telafi süresi:
    // Bilimsel limit: geceleri max 90 dk ekstra uyku ile telafi edilebilir
    final maxRecoveryPerNight = 90;
    final projectedDays = totalDebt <= 0
        ? 0
        : (totalDebt / maxRecoveryPerNight).ceil();

    return SleepDebtResult(
      totalDebtMinutes: totalDebt,
      debtByDay: debtByDay,
      projectedRecoveryDays: projectedDays,
      averageDeficitPerNight: avgDeficit,
    );
  }
}

/// Tek günlük borç verisi.
class DayDebt {
  const DayDebt({
    required this.date,
    required this.debtMinutes,
  });

  final DateTime date;

  /// Pozitif → borçlu, negatif → kredi (fazla uyumuş).
  final int debtMinutes;

  bool get isDebt => debtMinutes > 0;
  double get debtHours => debtMinutes / 60;
}

/// `SleepDebtCalculator.calculate` sonucu.
class SleepDebtResult {
  const SleepDebtResult({
    required this.totalDebtMinutes,
    required this.debtByDay,
    required this.projectedRecoveryDays,
    required this.averageDeficitPerNight,
  });

  /// Son [windowDays] içinde biriken toplam borç (dakika).
  final int totalDebtMinutes;

  /// Gün gün borç dökümü.
  final List<DayDebt> debtByDay;

  /// Tahmini telafi edilmesi için gereken ek gece sayısı.
  final int projectedRecoveryDays;

  /// Gecelik ortalama açık (dakika).
  final int averageDeficitPerNight;

  double get totalDebtHours => totalDebtMinutes / 60;

  bool get hasDebt => totalDebtMinutes > 0;

  /// Borç seviyesi: 0 (yok) → 3 (kritik)
  int get debtLevel {
    if (totalDebtMinutes <= 0) return 0;
    if (totalDebtMinutes < 60) return 1;
    if (totalDebtMinutes < 180) return 2;
    return 3;
  }
}
