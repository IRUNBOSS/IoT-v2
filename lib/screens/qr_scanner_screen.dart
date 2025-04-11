import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:iot/services/snackbar_service.dart';
import 'package:iot/screens/home_screen.dart';

class QRScannerScreen extends StatefulWidget {
  const QRScannerScreen({super.key});

  @override
  State<QRScannerScreen> createState() => _QRScannerScreenState();
}

class _QRScannerScreenState extends State<QRScannerScreen> {
  final MobileScannerController cameraController = MobileScannerController();
  bool _isLoading = false;
  bool _isTorchOn = false;
  bool _hasScanned = false;

  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }

  // Cihaz kodunun formatını kontrol eden metod
  bool _isValidDeviceCodeFormat(String code) {
    // Cihaz kodu formatı: Harf(ler) + en fazla 4 rakam
    final RegExp validFormat = RegExp(r'^[A-Za-z]+\d{0,4}$');
    return validFormat.hasMatch(code);
  }

  Future<void> _handleScannedCode(String scannedCode) async {
    if (_hasScanned) return;

    setState(() {
      _hasScanned = true;
    });

    if (!_isValidDeviceCodeFormat(scannedCode)) {
      if (mounted) {
        SnackbarService.showSnackbar(
          context,
          message: AppLocalizations.of(context)!.qrInvalidFormat,
          isError: true,
        );
        setState(() {
          _hasScanned = false;
        });
      }
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final deviceCode = scannedCode.trim().toUpperCase();
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        throw Exception('Kullanıcı oturum açmamış');
      }

      // MS ile başlıyorsa hem mama hem su kabı oluştur
      if (deviceCode.length >= 2 &&
          deviceCode.substring(0, 2).toUpperCase() == 'MS') {
        // Önce mama kabı ekle
        await _addSingleDevice(
          userId: user.uid,
          deviceCode: 'M${deviceCode.substring(2)}',
          deviceType: 'food_bowl',
          deviceName: AppLocalizations.of(context)!.smartFoodBowl,
        );

        // Sonra su kabı ekle
        if (mounted) {
          await _addSingleDevice(
            userId: user.uid,
            deviceCode: 'S${deviceCode.substring(2)}',
            deviceType: 'water_bowl',
            deviceName: AppLocalizations.of(context)!.smartWaterBowl,
          );
        }

        if (mounted) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const HomeScreen()),
            (route) => false,
          );
          SnackbarService.showSnackbar(
            context,
            message: AppLocalizations.of(context)!.qrScanSuccess,
          );
        }
      } else {
        // Tek bir cihaz ekle
        final firstLetter = deviceCode[0].toUpperCase();
        String deviceType = 'custom_device';
        String deviceName = 'Cihaz';

        if (firstLetter == 'M') {
          deviceType = 'food_bowl';
          deviceName = AppLocalizations.of(context)!.smartFoodBowl;
        } else if (firstLetter == 'S') {
          deviceType = 'water_bowl';
          deviceName = AppLocalizations.of(context)!.smartWaterBowl;
        }

        await _addSingleDevice(
          userId: user.uid,
          deviceCode: deviceCode,
          deviceType: deviceType,
          deviceName: deviceName,
        );

        if (mounted) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const HomeScreen()),
            (route) => false,
          );
          SnackbarService.showSnackbar(
            context,
            message: AppLocalizations.of(context)!.qrScanSuccess,
          );
        }
      }
    } catch (e) {
      if (mounted) {
        SnackbarService.showSnackbar(
          context,
          message: AppLocalizations.of(context)!.qrScanError,
          isError: true,
        );
        setState(() {
          _hasScanned = false;
        });
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _addSingleDevice({
    required String userId,
    required String deviceCode,
    required String deviceType,
    required String deviceName,
  }) async {
    final deviceId =
        '${deviceType.toUpperCase()}_${DateTime.now().millisecondsSinceEpoch}';
    final deviceSettings = _getDeviceSettings(deviceType);

    await FirebaseFirestore.instance.collection('devices').doc(deviceId).set({
      'userId': userId,
      'deviceType': deviceType,
      'deviceName': deviceName,
      'deviceId': deviceId,
      'deviceCode': deviceCode,
      'status': 'online',
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
      'lightSettings': deviceType == 'food_bowl' || deviceType == 'water_bowl'
          ? {
              'isLightOpen': false,
              'lightDuration': 30,
            }
          : null,
    });
  }

  Map<String, dynamic> _getDeviceSettings(String deviceType) {
    switch (deviceType) {
      case 'food_bowl':
        return {
          'foodBowlSettings': {
            'foodLevel': 2000,
            'maxCapacity': 2000,
            'portionSize': 100,
            'feedingSchedule': [],
            'lastFeeding': null,
            'autoFeedingEnabled': false,
          }
        };
      case 'water_bowl':
        return {
          'waterBowlSettings': {
            'waterLevel': 2000,
            'maxCapacity': 2000,
            'portionSize': 100,
            'cleaningSchedule': [],
            'lastCleaning': null,
            'autoCleaningEnabled': false,
          }
        };
      default:
        return {
          'settings': {
            'level': 2000,
            'maxCapacity': 2000,
            'portionSize': 100,
          }
        };
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.qrScanner),
        actions: [
          IconButton(
            icon: Icon(_isTorchOn ? Icons.flash_on : Icons.flash_off),
            onPressed: () {
              setState(() {
                _isTorchOn = !_isTorchOn;
                cameraController.toggleTorch();
              });
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          if (!_hasScanned)
            MobileScanner(
              controller: cameraController,
              onDetect: (capture) {
                final List<Barcode> barcodes = capture.barcodes;
                for (final barcode in barcodes) {
                  if (barcode.rawValue != null) {
                    _handleScannedCode(barcode.rawValue!);
                    break;
                  }
                }
              },
            ),
          if (_isLoading)
            Container(
              color: Colors.black.withOpacity(0.5),
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
          if (_hasScanned && !_isLoading)
            Container(
              color: Colors.black.withOpacity(0.5),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CircularProgressIndicator(),
                    const SizedBox(height: 20),
                    Text(
                      AppLocalizations.of(context)!.qrProcessing,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
