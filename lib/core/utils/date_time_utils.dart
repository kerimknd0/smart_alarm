import 'package:intl/intl.dart';

/// Tarih ve saat formatlama yardımcıları.
class DateTimeUtils {
  DateTimeUtils._();

  /// Saat:Dakika formatı (ör: 07:30)
  static String formatTime(DateTime dateTime) {
    return DateFormat('HH:mm').format(dateTime);
  }

  /// Tarih formatı (ör: 18 Mart 2026)
  static String formatDate(DateTime dateTime, [String? locale]) {
    return DateFormat('d MMMM yyyy', locale ?? Intl.getCurrentLocale()).format(dateTime);
  }

  /// Kısa tarih formatı (ör: 18 Mar)
  static String formatShortDate(DateTime dateTime, [String? locale]) {
    return DateFormat('d MMM', locale ?? Intl.getCurrentLocale()).format(dateTime);
  }

  /// Saat ve kısa tarih (ör: 07:30 - 18 Mar)
  static String formatTimeWithDate(DateTime dateTime, [String? locale]) {
    return '${formatTime(dateTime)} - ${formatShortDate(dateTime, locale)}';
  }

  /// Duration'ı okunabilir formata çevirir (ör: "7 saat 30 dakika")
  /// [hourLabel] ve [minuteLabel] l10n'den gelmelidir.
  static String formatDuration(
    Duration duration, {
    String hourLabel = 'saat',
    String minuteLabel = 'dakika',
  }) {
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);

    if (hours > 0 && minutes > 0) {
      return '$hours $hourLabel $minutes $minuteLabel';
    } else if (hours > 0) {
      return '$hours $hourLabel';
    } else {
      return '$minutes $minuteLabel';
    }
  }

  /// İki tarih arası süreyi hesaplar ve formatlar.
  static String timeBetween(
    DateTime start,
    DateTime end, {
    String hourLabel = 'saat',
    String minuteLabel = 'dakika',
  }) {
    final duration = end.difference(start);
    return formatDuration(duration, hourLabel: hourLabel, minuteLabel: minuteLabel);
  }

  /// Alarm zamanına ne kadar kaldığını hesaplar (ör: "3 saat 15 dk")
  /// [pastLabel] geçmiş alarmlar için döndürülen metin.
  static String timeUntil(
    DateTime alarmTime, {
    String pastLabel = 'Geçmiş',
    String hourLabel = 'saat',
    String minuteLabel = 'dakika',
  }) {
    final now = DateTime.now();
    if (alarmTime.isBefore(now)) return pastLabel;
    final duration = alarmTime.difference(now);
    return formatDuration(duration, hourLabel: hourLabel, minuteLabel: minuteLabel);
  }
}
