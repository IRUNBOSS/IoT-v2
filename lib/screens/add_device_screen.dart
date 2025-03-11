import 'package:flutter/material.dart';
import 'package:iot/services/device_service.dart';
import 'package:iot/screens/home_screen.dart';
import 'package:iot/services/snackbar_service.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddDeviceScreen extends StatefulWidget {
  const AddDeviceScreen({super.key});

  @override
  State<AddDeviceScreen> createState() => _AddDeviceScreenState();
}

class _AddDeviceScreenState extends State<AddDeviceScreen> {
  final TextEditingController _deviceCodeController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _deviceCodeController.dispose();
    super.dispose();
  }

  // Cihaz kodunun formatını kontrol eden metod
  bool _isValidDeviceCodeFormat(String code) {
    // Cihaz kodu formatı: Harf(ler) + en fazla 4 rakam
    final RegExp validFormat = RegExp(r'^[A-Za-z]+\d{0,4}$');
    return validFormat.hasMatch(code);
  }

  Future<void> _handleAddDevice(BuildContext context) async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    // Cihaz kodunu büyük harfe dönüştür
    final deviceCode = _deviceCodeController.text.trim().toUpperCase();

    // Cihaz kodunun ilk harfine göre cihaz türünü belirleme
    if (deviceCode.isNotEmpty) {
      // MS ile başlıyorsa hem mama hem su kabı oluştur
      if (deviceCode.length >= 2 &&
          deviceCode.substring(0, 2).toUpperCase() == 'MS') {
        // Önce mama kabı ekle
        await _addSingleDevice(
          context: context,
          deviceCode: deviceCode,
          deviceType: 'food_bowl',
          deviceName: AppLocalizations.of(context)!.smartFoodBowl,
        );

        // Sonra su kabı ekle
        if (context.mounted) {
          await _addSingleDevice(
            context: context,
            deviceCode: deviceCode,
            deviceType: 'water_bowl',
            deviceName: AppLocalizations.of(context)!.smartWaterBowl,
            showSuccessMessage:
                true, // Sadece son cihaz eklendiğinde başarı mesajı göster
          );
        }

        // Ana sayfaya yönlendir
        if (context.mounted) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const HomeScreen()),
            (route) => false,
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

        final deviceId =
            '${deviceType.toUpperCase()}_${DateTime.now().millisecondsSinceEpoch}';

        try {
          await DeviceService().addNewDevice(
            deviceType: deviceType,
            deviceName: deviceName,
            deviceId: deviceId,
            initialStatus: 'online',
            deviceCode: deviceCode,
          );

          if (context.mounted) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const HomeScreen()),
              (route) => false,
            );

            SnackbarService.showSnackbar(
              context,
              message: AppLocalizations.of(context)!.deviceAddedSuccess,
            );
          }
        } catch (e) {
          if (context.mounted) {
            SnackbarService.showSnackbar(
              context,
              message:
                  AppLocalizations.of(context)!.errorOccurred(e.toString()),
              isError: true,
            );
          }
        }
      }
    }
  }

  // Tek bir cihaz eklemek için yardımcı metod
  Future<void> _addSingleDevice({
    required BuildContext context,
    required String deviceCode,
    required String deviceType,
    required String deviceName,
    bool showSuccessMessage = false,
  }) async {
    final deviceId =
        '${deviceType.toUpperCase()}_${DateTime.now().millisecondsSinceEpoch}';

    try {
      await DeviceService().addNewDevice(
        deviceType: deviceType,
        deviceName: deviceName,
        deviceId: deviceId,
        initialStatus: 'online',
        deviceCode: deviceCode,
      );

      if (showSuccessMessage && context.mounted) {
        SnackbarService.showSnackbar(
          context,
          message: AppLocalizations.of(context)!.deviceAddedSuccess,
        );
      }

      return;
    } catch (e) {
      if (context.mounted) {
        SnackbarService.showSnackbar(
          context,
          message: AppLocalizations.of(context)!.errorOccurred(e.toString()),
          isError: true,
        );
      }
      throw e; // Hata durumunda üst metoda ilet
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final Color blueColor = Colors.blue;
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          localizations.addDevice,
          style: TextStyle(color: blueColor),
        ),
        iconTheme: IconThemeData(color: blueColor),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(20),
            constraints: const BoxConstraints(maxWidth: 400),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Icon(
                    Icons.devices,
                    size: 80,
                    color: blueColor,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    localizations.enterDeviceCode,
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: blueColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    localizations.deviceCodeInfo,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[700],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    localizations.deviceCodeFormat,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[700],
                      fontStyle: FontStyle.italic,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 30),
                  TextFormField(
                    controller: _deviceCodeController,
                    decoration: InputDecoration(
                      labelText: localizations.addDevice,
                      labelStyle: TextStyle(color: blueColor),
                      hintText: localizations.deviceCodeHint,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: blueColor),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            BorderSide(color: blueColor.withOpacity(0.5)),
                      ),
                      prefixIcon: Icon(Icons.qr_code, color: blueColor),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: blueColor, width: 2),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return localizations.deviceCodeRequired;
                      }

                      // Cihaz kodu formatını kontrol et
                      if (!_isValidDeviceCodeFormat(value)) {
                        return localizations.deviceCodeInvalidFormat;
                      }

                      return null;
                    },
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 18,
                      letterSpacing: 1.5,
                    ),
                    cursorColor: blueColor,
                    // Girilen metni otomatik olarak büyük harfe dönüştür
                    textCapitalization: TextCapitalization.characters,
                    // Klavyeyi büyük harfle başlat
                    textInputAction: TextInputAction.done,
                    // Klavye tipini belirle (harfler ve sayılar)
                    keyboardType: TextInputType.text,
                    // Metin değiştiğinde çalışacak fonksiyon
                    onChanged: (value) {
                      // Metni büyük harfe dönüştür
                      String upperCaseValue = value.toUpperCase();

                      // Harfler ve sayıları ayır
                      final RegExp letterRegex = RegExp(r'[A-Z]+');
                      final RegExp digitRegex = RegExp(r'\d+');

                      final letterMatches =
                          letterRegex.allMatches(upperCaseValue);
                      final digitMatches =
                          digitRegex.allMatches(upperCaseValue);

                      String letters = '';
                      String digits = '';

                      // Harfleri al
                      if (letterMatches.isNotEmpty) {
                        letters = letterMatches.map((m) => m.group(0)).join();
                      }

                      // Sayıları al ve en fazla 4 tanesini kullan
                      if (digitMatches.isNotEmpty) {
                        digits = digitMatches.map((m) => m.group(0)).join();
                        if (digits.length > 4) {
                          digits = digits.substring(0, 4);

                          // Kullanıcıya uyarı göster
                          SnackbarService.showSnackbar(
                            context,
                            message: AppLocalizations.of(context)!
                                .deviceCodeMaxDigits,
                            isError: true,
                          );
                        }
                      }

                      // Yeni değeri oluştur (önce harfler, sonra sayılar)
                      final newValue = letters + digits;

                      // Eğer değer değişmediyse bir şey yapma
                      if (value == newValue) return;

                      // Değiştiyse, yeni değeri ayarla ve imleci sona al
                      _deviceCodeController.value = TextEditingValue(
                        text: newValue,
                        selection:
                            TextSelection.collapsed(offset: newValue.length),
                      );
                    },
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () => _handleAddDevice(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: blueColor,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 2,
                    ),
                    child: Text(
                      localizations.addDeviceButton,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
