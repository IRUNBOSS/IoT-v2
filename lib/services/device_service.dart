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
  }) async {
    if (userId == null) throw Exception('Kullanıcı oturum açmamış');

    final collectionRef = _firestore.collection('devices');

    try {
      _logger.info('Kullanıcı ID: $userId');
      _logger.info('Cihaz Tipi: $deviceType');
      _logger.info('Cihaz ID: $deviceId');

      Map<String, dynamic> defaultSettings = {};

      if (deviceType == 'food_bowl') {
        defaultSettings = {
          'foodBowlSettings': {
            'foodLevel': 2000,
            'maxCapacity': 2000,
            'portionSize': 100,
          }
        };
      } else if (deviceType == 'water_bowl') {
        defaultSettings = {
          'waterBowlSettings': {
            'waterLevel': 2000,
            'maxCapacity': 2000,
            'portionSize': 100,
          }
        };
      }

      await collectionRef.doc(deviceId).set({
        'userId': userId,
        'deviceType': deviceType,
        'deviceName': deviceName,
        'deviceId': deviceId,
        'status': initialStatus,
        'lastUpdated': FieldValue.serverTimestamp(),
        'createdAt': FieldValue.serverTimestamp(),
        'isActive': true,
        'batteryLevel': 100,
        ...defaultSettings,
        'generalSettings': {
          'isNotificationEnabled': true,
          'updateInterval': 5,
          'deviceLocation': 'Ev',
        },
        'lightSettings': {
          'isLightOpen': false,
          'lightDuration': 30,
        },
      });

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
      final querySnapshot = await _firestore
          .collection('devices')
          .where('userId', isEqualTo: userId)
          .where('deviceType', isEqualTo: deviceType)
          .get();

      return querySnapshot.docs.isNotEmpty;
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
