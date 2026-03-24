/// Uygulama genelinde kullanılan metin sabitleri (Türkçe).
class AppStrings {
  AppStrings._();

  // Genel
  static const String appName = 'Smart Alarm';

  // Ana Ekran
  static const String homeTitle = 'Smart Alarm';
  static const String monitoring = 'İzleniyor';
  static const String notMonitoring = 'Pasif';
  static const String nextAlarm = 'Sonraki Alarm';
  static const String noAlarm = 'Alarm yok';
  static const String lastSleep = 'Son Uyku';

  // Alarm
  static const String alarms = 'Alarmlar';
  static const String addAlarm = 'Alarm Ekle';
  static const String editAlarm = 'Alarm Düzenle';
  static const String deleteAlarm = 'Alarmı Sil';
  static const String deleteAlarmConfirm =
      'Bu alarmı silmek istediğinize emin misiniz?';
  static const String automatic = 'Otomatik';
  static const String manual = 'Manuel';
  static const String alarmSet = 'Alarm kuruldu';
  static const String alarmCancelled = 'Alarm iptal edildi';

  // Alarm Çalıyor Ekranı
  static const String goodMorning = 'Günaydın! ☀️';
  static const String youSlept = 'Uyku süreniz';
  static const String hours = 'saat';
  static const String minutes = 'dakika';
  static const String dismiss = 'Kapat';
  static const String snooze = 'Ertele';

  // Ayarlar
  static const String settings = 'Ayarlar';
  static const String waitTime = 'Bekleme Süresi';
  static const String waitTimeDesc = 'Uyku algılama için bekleme süresi';
  static const String sleepDuration = 'Uyku Süresi';
  static const String sleepDurationDesc = 'Otomatik alarm için uyku süresi';
  static const String snoozeDuration = 'Erteleme Süresi';
  static const String snoozeDurationDesc = 'Alarm erteleme süresi';
  static const String alarmSound = 'Alarm Sesi';
  static const String autoDetection = 'Otomatik Algılama';
  static const String autoDetectionDesc = 'Uyku algılamayı otomatik başlat';

  // İzin
  static const String permissionsRequired = 'İzinler Gerekli';
  static const String notificationPermission = 'Bildirim İzni';
  static const String notificationPermissionDesc =
      'Alarm çalabilmek için bildirim izni gereklidir.';
  static const String exactAlarmPermission = 'Kesin Alarm İzni';
  static const String exactAlarmPermissionDesc =
      'Alarmların tam zamanında çalması için gereklidir.';
  static const String grant = 'İzin Ver';
  static const String granted = 'Verildi ✓';
  static const String continueText = 'Devam Et';

  // Genel butonlar
  static const String cancel = 'İptal';
  static const String save = 'Kaydet';
  static const String delete = 'Sil';
  static const String ok = 'Tamam';
  static const String yes = 'Evet';
  static const String no = 'Hayır';
}
