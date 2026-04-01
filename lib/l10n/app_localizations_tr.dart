// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Turkish (`tr`).
class STr extends S {
  STr([String locale = 'tr']) : super(locale);

  @override
  String get appName => 'Smart Alarm';

  @override
  String get homeTitle => 'Smart Alarm';

  @override
  String get monitoring => 'İzleniyor';

  @override
  String get notMonitoring => 'Pasif';

  @override
  String get nextAlarm => 'Sonraki Alarm';

  @override
  String get noAlarm => 'Alarm yok';

  @override
  String get lastSleep => 'Son Uyku';

  @override
  String get alarms => 'Alarmlar';

  @override
  String get addAlarm => 'Alarm Ekle';

  @override
  String get editAlarm => 'Alarm Düzenle';

  @override
  String get deleteAlarm => 'Alarmı Sil';

  @override
  String get deleteAlarmConfirm =>
      'Bu alarmı silmek istediğinize emin misiniz?';

  @override
  String get automatic => 'Otomatik';

  @override
  String get manual => 'Manuel';

  @override
  String get alarmSet => 'Alarm kuruldu';

  @override
  String get alarmCancelled => 'Alarm iptal edildi';

  @override
  String nAlarms(int count) {
    return '$count alarm';
  }

  @override
  String get goodMorning => 'Günaydın! ☀️';

  @override
  String get youSlept => 'Uyku süreniz';

  @override
  String get hours => 'saat';

  @override
  String get minutes => 'dakika';

  @override
  String get dismiss => 'Kapat';

  @override
  String get snooze => 'Ertele';

  @override
  String snoozeWithDuration(int minutes) {
    return 'Ertele ($minutes dk)';
  }

  @override
  String get settings => 'Ayarlar';

  @override
  String get waitTime => 'Bekleme Süresi';

  @override
  String get waitTimeDesc => 'Uyku algılama için bekleme süresi';

  @override
  String get sleepDuration => 'Uyku Süresi';

  @override
  String get sleepDurationDesc => 'Otomatik alarm için uyku süresi';

  @override
  String get snoozeDuration => 'Erteleme Süresi';

  @override
  String get snoozeDurationDesc => 'Alarm erteleme süresi';

  @override
  String get alarmSound => 'Alarm Sesi';

  @override
  String get alarmSoundDesc => 'Alarm çaldığında çalınacak ses';

  @override
  String get autoDetection => 'Otomatik Algılama';

  @override
  String get autoDetectionDesc => 'Uyku algılamayı otomatik başlat';

  @override
  String get screenModeDetection => 'Ekran Durumu Algılama';

  @override
  String get screenModeDetectionDesc =>
      'Açık: Sadece ekran kapandığında geri sayım başlar\nKapalı: Uygulama içi hareketsizlikte de geri sayım başlar';

  @override
  String get activeTimeRange => 'Çalışma Aralığı';

  @override
  String get activeTimeRangeDesc =>
      'Otomatik alarm algılamanın aktif olacağı saat aralığı';

  @override
  String get activeTimeRangeDialogDesc =>
      'Otomatik uyku algılamanın aktif olacağı saat aralığını seçin. Bu aralık dışında yeni algılama başlamaz, ancak zaten kurulmuş alarmlar etkilenmez.';

  @override
  String get permissionsRequired => 'İzinler Gerekli';

  @override
  String get notificationPermission => 'Bildirim İzni';

  @override
  String get notificationPermissionDesc =>
      'Alarm çalabilmek için bildirim izni gereklidir.';

  @override
  String get exactAlarmPermission => 'Kesin Alarm İzni';

  @override
  String get exactAlarmPermissionDesc =>
      'Alarmların tam zamanında çalması için gereklidir.';

  @override
  String get grant => 'İzin Ver';

  @override
  String get granted => 'Verildi ✓';

  @override
  String get continueText => 'Devam Et';

  @override
  String get cancel => 'İptal';

  @override
  String get save => 'Kaydet';

  @override
  String get delete => 'Sil';

  @override
  String get ok => 'Tamam';

  @override
  String get yes => 'Evet';

  @override
  String get no => 'Hayır';

  @override
  String get retryButton => 'Tekrar Dene';

  @override
  String get noAlarmsYet => 'Henüz alarm yok';

  @override
  String get noAlarmsHint => 'Alarm eklemek için + butonuna basın';

  @override
  String get past => 'Geçmiş';

  @override
  String inTime(String time) {
    return '$time sonra';
  }

  @override
  String get sweetDreams => 'İyi uykular 🌙';

  @override
  String get stop => 'Durdur';

  @override
  String get start => 'Başlat';

  @override
  String get statusSleepDetected => '😴 Uyku algılandı — alarm kuruldu';

  @override
  String get statusAutoDetectionOff => '⏸️ Otomatik algılama kapalı';

  @override
  String get statusOutsideRange =>
      '🕐 Çalışma aralığı dışında — algılama beklemede';

  @override
  String statusScreenOff(String time) {
    return '🌙 Ekran kapalı — $time sonra alarm';
  }

  @override
  String statusInactivity(String time) {
    return '⏳ Hareketsizlik — $time sonra alarm';
  }

  @override
  String get statusScreenOn => '📱 Ekran açık — bekleniyor...';

  @override
  String get statusPhoneInUse => '📱 Telefon kullanılıyor — izleniyor...';

  @override
  String get sleepDetectedSnack => '😴 Uyku algılandı! Otomatik alarm kuruldu.';

  @override
  String get movementDetectedSnack =>
      '🔄 Hareket algılandı — otomatik alarm iptal edildi.';

  @override
  String get sectionGeneral => 'Genel';

  @override
  String get sectionTiming => 'Zamanlama';

  @override
  String get sectionSound => 'Ses';

  @override
  String get sectionAbout => 'Hakkında';

  @override
  String version(String version) {
    return 'Versiyon $version';
  }

  @override
  String get noAlarmSoundFound => 'Alarm sesi bulunamadı';

  @override
  String get defaultAlarmSound => 'Varsayılan Alarm Sesi';

  @override
  String get defaultLabel => 'Varsayılan';

  @override
  String get startLabel => 'Başlangıç';

  @override
  String get endLabel => 'Bitiş';

  @override
  String alarmSetAt(String time) {
    return 'Alarm kuruldu: $time';
  }

  @override
  String youSleptDuration(String duration) {
    return 'Uyku süreniz: $duration';
  }

  @override
  String get formatMinShort => 'dk';

  @override
  String get formatSecShort => 'sn';

  @override
  String get formatHour => 'saat';

  @override
  String get formatHourShort => 'sa';

  @override
  String formatDurationHoursMinutes(int hours, int minutes) {
    return '$hours saat $minutes dakika';
  }

  @override
  String formatDurationHours(int hours) {
    return '$hours saat';
  }

  @override
  String formatDurationMinutes(int minutes) {
    return '$minutes dakika';
  }

  @override
  String get language => 'Dil';

  @override
  String get languageDesc => 'Uygulama dilini değiştir';

  @override
  String get languageSystem => 'Sistem';

  @override
  String get languageTurkish => 'Türkçe';

  @override
  String get languageEnglish => 'English';

  @override
  String get themeMode => 'Tema';

  @override
  String get themeModeDesc => 'Uygulama temasını değiştir';

  @override
  String get themeDark => 'Koyu';

  @override
  String get themeLight => 'Açık';

  @override
  String get themeSystem => 'Sistem';
}
