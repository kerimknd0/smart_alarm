import 'package:flutter/services.dart';

/// Sistem zil/alarm seslerini native taraftan çeken servis.
class RingtoneService {
  static const _channel = MethodChannel('com.example.smart_alarm/ringtone');

  /// Sistem alarm seslerini listeler.
  /// Her eleman {'title': 'Ses Adı', 'uri': 'content://...'} formatında.
  static Future<List<RingtoneItem>> getAlarmRingtones() async {
    try {
      final result = await _channel.invokeListMethod<Map>('getRingtones', {
        'type': 'alarm',
      });
      if (result == null) return [];

      return result.map((item) {
        return RingtoneItem(
          title: item['title'] as String? ?? 'Bilinmeyen',
          uri: item['uri'] as String? ?? '',
        );
      }).toList();
    } catch (e) {
      return [];
    }
  }

  /// Sistem bildirim seslerini listeler.
  static Future<List<RingtoneItem>> getNotificationRingtones() async {
    try {
      final result = await _channel.invokeListMethod<Map>('getRingtones', {
        'type': 'notification',
      });
      if (result == null) return [];

      return result.map((item) {
        return RingtoneItem(
          title: item['title'] as String? ?? 'Bilinmeyen',
          uri: item['uri'] as String? ?? '',
        );
      }).toList();
    } catch (e) {
      return [];
    }
  }

  /// Tüm zil seslerini listeler (alarm + bildirim + ringtone).
  static Future<List<RingtoneItem>> getAllRingtones() async {
    try {
      final result = await _channel.invokeListMethod<Map>('getRingtones', {
        'type': 'all',
      });
      if (result == null) return [];

      return result.map((item) {
        return RingtoneItem(
          title: item['title'] as String? ?? 'Bilinmeyen',
          uri: item['uri'] as String? ?? '',
        );
      }).toList();
    } catch (e) {
      return [];
    }
  }

  /// Varsayılan alarm URI'sini döndürür.
  static Future<String> getDefaultAlarmUri() async {
    try {
      final uri = await _channel.invokeMethod<String>('getDefaultAlarmUri');
      return uri ?? 'content://settings/system/alarm_alert';
    } catch (e) {
      return 'content://settings/system/alarm_alert';
    }
  }

  /// Zil sesini önizleme olarak çalar.
  static Future<void> playPreview(String uri) async {
    try {
      await _channel.invokeMethod('playPreview', {'uri': uri});
    } catch (_) {}
  }

  /// Önizleme sesini durdurur.
  static Future<void> stopPreview() async {
    try {
      await _channel.invokeMethod('stopPreview');
    } catch (_) {}
  }

  /// Alarm sesini çalar (loop modunda, USAGE_ALARM ile).
  static Future<void> playAlarm(String uri) async {
    try {
      await _channel.invokeMethod('playAlarm', {'uri': uri});
    } catch (_) {}
  }

  /// Alarm sesini durdurur.
  static Future<void> stopAlarm() async {
    try {
      await _channel.invokeMethod('stopAlarm');
    } catch (_) {}
  }
}

/// Tek bir zil sesi öğesi.
class RingtoneItem {
  final String title;
  final String uri;

  const RingtoneItem({required this.title, required this.uri});

  @override
  String toString() => 'RingtoneItem(title: $title, uri: $uri)';
}
