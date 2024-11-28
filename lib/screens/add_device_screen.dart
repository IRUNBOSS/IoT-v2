import 'package:flutter/material.dart';
import 'package:iot/services/device_service.dart';
import 'package:iot/screens/home_screen.dart';
import 'package:iot/services/snackbar_service.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:logging/logging.dart';

final _logger = Logger('AddDeviceScreen');

class CustomDeviceProperty {
  String name;
  String type;
  dynamic defaultValue;

  CustomDeviceProperty({
    required this.name,
    required this.type,
    required this.defaultValue,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'type': type,
      'value': defaultValue,
    };
  }
}

class AddDeviceScreen extends StatelessWidget {
  const AddDeviceScreen({super.key});

  Future<void> _handleDeviceSelection(
    BuildContext context,
    String deviceType,
    String deviceName,
    String deviceId,
    Map<String, dynamic> customSettings,
  ) async {
    try {
      if (!context.mounted) return;

      final deviceExists =
          await DeviceService().checkIfDeviceTypeExists(deviceType);

      if (!context.mounted) return;

      if (deviceExists) {
        SnackbarService.showSnackbar(
          context,
          message: AppLocalizations.of(context)!.deviceAlreadyExists,
          isError: true,
        );
        return;
      }

      _logger.info('Cihaz ekleniyor: $deviceType, $deviceName, $deviceId');

      await DeviceService().addNewDevice(
        deviceType: deviceType,
        deviceName: deviceName,
        deviceId: deviceId,
        initialStatus: 'online',
        customSettings: customSettings,
      );

      if (!context.mounted) return;

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
        (route) => false,
      );

      SnackbarService.showSnackbar(
        context,
        message: AppLocalizations.of(context)!.deviceAddedSuccess,
      );
    } catch (e) {
      _logger.warning('Cihaz ekleme hatası: $e');
      if (!context.mounted) return;

      SnackbarService.showSnackbar(
        context,
        message: AppLocalizations.of(context)!.errorOccurred(e.toString()),
        isError: true,
      );
    }
  }

  Future<void> _showCustomDeviceDialog(BuildContext context) async {
    final formKey = GlobalKey<FormState>();
    final deviceNameController = TextEditingController();
    final deviceTypeController = TextEditingController();
    final List<Map<String, dynamic>> sensors = [];

    void addSensor() {
      sensors.add({
        'name': '',
        'unit': '',
        'value': 0,
      });
    }

    final result = await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          backgroundColor: Theme.of(context).cardColor,
          child: Container(
            padding: const EdgeInsets.all(24),
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.addCustomDevice,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).textTheme.titleLarge?.color,
                      ),
                    ),
                    const SizedBox(height: 24),
                    TextFormField(
                      controller: deviceNameController,
                      decoration: InputDecoration(
                        labelText: AppLocalizations.of(context)!.deviceName,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide:
                              BorderSide(color: Colors.blue.withOpacity(0.3)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide:
                              BorderSide(color: Colors.blue.withOpacity(0.3)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide:
                              const BorderSide(color: Colors.blue, width: 2),
                        ),
                        prefixIcon:
                            const Icon(Icons.devices, color: Colors.blue),
                        filled: true,
                        fillColor:
                            Theme.of(context).brightness == Brightness.dark
                                ? Colors.blue.withOpacity(0.1)
                                : Colors.blue.shade50,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return AppLocalizations.of(context)!
                              .deviceNameRequired;
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: deviceTypeController,
                      decoration: InputDecoration(
                        labelText: AppLocalizations.of(context)!.deviceType,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide:
                              BorderSide(color: Colors.blue.withOpacity(0.3)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide:
                              BorderSide(color: Colors.blue.withOpacity(0.3)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide:
                              const BorderSide(color: Colors.blue, width: 2),
                        ),
                        prefixIcon:
                            const Icon(Icons.category, color: Colors.blue),
                        filled: true,
                        fillColor:
                            Theme.of(context).brightness == Brightness.dark
                                ? Colors.blue.withOpacity(0.1)
                                : Colors.blue.shade50,
                        helperText:
                            AppLocalizations.of(context)!.deviceTypeHelper,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return AppLocalizations.of(context)!
                              .deviceTypeRequired;
                        }
                        if (value == 'food_bowl' || value == 'water_bowl') {
                          return AppLocalizations.of(context)!
                              .deviceTypeReserved;
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Sensörler',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              addSensor();
                            });
                          },
                          icon: const Icon(Icons.add_circle),
                          color: Colors.blue,
                          tooltip: 'Sensör Ekle',
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    ...sensors.asMap().entries.map((entry) {
                      final index = entry.key;
                      final sensor = entry.value;
                      return Card(
                        color: Theme.of(context).cardColor,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                          side: BorderSide(
                            color:
                                Theme.of(context).dividerColor.withOpacity(0.1),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                        labelText: 'Sensör Adı',
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          borderSide: BorderSide(
                                              color:
                                                  Colors.blue.withOpacity(0.3)),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          borderSide: BorderSide(
                                              color:
                                                  Colors.blue.withOpacity(0.3)),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          borderSide: const BorderSide(
                                              color: Colors.blue, width: 2),
                                        ),
                                        prefixIcon: const Icon(Icons.sensors,
                                            color: Colors.blue),
                                        filled: true,
                                        fillColor:
                                            Theme.of(context).brightness ==
                                                    Brightness.dark
                                                ? Colors.blue.withOpacity(0.1)
                                                : Colors.blue.shade50,
                                      ),
                                      onChanged: (value) {
                                        sensor['name'] = value;
                                      },
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Sensör adı gerekli';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  IconButton(
                                    icon: const Icon(Icons.delete),
                                    color: Colors.red,
                                    onPressed: () {
                                      setState(() {
                                        sensors.removeAt(index);
                                      });
                                    },
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              TextFormField(
                                decoration: InputDecoration(
                                  labelText: 'Birim',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide(
                                        color: Colors.blue.withOpacity(0.3)),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide(
                                        color: Colors.blue.withOpacity(0.3)),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: const BorderSide(
                                        color: Colors.blue, width: 2),
                                  ),
                                  prefixIcon: const Icon(Icons.straighten,
                                      color: Colors.blue),
                                  filled: true,
                                  fillColor: Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? Colors.blue.withOpacity(0.1)
                                      : Colors.blue.shade50,
                                  hintText: 'Örn: °C, %, km/h',
                                ),
                                onChanged: (value) {
                                  sensor['unit'] = value;
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text(
                            AppLocalizations.of(context)!.cancel,
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                        const SizedBox(width: 16),
                        ElevatedButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              Map<String, dynamic> customSettings = {};
                              for (var sensor in sensors) {
                                if (sensor['name'] != null &&
                                    sensor['name'].isNotEmpty) {
                                  customSettings[sensor['name']] = {
                                    'type': 'number',
                                    'value': 0,
                                    'unit': sensor['unit'] ?? '',
                                  };
                                }
                              }

                              Navigator.pop(context, {
                                'deviceName': deviceNameController.text,
                                'deviceType':
                                    deviceTypeController.text.toLowerCase(),
                                'customSettings': customSettings,
                              });
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 12,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Text(
                            AppLocalizations.of(context)!.add,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );

    if (result != null) {
      if (!context.mounted) return;
      await _handleDeviceSelection(
        context,
        result['deviceType']!,
        result['deviceName']!,
        '${result['deviceType']!.toUpperCase()}_${DateTime.now().millisecondsSinceEpoch}',
        result['customSettings'] as Map<String, dynamic>,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.addDevice),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildDeviceItem(
              context,
              AppLocalizations.of(context)!.smartFoodBowl,
              Icons.pets,
              AppLocalizations.of(context)!.smartFoodBowlDesc,
              () => _handleDeviceSelection(
                context,
                'food_bowl',
                AppLocalizations.of(context)!.smartFoodBowl,
                'FOOD_${DateTime.now().millisecondsSinceEpoch}',
                {},
              ),
            ),
            const SizedBox(height: 15),
            _buildDeviceItem(
              context,
              AppLocalizations.of(context)!.smartWaterBowl,
              Icons.water_drop,
              AppLocalizations.of(context)!.smartWaterBowlDesc,
              () => _handleDeviceSelection(
                context,
                'water_bowl',
                AppLocalizations.of(context)!.smartWaterBowl,
                'WATER_${DateTime.now().millisecondsSinceEpoch}',
                {},
              ),
            ),
            const SizedBox(height: 15),
            _buildDeviceItem(
              context,
              AppLocalizations.of(context)!.customDevice,
              Icons.devices_other,
              AppLocalizations.of(context)!.customDeviceDesc,
              () => _showCustomDeviceDialog(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDeviceItem(
    BuildContext context,
    String title,
    IconData icon,
    String description,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Theme.of(context).brightness == Brightness.dark
              ? Colors.blue.withOpacity(0.1)
              : Colors.blue.shade50,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Colors.blue.withOpacity(0.2),
          ),
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.blue, size: 30),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
