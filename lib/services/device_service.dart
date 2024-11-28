import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:iot/services/database_service.dart';
import 'package:logging/logging.dart';

class DeviceService {
  final DatabaseService _db = DatabaseService();
  final _logger = Logger('DeviceService');

  // Stream önbelleğe alma için
  final Map<String, Stream<DocumentSnapshot>> _deviceStreams = {};

  Future<void> addNewDevice({
    required String deviceType,
    required String deviceName,
    required String deviceId,
    required String initialStatus,
    Map<String, dynamic>? customSettings,
  }) async {
    try {
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
      } else if (customSettings != null) {
        defaultSettings = {'customSettings': customSettings};
      }

      await _db.addDevice(
        deviceType: deviceType,
        deviceName: deviceName,
        deviceId: deviceId,
        initialStatus: initialStatus,
        defaultSettings: defaultSettings,
      );
    } catch (e) {
      _logger.severe('DeviceService addNewDevice hatası: $e');
      rethrow;
    }
  }

  Stream<QuerySnapshot> getUserDevices() {
    return _db.getUserDevices();
  }

  Future<void> updateDeviceStatus(String deviceId, String status) async {
    await _db.updateDeviceStatus(deviceId, status);
  }

  Future<void> deleteDevice(String deviceId) async {
    await _db.deleteDevice(deviceId);
  }

  Future<void> updateWaterBowlSettings({
    required String deviceId,
    required Map<String, dynamic> settings,
  }) async {
    await _db.updateDeviceSettings(
      deviceId: deviceId,
      settingsKey: 'waterBowlSettings',
      settings: settings,
    );
  }

  Future<void> updateFoodBowlSettings({
    required String deviceId,
    required Map<String, dynamic> settings,
  }) async {
    await _db.updateDeviceSettings(
      deviceId: deviceId,
      settingsKey: 'foodBowlSettings',
      settings: settings,
    );
  }

  Stream<DocumentSnapshot> getDeviceStream(String deviceId) {
    if (!_deviceStreams.containsKey(deviceId)) {
      _deviceStreams[deviceId] = _db.getDeviceStream(deviceId);
    }
    return _deviceStreams[deviceId]!;
  }

  Future<bool> checkIfDeviceTypeExists(String deviceType) async {
    final snapshot = await _db.getUserDevices().first;
    return snapshot.docs.any((doc) => doc['deviceType'] == deviceType);
  }

  Future<void> updateDeviceLocation({
    required String deviceId,
    required String location,
  }) async {
    await _db.updateDeviceSettings(
      deviceId: deviceId,
      settingsKey: 'generalSettings',
      settings: {'deviceLocation': location},
    );
  }

  void disposeDeviceStream(String deviceId) {
    _deviceStreams.remove(deviceId);
  }

  // Widget dispose olduğunda çağrılmalı
  void dispose() {
    _deviceStreams.clear();
  }
}
