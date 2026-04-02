import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_tr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of S
/// returned by `S.of(context)`.
///
/// Applications need to include `S.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: S.localizationsDelegates,
///   supportedLocales: S.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the S.supportedLocales
/// property.
abstract class S {
  S(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static S of(BuildContext context) {
    return Localizations.of<S>(context, S)!;
  }

  static const LocalizationsDelegate<S> delegate = _SDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('tr'),
  ];

  /// No description provided for @appName.
  ///
  /// In tr, this message translates to:
  /// **'Smart Alarm'**
  String get appName;

  /// No description provided for @homeTitle.
  ///
  /// In tr, this message translates to:
  /// **'Smart Alarm'**
  String get homeTitle;

  /// No description provided for @monitoring.
  ///
  /// In tr, this message translates to:
  /// **'İzleniyor'**
  String get monitoring;

  /// No description provided for @notMonitoring.
  ///
  /// In tr, this message translates to:
  /// **'Pasif'**
  String get notMonitoring;

  /// No description provided for @nextAlarm.
  ///
  /// In tr, this message translates to:
  /// **'Sonraki Alarm'**
  String get nextAlarm;

  /// No description provided for @noAlarm.
  ///
  /// In tr, this message translates to:
  /// **'Alarm yok'**
  String get noAlarm;

  /// No description provided for @lastSleep.
  ///
  /// In tr, this message translates to:
  /// **'Son Uyku'**
  String get lastSleep;

  /// No description provided for @alarms.
  ///
  /// In tr, this message translates to:
  /// **'Alarmlar'**
  String get alarms;

  /// No description provided for @addAlarm.
  ///
  /// In tr, this message translates to:
  /// **'Alarm Ekle'**
  String get addAlarm;

  /// No description provided for @editAlarm.
  ///
  /// In tr, this message translates to:
  /// **'Alarm Düzenle'**
  String get editAlarm;

  /// No description provided for @deleteAlarm.
  ///
  /// In tr, this message translates to:
  /// **'Alarmı Sil'**
  String get deleteAlarm;

  /// No description provided for @deleteAlarmConfirm.
  ///
  /// In tr, this message translates to:
  /// **'Bu alarmı silmek istediğinize emin misiniz?'**
  String get deleteAlarmConfirm;

  /// No description provided for @automatic.
  ///
  /// In tr, this message translates to:
  /// **'Otomatik'**
  String get automatic;

  /// No description provided for @manual.
  ///
  /// In tr, this message translates to:
  /// **'Manuel'**
  String get manual;

  /// No description provided for @alarmSet.
  ///
  /// In tr, this message translates to:
  /// **'Alarm kuruldu'**
  String get alarmSet;

  /// No description provided for @alarmCancelled.
  ///
  /// In tr, this message translates to:
  /// **'Alarm iptal edildi'**
  String get alarmCancelled;

  /// No description provided for @nAlarms.
  ///
  /// In tr, this message translates to:
  /// **'{count} alarm'**
  String nAlarms(int count);

  /// No description provided for @goodMorning.
  ///
  /// In tr, this message translates to:
  /// **'Günaydın! ☀️'**
  String get goodMorning;

  /// No description provided for @youSlept.
  ///
  /// In tr, this message translates to:
  /// **'Uyku süreniz'**
  String get youSlept;

  /// No description provided for @hours.
  ///
  /// In tr, this message translates to:
  /// **'saat'**
  String get hours;

  /// No description provided for @minutes.
  ///
  /// In tr, this message translates to:
  /// **'dakika'**
  String get minutes;

  /// No description provided for @dismiss.
  ///
  /// In tr, this message translates to:
  /// **'Kapat'**
  String get dismiss;

  /// No description provided for @snooze.
  ///
  /// In tr, this message translates to:
  /// **'Ertele'**
  String get snooze;

  /// No description provided for @snoozeWithDuration.
  ///
  /// In tr, this message translates to:
  /// **'Ertele ({minutes} dk)'**
  String snoozeWithDuration(int minutes);

  /// No description provided for @settings.
  ///
  /// In tr, this message translates to:
  /// **'Ayarlar'**
  String get settings;

  /// No description provided for @waitTime.
  ///
  /// In tr, this message translates to:
  /// **'Bekleme Süresi'**
  String get waitTime;

  /// No description provided for @waitTimeDesc.
  ///
  /// In tr, this message translates to:
  /// **'Uyku algılama için bekleme süresi'**
  String get waitTimeDesc;

  /// No description provided for @sleepDuration.
  ///
  /// In tr, this message translates to:
  /// **'Uyku Süresi'**
  String get sleepDuration;

  /// No description provided for @sleepDurationDesc.
  ///
  /// In tr, this message translates to:
  /// **'Otomatik alarm için uyku süresi'**
  String get sleepDurationDesc;

  /// No description provided for @snoozeDuration.
  ///
  /// In tr, this message translates to:
  /// **'Erteleme Süresi'**
  String get snoozeDuration;

  /// No description provided for @snoozeDurationDesc.
  ///
  /// In tr, this message translates to:
  /// **'Alarm erteleme süresi'**
  String get snoozeDurationDesc;

  /// No description provided for @alarmSound.
  ///
  /// In tr, this message translates to:
  /// **'Alarm Sesi'**
  String get alarmSound;

  /// No description provided for @alarmSoundDesc.
  ///
  /// In tr, this message translates to:
  /// **'Alarm çaldığında çalınacak ses'**
  String get alarmSoundDesc;

  /// No description provided for @autoDetection.
  ///
  /// In tr, this message translates to:
  /// **'Otomatik Algılama'**
  String get autoDetection;

  /// No description provided for @autoDetectionDesc.
  ///
  /// In tr, this message translates to:
  /// **'Uyku algılamayı otomatik başlat'**
  String get autoDetectionDesc;

  /// No description provided for @screenModeDetection.
  ///
  /// In tr, this message translates to:
  /// **'Ekran Durumu Algılama'**
  String get screenModeDetection;

  /// No description provided for @screenModeDetectionDesc.
  ///
  /// In tr, this message translates to:
  /// **'Açık: Sadece ekran kapandığında geri sayım başlar\nKapalı: Uygulama içi hareketsizlikte de geri sayım başlar'**
  String get screenModeDetectionDesc;

  /// No description provided for @activeTimeRange.
  ///
  /// In tr, this message translates to:
  /// **'Çalışma Aralığı'**
  String get activeTimeRange;

  /// No description provided for @activeTimeRangeDesc.
  ///
  /// In tr, this message translates to:
  /// **'Otomatik alarm algılamanın aktif olacağı saat aralığı'**
  String get activeTimeRangeDesc;

  /// No description provided for @activeTimeRangeDialogDesc.
  ///
  /// In tr, this message translates to:
  /// **'Otomatik uyku algılamanın aktif olacağı saat aralığını seçin. Bu aralık dışında yeni algılama başlamaz, ancak zaten kurulmuş alarmlar etkilenmez.'**
  String get activeTimeRangeDialogDesc;

  /// No description provided for @permissionsRequired.
  ///
  /// In tr, this message translates to:
  /// **'İzinler Gerekli'**
  String get permissionsRequired;

  /// No description provided for @notificationPermission.
  ///
  /// In tr, this message translates to:
  /// **'Bildirim İzni'**
  String get notificationPermission;

  /// No description provided for @notificationPermissionDesc.
  ///
  /// In tr, this message translates to:
  /// **'Alarm çalabilmek için bildirim izni gereklidir.'**
  String get notificationPermissionDesc;

  /// No description provided for @exactAlarmPermission.
  ///
  /// In tr, this message translates to:
  /// **'Kesin Alarm İzni'**
  String get exactAlarmPermission;

  /// No description provided for @exactAlarmPermissionDesc.
  ///
  /// In tr, this message translates to:
  /// **'Alarmların tam zamanında çalması için gereklidir.'**
  String get exactAlarmPermissionDesc;

  /// No description provided for @grant.
  ///
  /// In tr, this message translates to:
  /// **'İzin Ver'**
  String get grant;

  /// No description provided for @granted.
  ///
  /// In tr, this message translates to:
  /// **'Verildi ✓'**
  String get granted;

  /// No description provided for @continueText.
  ///
  /// In tr, this message translates to:
  /// **'Devam Et'**
  String get continueText;

  /// No description provided for @cancel.
  ///
  /// In tr, this message translates to:
  /// **'İptal'**
  String get cancel;

  /// No description provided for @save.
  ///
  /// In tr, this message translates to:
  /// **'Kaydet'**
  String get save;

  /// No description provided for @delete.
  ///
  /// In tr, this message translates to:
  /// **'Sil'**
  String get delete;

  /// No description provided for @ok.
  ///
  /// In tr, this message translates to:
  /// **'Tamam'**
  String get ok;

  /// No description provided for @yes.
  ///
  /// In tr, this message translates to:
  /// **'Evet'**
  String get yes;

  /// No description provided for @no.
  ///
  /// In tr, this message translates to:
  /// **'Hayır'**
  String get no;

  /// No description provided for @retryButton.
  ///
  /// In tr, this message translates to:
  /// **'Tekrar Dene'**
  String get retryButton;

  /// No description provided for @noAlarmsYet.
  ///
  /// In tr, this message translates to:
  /// **'Henüz alarm yok'**
  String get noAlarmsYet;

  /// No description provided for @noAlarmsHint.
  ///
  /// In tr, this message translates to:
  /// **'Alarm eklemek için + butonuna basın'**
  String get noAlarmsHint;

  /// No description provided for @past.
  ///
  /// In tr, this message translates to:
  /// **'Geçmiş'**
  String get past;

  /// No description provided for @inTime.
  ///
  /// In tr, this message translates to:
  /// **'{time} sonra'**
  String inTime(String time);

  /// No description provided for @sweetDreams.
  ///
  /// In tr, this message translates to:
  /// **'İyi uykular 🌙'**
  String get sweetDreams;

  /// No description provided for @stop.
  ///
  /// In tr, this message translates to:
  /// **'Durdur'**
  String get stop;

  /// No description provided for @start.
  ///
  /// In tr, this message translates to:
  /// **'Başlat'**
  String get start;

  /// No description provided for @statusSleepDetected.
  ///
  /// In tr, this message translates to:
  /// **'😴 Uyku algılandı — alarm kuruldu'**
  String get statusSleepDetected;

  /// No description provided for @statusAutoDetectionOff.
  ///
  /// In tr, this message translates to:
  /// **'⏸️ Otomatik algılama kapalı'**
  String get statusAutoDetectionOff;

  /// No description provided for @statusOutsideRange.
  ///
  /// In tr, this message translates to:
  /// **'🕐 Çalışma aralığı dışında — algılama beklemede'**
  String get statusOutsideRange;

  /// No description provided for @statusScreenOff.
  ///
  /// In tr, this message translates to:
  /// **'🌙 Ekran kapalı — {time} sonra alarm'**
  String statusScreenOff(String time);

  /// No description provided for @statusInactivity.
  ///
  /// In tr, this message translates to:
  /// **'⏳ Hareketsizlik — {time} sonra alarm'**
  String statusInactivity(String time);

  /// No description provided for @statusScreenOn.
  ///
  /// In tr, this message translates to:
  /// **'📱 Ekran açık — bekleniyor...'**
  String get statusScreenOn;

  /// No description provided for @statusPhoneInUse.
  ///
  /// In tr, this message translates to:
  /// **'📱 Telefon kullanılıyor — izleniyor...'**
  String get statusPhoneInUse;

  /// No description provided for @sleepDetectedSnack.
  ///
  /// In tr, this message translates to:
  /// **'😴 Uyku algılandı! Otomatik alarm kuruldu.'**
  String get sleepDetectedSnack;

  /// No description provided for @movementDetectedSnack.
  ///
  /// In tr, this message translates to:
  /// **'🔄 Hareket algılandı — otomatik alarm iptal edildi.'**
  String get movementDetectedSnack;

  /// No description provided for @sectionGeneral.
  ///
  /// In tr, this message translates to:
  /// **'Genel'**
  String get sectionGeneral;

  /// No description provided for @sectionTiming.
  ///
  /// In tr, this message translates to:
  /// **'Zamanlama'**
  String get sectionTiming;

  /// No description provided for @sectionSound.
  ///
  /// In tr, this message translates to:
  /// **'Ses'**
  String get sectionSound;

  /// No description provided for @sectionAbout.
  ///
  /// In tr, this message translates to:
  /// **'Hakkında'**
  String get sectionAbout;

  /// No description provided for @version.
  ///
  /// In tr, this message translates to:
  /// **'Versiyon {version}'**
  String version(String version);

  /// No description provided for @noAlarmSoundFound.
  ///
  /// In tr, this message translates to:
  /// **'Alarm sesi bulunamadı'**
  String get noAlarmSoundFound;

  /// No description provided for @defaultAlarmSound.
  ///
  /// In tr, this message translates to:
  /// **'Varsayılan Alarm Sesi'**
  String get defaultAlarmSound;

  /// No description provided for @defaultLabel.
  ///
  /// In tr, this message translates to:
  /// **'Varsayılan'**
  String get defaultLabel;

  /// No description provided for @startLabel.
  ///
  /// In tr, this message translates to:
  /// **'Başlangıç'**
  String get startLabel;

  /// No description provided for @endLabel.
  ///
  /// In tr, this message translates to:
  /// **'Bitiş'**
  String get endLabel;

  /// No description provided for @alarmSetAt.
  ///
  /// In tr, this message translates to:
  /// **'Alarm kuruldu: {time}'**
  String alarmSetAt(String time);

  /// No description provided for @youSleptDuration.
  ///
  /// In tr, this message translates to:
  /// **'Uyku süreniz: {duration}'**
  String youSleptDuration(String duration);

  /// No description provided for @formatMinShort.
  ///
  /// In tr, this message translates to:
  /// **'dk'**
  String get formatMinShort;

  /// No description provided for @formatSecShort.
  ///
  /// In tr, this message translates to:
  /// **'sn'**
  String get formatSecShort;

  /// No description provided for @formatHour.
  ///
  /// In tr, this message translates to:
  /// **'saat'**
  String get formatHour;

  /// No description provided for @formatHourShort.
  ///
  /// In tr, this message translates to:
  /// **'sa'**
  String get formatHourShort;

  /// No description provided for @formatDurationHoursMinutes.
  ///
  /// In tr, this message translates to:
  /// **'{hours} saat {minutes} dakika'**
  String formatDurationHoursMinutes(int hours, int minutes);

  /// No description provided for @formatDurationHours.
  ///
  /// In tr, this message translates to:
  /// **'{hours} saat'**
  String formatDurationHours(int hours);

  /// No description provided for @formatDurationMinutes.
  ///
  /// In tr, this message translates to:
  /// **'{minutes} dakika'**
  String formatDurationMinutes(int minutes);

  /// No description provided for @language.
  ///
  /// In tr, this message translates to:
  /// **'Dil'**
  String get language;

  /// No description provided for @languageDesc.
  ///
  /// In tr, this message translates to:
  /// **'Uygulama dilini değiştir'**
  String get languageDesc;

  /// No description provided for @languageSystem.
  ///
  /// In tr, this message translates to:
  /// **'Sistem'**
  String get languageSystem;

  /// No description provided for @languageTurkish.
  ///
  /// In tr, this message translates to:
  /// **'Türkçe'**
  String get languageTurkish;

  /// No description provided for @languageEnglish.
  ///
  /// In tr, this message translates to:
  /// **'English'**
  String get languageEnglish;

  /// No description provided for @themeMode.
  ///
  /// In tr, this message translates to:
  /// **'Tema'**
  String get themeMode;

  /// No description provided for @themeModeDesc.
  ///
  /// In tr, this message translates to:
  /// **'Uygulama temasını değiştir'**
  String get themeModeDesc;

  /// No description provided for @themeDark.
  ///
  /// In tr, this message translates to:
  /// **'Koyu'**
  String get themeDark;

  /// No description provided for @themeLight.
  ///
  /// In tr, this message translates to:
  /// **'Açık'**
  String get themeLight;

  /// No description provided for @themeSystem.
  ///
  /// In tr, this message translates to:
  /// **'Sistem'**
  String get themeSystem;

  /// No description provided for @sleepAnalysis.
  ///
  /// In tr, this message translates to:
  /// **'Uyku Analizi'**
  String get sleepAnalysis;

  /// No description provided for @sleepAnalysisTooltip.
  ///
  /// In tr, this message translates to:
  /// **'Uyku Analizi'**
  String get sleepAnalysisTooltip;

  /// No description provided for @lastNight.
  ///
  /// In tr, this message translates to:
  /// **'Dün Gece'**
  String get lastNight;

  /// No description provided for @thisWeek.
  ///
  /// In tr, this message translates to:
  /// **'Bu Hafta'**
  String get thisWeek;

  /// No description provided for @alerts.
  ///
  /// In tr, this message translates to:
  /// **'Uyarılar'**
  String get alerts;

  /// No description provided for @viewAllHistory.
  ///
  /// In tr, this message translates to:
  /// **'Tüm Geçmişi Gör'**
  String get viewAllHistory;

  /// No description provided for @noSleepRecordYet.
  ///
  /// In tr, this message translates to:
  /// **'Henüz Uyku Kaydı Yok'**
  String get noSleepRecordYet;

  /// No description provided for @noSleepRecordHint.
  ///
  /// In tr, this message translates to:
  /// **'Alarmı kullandıktan sonra\nuyku analizin burada görünecek.'**
  String get noSleepRecordHint;

  /// No description provided for @viewDetails.
  ///
  /// In tr, this message translates to:
  /// **'Detayları gör'**
  String get viewDetails;

  /// No description provided for @sleepDurationLabel.
  ///
  /// In tr, this message translates to:
  /// **'Süre'**
  String get sleepDurationLabel;

  /// No description provided for @wakeCount.
  ///
  /// In tr, this message translates to:
  /// **'Uyanma'**
  String get wakeCount;

  /// No description provided for @efficiency.
  ///
  /// In tr, this message translates to:
  /// **'Verimlilik'**
  String get efficiency;

  /// No description provided for @avgScore.
  ///
  /// In tr, this message translates to:
  /// **'Ort. Skor'**
  String get avgScore;

  /// No description provided for @avgDuration.
  ///
  /// In tr, this message translates to:
  /// **'Ort. Süre'**
  String get avgDuration;

  /// No description provided for @recordCount.
  ///
  /// In tr, this message translates to:
  /// **'Kayıt'**
  String get recordCount;

  /// No description provided for @nightsUnit.
  ///
  /// In tr, this message translates to:
  /// **'gece'**
  String get nightsUnit;

  /// No description provided for @timesUnit.
  ///
  /// In tr, this message translates to:
  /// **'kez'**
  String get timesUnit;

  /// No description provided for @detailBedTime.
  ///
  /// In tr, this message translates to:
  /// **'Yatış'**
  String get detailBedTime;

  /// No description provided for @detailWakeTime.
  ///
  /// In tr, this message translates to:
  /// **'Kalkış'**
  String get detailWakeTime;

  /// No description provided for @scoreDetail.
  ///
  /// In tr, this message translates to:
  /// **'Skor Detayı'**
  String get scoreDetail;

  /// No description provided for @scoreMotion.
  ///
  /// In tr, this message translates to:
  /// **'Hareket'**
  String get scoreMotion;

  /// No description provided for @scoreConsistency.
  ///
  /// In tr, this message translates to:
  /// **'Tutarlılık'**
  String get scoreConsistency;

  /// No description provided for @scoreAlarmResponse.
  ///
  /// In tr, this message translates to:
  /// **'Alarm Tepkisi'**
  String get scoreAlarmResponse;

  /// No description provided for @remCycles.
  ///
  /// In tr, this message translates to:
  /// **'REM Döngüleri (Tahmini)'**
  String get remCycles;

  /// No description provided for @noRemData.
  ///
  /// In tr, this message translates to:
  /// **'Yeterli veri yok.'**
  String get noRemData;

  /// No description provided for @lightSleepWindow.
  ///
  /// In tr, this message translates to:
  /// **'Hafif uyku penceresi'**
  String get lightSleepWindow;

  /// No description provided for @nightWakeups.
  ///
  /// In tr, this message translates to:
  /// **'Gece Uyanmaları'**
  String get nightWakeups;

  /// No description provided for @screenTurnedOn.
  ///
  /// In tr, this message translates to:
  /// **'Ekran açıldı'**
  String get screenTurnedOn;

  /// No description provided for @dayMon.
  ///
  /// In tr, this message translates to:
  /// **'Pzt'**
  String get dayMon;

  /// No description provided for @dayTue.
  ///
  /// In tr, this message translates to:
  /// **'Sal'**
  String get dayTue;

  /// No description provided for @dayWed.
  ///
  /// In tr, this message translates to:
  /// **'Çar'**
  String get dayWed;

  /// No description provided for @dayThu.
  ///
  /// In tr, this message translates to:
  /// **'Per'**
  String get dayThu;

  /// No description provided for @dayFri.
  ///
  /// In tr, this message translates to:
  /// **'Cum'**
  String get dayFri;

  /// No description provided for @daySat.
  ///
  /// In tr, this message translates to:
  /// **'Cmt'**
  String get daySat;

  /// No description provided for @daySun.
  ///
  /// In tr, this message translates to:
  /// **'Paz'**
  String get daySun;

  /// No description provided for @monthJan.
  ///
  /// In tr, this message translates to:
  /// **'Oca'**
  String get monthJan;

  /// No description provided for @monthFeb.
  ///
  /// In tr, this message translates to:
  /// **'Şub'**
  String get monthFeb;

  /// No description provided for @monthMar.
  ///
  /// In tr, this message translates to:
  /// **'Mar'**
  String get monthMar;

  /// No description provided for @monthApr.
  ///
  /// In tr, this message translates to:
  /// **'Nis'**
  String get monthApr;

  /// No description provided for @monthMay.
  ///
  /// In tr, this message translates to:
  /// **'May'**
  String get monthMay;

  /// No description provided for @monthJun.
  ///
  /// In tr, this message translates to:
  /// **'Haz'**
  String get monthJun;

  /// No description provided for @monthJul.
  ///
  /// In tr, this message translates to:
  /// **'Tem'**
  String get monthJul;

  /// No description provided for @monthAug.
  ///
  /// In tr, this message translates to:
  /// **'Ağu'**
  String get monthAug;

  /// No description provided for @monthSep.
  ///
  /// In tr, this message translates to:
  /// **'Eyl'**
  String get monthSep;

  /// No description provided for @monthOct.
  ///
  /// In tr, this message translates to:
  /// **'Eki'**
  String get monthOct;

  /// No description provided for @monthNov.
  ///
  /// In tr, this message translates to:
  /// **'Kas'**
  String get monthNov;

  /// No description provided for @monthDec.
  ///
  /// In tr, this message translates to:
  /// **'Ara'**
  String get monthDec;

  /// No description provided for @anomalyInsufficientSleepTitle.
  ///
  /// In tr, this message translates to:
  /// **'Yetersiz Uyku'**
  String get anomalyInsufficientSleepTitle;

  /// No description provided for @anomalyInsufficientSleepDesc.
  ///
  /// In tr, this message translates to:
  /// **'Son {count} gece 5 saatten az uyudunuz. Bu durum sağlığınızı olumsuz etkileyebilir.'**
  String anomalyInsufficientSleepDesc(int count);

  /// No description provided for @anomalyScoreDropTitle.
  ///
  /// In tr, this message translates to:
  /// **'Uyku Kalitesi Düştü'**
  String get anomalyScoreDropTitle;

  /// No description provided for @anomalyScoreDropDesc.
  ///
  /// In tr, this message translates to:
  /// **'Dünkü uyku skoru ({score}), 7 günlük ortalamanızın ({avg}) çok altında.'**
  String anomalyScoreDropDesc(int score, int avg);

  /// No description provided for @anomalyFrequentWakingTitle.
  ///
  /// In tr, this message translates to:
  /// **'Sık Uyanma'**
  String get anomalyFrequentWakingTitle;

  /// No description provided for @anomalyFrequentWakingDesc.
  ///
  /// In tr, this message translates to:
  /// **'Son 7 gecede {count} gece 3 veya daha fazla kez uyandınız.'**
  String anomalyFrequentWakingDesc(int count);

  /// No description provided for @anomalySocialJetLagTitle.
  ///
  /// In tr, this message translates to:
  /// **'Sosyal Jet Lag'**
  String get anomalySocialJetLagTitle;

  /// No description provided for @anomalySocialJetLagDesc.
  ///
  /// In tr, this message translates to:
  /// **'Hafta sonu ortalamanız ({weekend}s), hafta içinden 3 saatten fazla. Bu biyolojik saatinizi bozabilir.'**
  String anomalySocialJetLagDesc(String weekend);

  /// No description provided for @anomalyBedtimeShiftTitle.
  ///
  /// In tr, this message translates to:
  /// **'Düzensiz Yatış Saati'**
  String get anomalyBedtimeShiftTitle;

  /// No description provided for @anomalyBedtimeShiftDesc.
  ///
  /// In tr, this message translates to:
  /// **'Son 7 günde yatış saatiniz 2 saatten fazla değişiyor. Düzenli bir uyku rutini oluşturmaya çalışın.'**
  String get anomalyBedtimeShiftDesc;

  /// No description provided for @anomalyExcessiveSnoozeTitle.
  ///
  /// In tr, this message translates to:
  /// **'Fazla Erteleme'**
  String get anomalyExcessiveSnoozeTitle;

  /// No description provided for @anomalyExcessiveSnoozeDesc.
  ///
  /// In tr, this message translates to:
  /// **'Bu sabah alarmı {count} kez ertelediniz. Bu, uyku kalitenizin düşük olduğuna işaret edebilir.'**
  String anomalyExcessiveSnoozeDesc(int count);

  /// No description provided for @anomalyStreakTitle.
  ///
  /// In tr, this message translates to:
  /// **'7 Günlük Mükemmel Uyku! 🌟'**
  String get anomalyStreakTitle;

  /// No description provided for @anomalyStreakDesc.
  ///
  /// In tr, this message translates to:
  /// **'Son 7 gece uyku skorunuz 80\'in üzerinde. Harika bir uyku rutini kurmuşsunuz!'**
  String get anomalyStreakDesc;

  /// No description provided for @anomalyImprovementTitle.
  ///
  /// In tr, this message translates to:
  /// **'Uyku Kaliteniz Arttı! 📈'**
  String get anomalyImprovementTitle;

  /// No description provided for @anomalyImprovementDesc.
  ///
  /// In tr, this message translates to:
  /// **'Bu haftaki ortalama skorunuz ({thisWeek}), geçen haftaya ({lastWeek}) göre önemli ölçüde arttı.'**
  String anomalyImprovementDesc(int thisWeek, int lastWeek);
}

class _SDelegate extends LocalizationsDelegate<S> {
  const _SDelegate();

  @override
  Future<S> load(Locale locale) {
    return SynchronousFuture<S>(lookupS(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'tr'].contains(locale.languageCode);

  @override
  bool shouldReload(_SDelegate old) => false;
}

S lookupS(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return SEn();
    case 'tr':
      return STr();
  }

  throw FlutterError(
    'S.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
