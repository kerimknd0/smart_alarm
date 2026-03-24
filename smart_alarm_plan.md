# 📱 Smart Sleep Alarm — Flutter Proje Planı

> **Konsept:** Kullanıcının telefonu bıraktığını algılayan, buna göre otomatik uyku alarmı kuran akıllı alarm uygulaması.

---

## 1. Proje Genel Bakış

### Ne Yapıyor?
Kullanıcı telefonu bıraktıktan belirli bir süre sonra (varsayılan: 30 dakika) uygulama "uyku moduna geçildi" kararını verir ve otomatik olarak ilerleyen bir zaman için alarm kurar (varsayılan: 8 saat sonra). Kullanıcının ayrıca manuel alarm kurmasına da olanak tanır.

### Temel Akış
```
Telefon kullanımı durdu
        ↓
Bekleme süresi doldu (ör. 30 dk)
        ↓
"Uyku başladı" kararı verildi
        ↓
8 saat sonraya alarm kuruldu
        ↓
Alarm çalıyor → Kullanıcı uyandı
```

---

## 2. Temel Özellikler (MVP)

### 2.1 Kullanım Algılama (Usage Detection)
Uygulamanın kalbini oluşturan bu modül, kullanıcının telefonu aktif olarak kullanıp kullanmadığını izler. Bunu üç yöntemin kombinasyonuyla yapar:

- **Ekran Durumu (Screen State):** Ekran kapandığında zamanlayıcı başlar, açıldığında sıfırlanır.
- **Dokunmatik Etkileşim:** Son dokunuş zamanı takip edilir.
- **UsageStatsManager (Android) / Screen Time API (iOS):** İşletim sistemi seviyesinde uygulama kullanım verisi okunur.

### 2.2 Uyku Kararı Motoru (Sleep Decision Engine)
Kullanım yokluğunun ne kadar sürdüğünü hesaplar ve kullanıcının belirlediği eşiği (varsayılan 30 dakika) aşınca "uyku başladı" sinyali üretir.

### 2.3 Otomatik Alarm Yöneticisi
Uyku kararı verildikten sonra belirtilen süre (varsayılan 8 saat) için `flutter_local_notifications` ve `android_alarm_manager_plus` kullanarak native seviyede alarm kurar. Uygulama kapalı olsa bile alarm çalışır.

### 2.4 Alarm Ekranı (Alarm Screen)
Alarm çaldığında ekran kilitliyken bile gösterilecek özel bir ekran. İçerik:
- Saat ve tarih
- Kaç saat uyunduğu bilgisi
- "Kurtar" (snooze) ve "Kapat" butonları
- İsteğe bağlı: Motivasyon mesajı

### 2.5 Ayarlar Ekranı
Kullanıcının kendi tercihlerine göre yapılandırabileceği parametreler:
- Bekleme süresi (10, 20, 30, 45, 60 dakika)
- Uyku süresi (6, 7, 8, 9 saat)
- Snooze süresi (5, 10 dakika)
- Alarm sesi seçimi
- Otomatik algılama açık/kapalı toggle'ı

---

## 3. Uygulama Mimarisi

### Katman Yapısı
Proje, **Clean Architecture** prensiplerine dayalı 3 katmanlı bir yapı kullanır. Bu yaklaşım; test edilebilirliği artırır, her katmanı bağımsız olarak değiştirmeye olanak tanır ve kodun büyüdükçe karmaşıklaşmasını önler.

```
lib/
├── core/                        # Ortak altyapı
│   ├── constants/               # Sabitler (süreler, renkler)
│   ├── utils/                   # Yardımcı fonksiyonlar
│   └── services/                # Sistem servisleri
│       ├── notification_service.dart
│       └── background_service.dart
│
├── features/
│   ├── alarm/
│   │   ├── data/
│   │   │   ├── models/          # AlarmModel (JSON serialize)
│   │   │   └── repositories/    # AlarmRepository impl.
│   │   ├── domain/
│   │   │   ├── entities/        # Alarm entity
│   │   │   └── usecases/        # SetAlarm, CancelAlarm, GetAlarms
│   │   └── presentation/
│   │       ├── bloc/            # AlarmBloc, AlarmState, AlarmEvent
│   │       ├── screens/         # AlarmScreen, AlarmRingScreen
│   │       └── widgets/         # AlarmCard, TimePicker, etc.
│   │
│   ├── usage_detection/
│   │   ├── data/
│   │   │   └── sources/         # ScreenStateSource, UsageStatsSource
│   │   ├── domain/
│   │   │   └── usecases/        # StartMonitoring, StopMonitoring
│   │   └── presentation/
│   │       └── bloc/            # UsageBloc
│   │
│   └── settings/
│       ├── data/
│       │   └── repositories/    # SharedPreferences impl.
│       └── presentation/
│           ├── bloc/            # SettingsBloc
│           └── screens/         # SettingsScreen
│
└── main.dart
```

### State Management
**flutter_bloc (BLoC pattern)** kullanılacak. Neden? Çünkü alarm ve kullanım algılama gibi zaman tabanlı, arka plan işlemlerini reaktif biçimde yönetmek için BLoC'un akış (Stream) tabanlı yapısı çok uygundur.

---

## 4. Teknik Bileşenler ve Paketler

### Zorunlu Paketler

| Paket | Amaç | Versiyon (yaklaşık) |
|---|---|---|
| `flutter_local_notifications` | Bildirim ve alarm kanalı | ^17.x |
| `android_alarm_manager_plus` | Android'de arka plan alarm | ^3.x |
| `flutter_background_service` | Sürekli arka plan servisi | ^5.x |
| `flutter_bloc` | State management | ^8.x |
| `shared_preferences` | Ayarları kaydetme | ^2.x |
| `permission_handler` | İzin yönetimi | ^11.x |
| `screen_state` | Ekran açık/kapalı olayları | ^1.x |
| `usage_stats` | Android uygulama kullanım istatistikleri | ^2.x |
| `audioplayers` | Alarm sesi çalma | ^6.x |
| `wakelock_plus` | Alarm çalarken ekranı açık tutma | ^1.x |
| `get_it` | Dependency injection | ^7.x |

### Android İzinleri (AndroidManifest.xml)
```xml
<uses-permission android:name="android.permission.RECEIVE_BOOT_COMPLETED"/>
<uses-permission android:name="android.permission.SCHEDULE_EXACT_ALARM"/>
<uses-permission android:name="android.permission.USE_EXACT_ALARM"/>
<uses-permission android:name="android.permission.PACKAGE_USAGE_STATS"
    tools:ignore="ProtectedPermissions"/>
<uses-permission android:name="android.permission.WAKE_LOCK"/>
<uses-permission android:name="android.permission.FOREGROUND_SERVICE"/>
<uses-permission android:name="android.permission.POST_NOTIFICATIONS"/>
```

> ⚠️ `PACKAGE_USAGE_STATS` izni özel bir sistem iznidir. Android'de kullanıcıyı Ayarlar → Uygulamalar → Özel Erişim → Kullanım Verisi Erişimi ekranına yönlendirmeniz gerekir.

---

## 5. Kullanım Algılama Detayı

Bu, projenin en teknik ve kritik parçasıdır. Doğru çalışması için birkaç sinyal katmanı birlikte kullanılmalıdır.

### Sinyal Zinciri
```
[Ekran Kapandı Olayı]──────────────────────┐
[Son dokunuş zamanı > eşik]────────────────┤──→ SleepDecisionEngine
[UsageStats: son kullanım > eşik]──────────┘         ↓
                                              Uyku sayacı başlar
                                                      ↓
                                              Süre doldu → Alarm kur
```

### Arka Plan Servisi Döngüsü
`flutter_background_service` ile her 5 dakikada bir çalışan bir timer kurulur. Bu timer:

1. Son kullanım zamanını kontrol eder.
2. Eşik aşıldıysa `SleepDecisionEngine`'e bildirir.
3. Eğer alarm daha önce kurulmadıysa yeni alarm kurar.
4. Uygulama tekrar kullanılırsa bekleyen alarmı iptal edebilir (isteğe bağlı ayar).

### Edge Case'ler (Kenar Durumlar)

Aşağıdaki durumlar özellikle dikkate alınmalıdır:

- **Gece Yarısı Şarj:** Kullanıcı telefonu şarjda bırakıp uyuyor. `UsageStats` bu senaryoyu doğru ele alır.
- **Kısa Telefon Kontrolü:** Gece 03:00'te 2 dakika telefon kontrol edilirse alarm iptal mi edilmeli? Bu "akıllı yeniden hesaplama" özelliği opsiyonel yapılabilir.
- **Birden Fazla Alarm:** Aynı geceye birden fazla otomatik alarm kurulmaması için kilit mekanizması gerekir.
- **Düşük Pil Modu:** Android'de pil tasarrufu arka plan servislerini öldürebilir. `battery_optimization_exemption` kullanılmalı.

---

## 6. Ekranlar ve UI Akışı

### Ekran Listesi

```
┌─────────────────────────────────────────────────────────┐
│  1. Ana Ekran (HomeScreen)                              │
│     - Mevcut durum (İzleniyor / Pasif)                  │
│     - Bir sonraki alarm saati                           │
│     - Son uyku süresi                                   │
│     - Hızlı ayar butonları                              │
├─────────────────────────────────────────────────────────┤
│  2. Alarm Listesi (AlarmListScreen)                     │
│     - Otomatik kurulmuş alarmlar                        │
│     - Manuel alarmlar                                   │
│     - Aktif/pasif toggle                               │
├─────────────────────────────────────────────────────────┤
│  3. Alarm Çalıyor Ekranı (AlarmRingScreen)              │
│     - Fullscreen, ekran kilidi üstünde gösterilir       │
│     - Snooze ve Kapat butonları                         │
│     - Kaç saat uyunduğu                                 │
├─────────────────────────────────────────────────────────┤
│  4. Ayarlar Ekranı (SettingsScreen)                     │
│     - Bekleme eşiği                                     │
│     - Uyku süresi                                       │
│     - Alarm sesi                                        │
│     - Otomatik algılama toggle                          │
│     - İzin durumu göstergesi                            │
├─────────────────────────────────────────────────────────┤
│  5. İzin Ekranı (PermissionScreen)                      │
│     - İlk kurulumda gösterilir                          │
│     - Her izin için açıklama ve "Ver" butonu            │
└─────────────────────────────────────────────────────────┘
```

### Navigasyon
`go_router` veya `AutoRoute` ile bildirimlerden doğrudan `AlarmRingScreen`'e deep link navigasyonu sağlanacak.

---

## 7. Veri Modeli

### AlarmModel
```dart
class AlarmModel {
  final String id;           // UUID
  final DateTime scheduledAt; // Alarm zamanı
  final DateTime? sleepStart; // Uyku başlangıcı (otomatikse)
  final AlarmType type;      // automatic | manual
  final bool isActive;
  final int snoozeDurationMinutes;
  final String soundAsset;
}

enum AlarmType { automatic, manual }
```

### SleepSession (istatistik için)
```dart
class SleepSession {
  final DateTime sleepStart;
  final DateTime? wakeUp;
  final Duration? totalSleep;
  final bool wasAlarmUsed;
}
```

---

## 8. Geliştirme Aşamaları (Roadmap)

### Faz 1 — Temel Alarm (1-2 Hafta)
Bu fazın amacı çalışan bir alarm motoruna sahip olmak; kullanım algılama olmadan sadece alarm kurma, listeleme ve çaldırma özelliklerini teslim etmek.

- Proje kurulumu, klasör yapısı, paketler
- `AlarmService` + `flutter_local_notifications` entegrasyonu
- Alarm listesi ekranı
- Alarm çalıyor ekranı (fullscreen intent)
- Snooze mekanizması

### Faz 2 — Kullanım Algılama (2-3 Hafta)
Bu en zorlu fazdır çünkü platforma özgü API'lar ve arka plan kısıtlamalarıyla boğuşulur.

- `flutter_background_service` kurulumu
- Android `UsageStatsManager` entegrasyonu
- Ekran durumu izleme
- `SleepDecisionEngine` implementasyonu
- Otomatik alarm kurma + iptal mekanizması
- İzin akışları (özellikle Usage Stats izni)

### Faz 3 — UI/UX Cilalanması (1 Hafta)
- Ana ekran tasarımı
- Animasyonlar (alarm çalarken titreşim, fade-in)
- Tema (koyu mod desteği)
- Ses seçimi

### Faz 4 — iOS Desteği (2 Hafta) *(opsiyonel)*
iOS'ta `PACKAGE_USAGE_STATS` karşılığı yoktur; Screen Time API kısıtlıdır. Alternatif olarak:
- `CoreMotion` ile hareketsizlik tespiti
- Ekran kapama süresi tahmini
- Bu nedenle iOS'ta kullanım algılama yalnızca "ekran kilitliyse" basit modda çalışabilir.

### Faz 5 — Gelişmiş Özellikler (2+ Hafta)
- Uyku istatistikleri ve geçmişi (grafik ile)
- Akıllı uyandırma: REM döngüsü tahminine göre alarm ±30 dakika içinde en hafif uykuyu hedefler
- Tekrarlayan alarmlar (haftalık program)
- Widget (home screen)

---

## 9. Olası Zorluklar ve Çözümleri

| Zorluk | Neden Zor? | Çözüm |
|---|---|---|
| Arka plan servisi Android'de ölüyor | Agresif pil optimizasyonu | `foreground service` + kullanıcıya optimizasyon istisnası yaptırma |
| Usage Stats izni | Normal `requestPermission` ile verilemiyor | Intent ile sistem ekranına yönlendirme |
| Alarm çalarken ekran kapalı | `showWhenLocked`, `turnScreenOn` flag'leri | `FlutterLocalNotifications` + `fullScreenIntent` + `Wakelock` |
| iOS'ta arka plan kısıtlamaları | Apple çok daha katı | Temel alarm özelliği çalışır ama otomatik algılama sınırlı olur |
| Saat dilimi değişikliği | Seyahat sırasında alarm kayması | UTC'de kayıt + yerel saat gösterimi |

---

## 10. Proje Yapısı — Başlangıç Komutları

```bash
# Proje oluştur
flutter create smart_sleep_alarm --org com.yourname
cd smart_sleep_alarm

# Temel paketleri ekle
flutter pub add flutter_bloc
flutter pub add flutter_local_notifications
flutter pub add android_alarm_manager_plus
flutter pub add flutter_background_service
flutter pub add permission_handler
flutter pub add shared_preferences
flutter pub add audioplayers
flutter pub add wakelock_plus
flutter pub add get_it
flutter pub add equatable
flutter pub add uuid
flutter pub add go_router

# Dev bağımlılıkları
flutter pub add --dev bloc_test
flutter pub add --dev mocktail
```

---

## 11. Test Stratejisi

Projenin test edilebilir olması için her katman ayrı test edilir:

- **Unit Test:** `SleepDecisionEngine` (çeşitli zaman senaryolarıyla), `AlarmRepository`.
- **Widget Test:** `AlarmRingScreen`, `SettingsScreen`.
- **Integration Test:** Uygulama kapalıyken alarm çalma, izin akışları.
- **Manuel Test:** Gerçek cihazda (emülatör arka plan davranışını doğru simüle etmez) bekleme süresi 2 dakikaya kısaltılarak test.

---

## 12. Özet

Bu uygulama Flutter ekosistemindeki en teknik konulardan birini — **arka plan işlemleri ve native API entegrasyonu** — ele alıyor. Temel güçlük kullanım algılamada değil, bu algılamanın Android'in pil optimizasyon mekanizmalarına rağmen güvenilir biçimde çalışmasını sağlamakta. Bu nedenle önce alarmın kendisini mükemmel hale getirip, ardından kullanım algılamayı üzerine inşa etmek en sağlıklı yoldur.

---

*Hazırlayan: Proje Planlama Dokümanı | Flutter Smart Sleep Alarm v1.0*
