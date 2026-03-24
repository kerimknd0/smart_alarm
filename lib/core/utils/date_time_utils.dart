import 'package:intl/intl.dart';

/// Tarih ve saat formatlama yardımcıları.
class DateTimeUtils {
  DateTimeUtils._();

  /// Saat:Dakika formatı (ör: 07:30)
  static String formatTime(DateTime dateTime) {
    return DateFormat('HH:mm').format(dateTime);
  }

  /// Tarih formatı (ör: 18 Mart 2026)
  static String formatDate(DateTime dateTime) {
    return DateFormat('d MMMM yyyy', 'tr_TR').format(dateTime);
  }

  /// Kısa tarih formatı (ör: 18 Mar)
  static String formatShortDate(DateTime dateTime) {
    return DateFormat('d MMM', 'tr_TR').format(dateTime);
  }

  /// Saat ve kısa tarih (ör: 07:30 - 18 Mar)
  static String formatTimeWithDate(DateTime dateTime) {
    return '${formatTime(dateTime)} - ${formatShortDate(dateTime)}';
  }

  /// Duration'ı okunabilir formata çevirir (ör: "7 saat 30 dakika")
  static String formatDuration(Duration duration) {
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);

    if (hours > 0 && minutes > 0) {
      return '$hours saat $minutes dakika';
    } else if (hours > 0) {
      return '$hours saat';
    } else {
      return '$minutes dakika';
    }
  }

  /// İki tarih arası süreyi hesaplar ve formatlar.
  static String timeBetween(DateTime start, DateTime end) {
    final duration = end.difference(start);
    return formatDuration(duration);
  }

  /// Alarm zamanına ne kadar kaldığını hesaplar (ör: "3 saat 15 dk")
  static String timeUntil(DateTime alarmTime) {
    final now = DateTime.now();
    if (alarmTime.isBefore(now)) return 'Geçmiş';
    final duration = alarmTime.difference(now);
    return formatDuration(duration);
  }
}
