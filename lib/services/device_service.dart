import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:logging/logging.dart';

class DeviceService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String? userId = FirebaseAuth.instance.currentUser?.uid;
  final _logger = Logger('DeviceService');

  Future<void> addNewDevice({
    required String deviceType,
    required String deviceName,
    required String deviceId,
    required String initialStatus,
    String? deviceCode,
  }) async {
    if (userId == null) throw Exception('Kullanıcı oturum açmamış');

    final collectionRef = _firestore.collection('devices');

    try {
      _logger.info('Kullanıcı ID: $userId');
      _logger.info('Cihaz Tipi: $deviceType');
      _logger.info('Cihaz ID: $deviceId');
      _logger.info('Cihaz Kodu: $deviceCode');

      // Cihaz türüne göre özel ayarlar
      Map<String, dynamic> deviceSettings = {};

      if (deviceType == 'food_bowl') {
        // Mama kabı için özel ayarlar
        deviceSettings = {
          'foodBowlSettings': {
            'foodLevel': 2000,
            'maxCapacity': 2000,
            'portionSize': 100,
            'feedingSchedule': [],
            'lastFeeding': null,
            'autoFeedingEnabled': false,
          }
        };
      } else if (deviceType == 'water_bowl') {
        // Su kabı için özel ayarlar
        deviceSettings = {
          'waterBowlSettings': {
            'waterLevel': 2000,
            'maxCapacity': 2000,
            'portionSize': 100,
            'cleaningSchedule': [],
            'lastCleaning': null,
            'autoCleaningEnabled': false,
          }
        };
      } else {
        // Diğer cihaz türleri için genel ayarlar
        deviceSettings = {
          'settings': {
            'level': 2000,
            'maxCapacity': 2000,
            'portionSize': 100,
          }
        };
      }

      // Cihaz verilerini oluştur
      Map<String, dynamic> deviceData = {
        'userId': userId,
        'deviceType': deviceType,
        'deviceName': deviceName,
        'deviceId': deviceId,
        'deviceCode': deviceCode,
        'status': initialStatus,
        'lastUpdated': FieldValue.serverTimestamp(),
        'createdAt': FieldValue.serverTimestamp(),
        'isActive': true,
        'batteryLevel': 100,
        ...deviceSettings,
        'generalSettings': {
          'isNotificationEnabled': true,
          'updateInterval': 5,
          'deviceLocation': 'Ev',
        },
      };

      // Cihaz türüne göre ek ayarlar
      if (deviceType == 'food_bowl' || deviceType == 'water_bowl') {
        deviceData['lightSettings'] = {
          'isLightOpen': false,
          'lightDuration': 30,
        };
      }

      await collectionRef.doc(deviceId).set(deviceData);

      _logger.info('Cihaz başarıyla eklendi: $deviceId');
    } catch (e) {
      _logger.severe('Hata oluştu: $e');
      throw Exception('Cihaz eklenirken bir hata oluştu');
    }
  }

  Stream<QuerySnapshot> getUserDevices() {
    if (userId == null) throw Exception('Kullanıcı oturum açmamış');

    return _firestore
        .collection('devices')
        .where('userId', isEqualTo: userId)
        .snapshots()
        .handleError((error) {
      _logger.severe('Firestore stream hatası: $error');
      return const Stream.empty();
    });
  }

  Future<void> updateDeviceStatus(String deviceId, String status) async {
    if (userId == null) throw Exception('Kullanıcı oturum açmamış');

    try {
      _logger.info('Cihaz durumu güncelleniyor: $deviceId -> $status');

      await _firestore.collection('devices').doc(deviceId).update({
        'status': status,
        'lastUpdated': FieldValue.serverTimestamp(),
      });

      _logger.info('Cihaz durumu başarıyla güncellendi');
    } catch (e) {
      _logger.severe('Cihaz durumu güncellenirken hata: $e');
      throw Exception('Cihaz durumu güncellenirken bir hata oluştu: $e');
    }
  }

  Future<void> deleteDevice(String deviceId) async {
    if (userId == null) throw Exception('Kullanıcı oturum açmamış');

    try {
      await _firestore.collection('devices').doc(deviceId).delete();
      // Stream'i yenile
      getUserDevices();
    } catch (e) {
      throw Exception('Cihaz silinirken bir hata oluştu: $e');
    }
  }

  Future<void> updateWaterBowlSettings({
    required String deviceId,
    required Map<String, dynamic> settings,
  }) async {
    if (userId == null) throw Exception('Kullanıcı oturum açmamış');

    try {
      await _firestore.collection('devices').doc(deviceId).update({
        'waterBowlSettings': settings,
        'lastUpdated': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw Exception('Su kabı ayarları güncellenirken bir hata oluştu: $e');
    }
  }

  Stream<DocumentSnapshot> getDeviceStream(String deviceId) {
    if (userId == null) throw Exception('Kullanıcı oturum açmamış');

    try {
      return _firestore
          .collection('devices')
          .doc(deviceId)
          .snapshots()
          .handleError((error) {
        _logger.severe('Firestore stream hatası: $error');
        throw Exception('Cihaz verisi alınırken bir hata oluştu: $error');
      });
    } catch (e) {
      _logger.severe('Stream oluşturulurken hata: $e');
      throw Exception('Stream oluşturulurken bir hata oluştu: $e');
    }
  }

  Future<void> updateFoodBowlSettings({
    required String deviceId,
    required Map<String, dynamic> settings,
  }) async {
    if (userId == null) throw Exception('Kullanıcı oturum açmamış');

    try {
      await _firestore.collection('devices').doc(deviceId).update({
        'foodBowlSettings': settings,
        'lastUpdated': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw Exception('Mama kabı ayarları güncellenirken bir hata oluştu: $e');
    }
  }

  Future<bool> checkIfDeviceTypeExists(String deviceType) async {
    if (userId == null) throw Exception('Kullanıcı oturum açmamış');

    try {
      // Artık kullanıcı aynı türde birden fazla cihaz ekleyebilir
      return false;
    } catch (e) {
      _logger.severe('Cihaz kontrolü sırasında hata: $e');
      throw Exception('Cihaz kontrolü sırasında bir hata oluştu');
    }
  }

  Future<void> updateDeviceLocation({
    required String deviceId,
    required String location,
  }) async {
    if (userId == null) throw Exception('Kullanıcı oturum açmamış');

    try {
      await _firestore.collection('devices').doc(deviceId).update({
        'generalSettings.deviceLocation': location,
        'lastUpdated': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw Exception('Cihaz konumu güncellenirken bir hata oluştu: $e');
    }
  }

  Future<void> updateLightSettings({
    required String deviceId,
    required bool isLightOpen,
    required int lightDuration,
  }) async {
    if (userId == null) throw Exception('Kullanıcı oturum açmamış');

    try {
      await _firestore.collection('devices').doc(deviceId).update({
        'lightSettings': {
          'isLightOpen': isLightOpen,
          'lightDuration': lightDuration,
        },
        'lastUpdated': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw Exception('Işık ayarları güncellenirken bir hata oluştu: $e');
    }
  }
}
