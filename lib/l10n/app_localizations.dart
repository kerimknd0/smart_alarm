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
