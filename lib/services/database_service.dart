import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:logging/logging.dart';

class DatabaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String? userId = FirebaseAuth.instance.currentUser?.uid;
  final _logger = Logger('DatabaseService');

  // Cihaz koleksiyonu referansı
  CollectionReference get devicesCollection => _firestore.collection('devices');

  // Kullanıcı kontrolü
  void _checkUserAuth() {
    if (userId == null) throw Exception('Kullanıcı oturum açmamış');
  }

  // Cihaz ekleme
  Future<void> addDevice({
    required String deviceType,
    required String deviceName,
    required String deviceId,
    required String initialStatus,
    required Map<String, dynamic> defaultSettings,
  }) async {
    _checkUserAuth();

    try {
      await devicesCollection.doc(deviceId).set({
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
      });

      _logger.info('Cihaz başarıyla eklendi: $deviceId');
    } catch (e) {
      _logger.severe('Cihaz eklenirken hata: $e');
      throw DatabaseException('Cihaz eklenirken bir hata oluştu', e);
    }
  }

  // Kullanıcının cihazlarını getir
  Stream<QuerySnapshot> getUserDevices() {
    _checkUserAuth();

    return devicesCollection
        .where('userId', isEqualTo: userId)
        .snapshots()
        .handleError((error) {
      _logger.severe('Firestore stream hatası: $error');
      return const Stream.empty();
    });
  }

  // Cihaz durumunu güncelle
  Future<void> updateDeviceStatus(String deviceId, String status) async {
    _checkUserAuth();

    try {
      await devicesCollection.doc(deviceId).update({
        'status': status,
        'lastUpdated': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      _logger.severe('Cihaz durumu güncellenirken hata: $e');
      throw Exception('Cihaz durumu güncellenirken bir hata oluştu: $e');
    }
  }

  // Cihaz ayarlarını güncelle
  Future<void> updateDeviceSettings({
    required String deviceId,
    required String settingsKey,
    required Map<String, dynamic> settings,
  }) async {
    _checkUserAuth();

    try {
      await devicesCollection.doc(deviceId).update({
        settingsKey: settings,
        'lastUpdated': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw Exception('Cihaz ayarları güncellenirken bir hata oluştu: $e');
    }
  }

  // Cihaz sil
  Future<void> deleteDevice(String deviceId) async {
    _checkUserAuth();

    try {
      await devicesCollection.doc(deviceId).delete();
    } catch (e) {
      throw Exception('Cihaz silinirken bir hata oluştu: $e');
    }
  }

  // Cihaz stream'i al
  Stream<DocumentSnapshot> getDeviceStream(String deviceId) {
    _checkUserAuth();

    try {
      return devicesCollection.doc(deviceId).snapshots().handleError((error) {
        _logger.severe('Firestore stream hatası: $error');
        throw Exception('Cihaz verisi alınırken bir hata oluştu: $error');
      });
    } catch (e) {
      _logger.severe('Stream oluşturulurken hata: $e');
      throw Exception('Stream oluşturulurken bir hata oluştu: $e');
    }
  }
}

class DatabaseException implements Exception {
  final String message;
  final dynamic originalError;

  DatabaseException(this.message, this.originalError);

  @override
  String toString() => '$message (Orijinal hata: $originalError)';
}
