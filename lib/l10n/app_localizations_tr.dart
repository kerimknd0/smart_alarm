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

  @override
  String get sleepAnalysis => 'Uyku Analizi';

  @override
  String get sleepAnalysisTooltip => 'Uyku Analizi';

  @override
  String get lastNight => 'Dün Gece';

  @override
  String get thisWeek => 'Bu Hafta';

  @override
  String get alerts => 'Uyarılar';

  @override
  String get viewAllHistory => 'Tüm Geçmişi Gör';

  @override
  String get noSleepRecordYet => 'Henüz Uyku Kaydı Yok';

  @override
  String get noSleepRecordHint =>
      'Alarmı kullandıktan sonra\nuyku analizin burada görünecek.';

  @override
  String get viewDetails => 'Detayları gör';

  @override
  String get sleepDurationLabel => 'Süre';

  @override
  String get wakeCount => 'Uyanma';

  @override
  String get efficiency => 'Verimlilik';

  @override
  String get avgScore => 'Ort. Skor';

  @override
  String get avgDuration => 'Ort. Süre';

  @override
  String get recordCount => 'Kayıt';

  @override
  String get nightsUnit => 'gece';

  @override
  String get timesUnit => 'kez';

  @override
  String get detailBedTime => 'Yatış';

  @override
  String get detailWakeTime => 'Kalkış';

  @override
  String get scoreDetail => 'Skor Detayı';

  @override
  String get scoreMotion => 'Hareket';

  @override
  String get scoreConsistency => 'Tutarlılık';

  @override
  String get scoreAlarmResponse => 'Alarm Tepkisi';

  @override
  String get remCycles => 'REM Döngüleri (Tahmini)';

  @override
  String get noRemData => 'Yeterli veri yok.';

  @override
  String get lightSleepWindow => 'Hafif uyku penceresi';

  @override
  String get nightWakeups => 'Gece Uyanmaları';

  @override
  String get screenTurnedOn => 'Ekran açıldı';

  @override
  String get dayMon => 'Pzt';

  @override
  String get dayTue => 'Sal';

  @override
  String get dayWed => 'Çar';

  @override
  String get dayThu => 'Per';

  @override
  String get dayFri => 'Cum';

  @override
  String get daySat => 'Cmt';

  @override
  String get daySun => 'Paz';

  @override
  String get monthJan => 'Oca';

  @override
  String get monthFeb => 'Şub';

  @override
  String get monthMar => 'Mar';

  @override
  String get monthApr => 'Nis';

  @override
  String get monthMay => 'May';

  @override
  String get monthJun => 'Haz';

  @override
  String get monthJul => 'Tem';

  @override
  String get monthAug => 'Ağu';

  @override
  String get monthSep => 'Eyl';

  @override
  String get monthOct => 'Eki';

  @override
  String get monthNov => 'Kas';

  @override
  String get monthDec => 'Ara';

  @override
  String get anomalyInsufficientSleepTitle => 'Yetersiz Uyku';

  @override
  String anomalyInsufficientSleepDesc(int count) {
    return 'Son $count gece 5 saatten az uyudunuz. Bu durum sağlığınızı olumsuz etkileyebilir.';
  }

  @override
  String get anomalyScoreDropTitle => 'Uyku Kalitesi Düştü';

  @override
  String anomalyScoreDropDesc(int score, int avg) {
    return 'Dünkü uyku skoru ($score), 7 günlük ortalamanızın ($avg) çok altında.';
  }

  @override
  String get anomalyFrequentWakingTitle => 'Sık Uyanma';

  @override
  String anomalyFrequentWakingDesc(int count) {
    return 'Son 7 gecede $count gece 3 veya daha fazla kez uyandınız.';
  }

  @override
  String get anomalySocialJetLagTitle => 'Sosyal Jet Lag';

  @override
  String anomalySocialJetLagDesc(String weekend) {
    return 'Hafta sonu ortalamanız (${weekend}s), hafta içinden 3 saatten fazla. Bu biyolojik saatinizi bozabilir.';
  }

  @override
  String get anomalyBedtimeShiftTitle => 'Düzensiz Yatış Saati';

  @override
  String get anomalyBedtimeShiftDesc =>
      'Son 7 günde yatış saatiniz 2 saatten fazla değişiyor. Düzenli bir uyku rutini oluşturmaya çalışın.';

  @override
  String get anomalyExcessiveSnoozeTitle => 'Fazla Erteleme';

  @override
  String anomalyExcessiveSnoozeDesc(int count) {
    return 'Bu sabah alarmı $count kez ertelediniz. Bu, uyku kalitenizin düşük olduğuna işaret edebilir.';
  }

  @override
  String get anomalyStreakTitle => '7 Günlük Mükemmel Uyku! 🌟';

  @override
  String get anomalyStreakDesc =>
      'Son 7 gece uyku skorunuz 80\'in üzerinde. Harika bir uyku rutini kurmuşsunuz!';

  @override
  String get anomalyImprovementTitle => 'Uyku Kaliteniz Arttı! 📈';

  @override
  String anomalyImprovementDesc(int thisWeek, int lastWeek) {
    return 'Bu haftaki ortalama skorunuz ($thisWeek), geçen haftaya ($lastWeek) göre önemli ölçüde arttı.';
  }

  @override
  String get coachTitle => 'AI Uyku Koçu';

  @override
  String get coachSubtitle =>
      'Uyku verilerinize dayalı kişiselleştirilmiş öneriler';

  @override
  String get coachNoData => 'Henüz uyku verisi yok';

  @override
  String get coachNoDataHint =>
      'Kişiselleştirilmiş öneriler almak için uyku takibine başlayın.';

  @override
  String get sleepGoalTitle => 'Uyku Hedefi';

  @override
  String get setGoal => 'Hedef Belirle';

  @override
  String get editGoal => 'Hedefi Düzenle';

  @override
  String get yourGoal => 'Hedefiniz';

  @override
  String get goalNotSet => 'Hedef belirlenmedi';

  @override
  String get goalProgress => 'Hedef İlerleme';

  @override
  String daysAchievedLabel(int achieved, int total) {
    return '$achieved / $total gece';
  }

  @override
  String currentStreakLabel(int streak) {
    return '$streak gece serisi';
  }

  @override
  String get sleepDebtTitle => 'Uyku Borcu';

  @override
  String sleepDebtValue(String hours) {
    return '$hours saat borç';
  }

  @override
  String get noDebt => 'Borç yok 🎉';

  @override
  String debtRecovery(int days) {
    return 'Telafi için ~$days gece';
  }

  @override
  String get targetDuration => 'Hedef Süre';

  @override
  String get targetBedtime => 'Hedef Yatış Saati';

  @override
  String get targetWakeTime => 'Hedef Uyanış Saati';

  @override
  String get targetScore => 'Hedef Skor';

  @override
  String get notSet => 'Belirtilmedi';

  @override
  String hoursMinutesLabel(int h, int m) {
    return '${h}s ${m}dk';
  }

  @override
  String get advicesTitle => 'Öneriler';

  @override
  String get noAdvices => 'Öneri yok';

  @override
  String get noAdvicesHint => 'Uykunuz harika görünüyor! Böyle devam edin.';

  @override
  String get advicePriorityHigh => 'Yüksek';

  @override
  String get advicePriorityMedium => 'Orta';

  @override
  String get advicePriorityLow => 'Düşük';

  @override
  String get adviceCategoryDuration => 'Süre';

  @override
  String get adviceCategoryQuality => 'Kalite';

  @override
  String get adviceCategoryConsistency => 'Tutarlılık';

  @override
  String get adviceCategoryHabit => 'Alışkanlık';

  @override
  String get adviceCategoryAchievement => 'Başarı';

  @override
  String get adviceBedtimeTooLateTitle => 'Geç Yatış';

  @override
  String adviceBedtimeTooLateDesc(int diffMinutes, String targetBedtime) {
    return 'Hedefinizden $diffMinutes dakika geç yatıyorsunuz ($targetBedtime). Bu gece $targetBedtime\'de yatmayı deneyin.';
  }

  @override
  String get adviceBedtimeTooEarlyTitle => 'Erken Yatış';

  @override
  String adviceBedtimeTooEarlyDesc(String avgBedtime, String targetBedtime) {
    return 'Hedefinizden erken yatıyorsunuz. Ortalama: $avgBedtime, Hedef: $targetBedtime.';
  }

  @override
  String get adviceSleepDurationShortTitle => 'Yetersiz Uyku';

  @override
  String adviceSleepDurationShortDesc(int shortfallMinutes) {
    return 'Hedefinizden $shortfallMinutes dakika az uyuyorsunuz. $shortfallMinutes dakika erken yatmayı deneyin.';
  }

  @override
  String get adviceSleepDurationLongTitle => 'Aşırı Uyku';

  @override
  String adviceSleepDurationLongDesc(int excessMinutes) {
    return 'Optimal süreden $excessMinutes dakika fazla uyuyorsunuz. Düzenli uyanış saati enerji seviyenizi artırır.';
  }

  @override
  String get adviceReduceSnoozeTitle => 'Erteleme Bağımlılığı';

  @override
  String adviceReduceSnoozeDesc(String avgSnooze) {
    return 'Geceleri ortalama $avgSnooze kez alarm erteliyorsunuz. Parçalı uyku, uyku kalitesini düşürür.';
  }

  @override
  String get adviceReduceWakeupsTitle => 'Sık Gece Uyanması';

  @override
  String adviceReduceWakeupsDesc(String avgWakeCount) {
    return 'Geceleri ortalama $avgWakeCount kez uyanıyorsunuz. Uyumadan önce ekran ve kafein tüketimini azaltın.';
  }

  @override
  String get adviceImproveEfficiencyTitle => 'Düşük Uyku Verimliliği';

  @override
  String adviceImproveEfficiencyDesc(int avgEfficiency) {
    return 'Uyku verimliliğiniz %$avgEfficiency. Uyumadan önce ekran kullanımından kaçınmak yardımcı olabilir.';
  }

  @override
  String get adviceInconsistentBedtimeTitle => 'Düzensiz Uyku Saati';

  @override
  String adviceInconsistentBedtimeDesc(int varianceMinutes) {
    return 'Yatış saatiniz $varianceMinutes dakika değişkenlik gösteriyor. Tutarlı uyku saatleri sirkadiyen ritminizi destekler.';
  }

  @override
  String get adviceSocialJetLagTitle => 'Sosyal Jet Lag Uyarısı';

  @override
  String adviceSocialJetLagDesc(int diffMinutes) {
    return 'Hafta içi ve hafta sonu yatış saatleriniz arasında $diffMinutes dakika fark var. Bu sirkadiyen ritminizi bozuyor.';
  }

  @override
  String get adviceSleepDebtTitle => 'Uyku Borcu Birikyor';

  @override
  String adviceSleepDebtDesc(String debtHours) {
    return 'Son 7 günde $debtHours saat uyku borcu biriktirdiniz. Daha erken yatmayı deneyin.';
  }

  @override
  String get adviceGreatStreakTitle => 'Muhteşem Seri! 🏆';

  @override
  String adviceGreatStreakDesc(int streak) {
    return '$streak gece üst üste uyku hedefinizi tutturdunuz. Böyle devam edin!';
  }

  @override
  String get adviceGoalAchievedTitle => 'Hedefe Ulaşıldı! ✅';

  @override
  String get adviceGoalAchievedDesc =>
      'Dün gece uyku hedefinizi tutturdunuz. Harika iş!';

  @override
  String get advicePersonalBestTitle => 'Kişisel Rekor! 🌟';

  @override
  String get advicePersonalBestDesc =>
      'Dün gece şimdiye kadarki en iyi uyku kalitenizdi. Bunu sürdürün!';

  @override
  String get adviceImprovingTrendTitle => 'Gelişen Trend! 📈';

  @override
  String adviceImprovingTrendDesc(int oldAvg, int newAvg) {
    return 'Bu hafta ortalama skorunuz $oldAvg\'den $newAvg\'ye yükseldi. Harika ilerleme!';
  }

  @override
  String get saveGoalButton => 'Hedefi Kaydet';

  @override
  String get durationSliderLabel => 'Uyku Süresi';

  @override
  String get bedtimePickerLabel => 'Yatış Saati';

  @override
  String get wakeTimePickerLabel => 'Uyanış Saati';

  @override
  String get scoreSliderLabel => 'Hedef Skor';

  @override
  String get goalSavedMessage => 'Hedef kaydedildi!';

  @override
  String get coachEntryButton => 'AI Koç';

  @override
  String completionRateLabel(int rate) {
    return '%$rate başarı oranı';
  }
}
