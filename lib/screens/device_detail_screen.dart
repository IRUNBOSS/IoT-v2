import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:iot/services/device_service.dart';
import 'package:iot/screens/home_screen.dart';
import 'package:iot/services/snackbar_service.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'dart:async';

class DeviceDetailScreen extends StatelessWidget {
  final DocumentSnapshot device;

  const DeviceDetailScreen({
    super.key,
    required this.device,
  });

  Future<void> _deleteDevice(BuildContext context) async {
    try {
      final confirmed = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: Theme.of(context).cardColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Column(
            children: [
              Icon(
                Icons.warning_amber_rounded,
                size: 40,
                color: Theme.of(context).colorScheme.error,
              ),
              const SizedBox(height: 10),
              Text(
                AppLocalizations.of(context)!.delete,
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodyLarge?.color,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          content: Text(
            AppLocalizations.of(context)!.deleteConfirmation,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Theme.of(context).textTheme.bodyMedium?.color,
            ),
          ),
          actions: [
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: Text(
                      AppLocalizations.of(context)!.cancel,
                      style: const TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(true),
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          Theme.of(context).colorScheme.errorContainer,
                      foregroundColor: Theme.of(context).colorScheme.error,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      AppLocalizations.of(context)!.delete,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );

      if (confirmed == true) {
        final deviceData = device.data() as Map<String, dynamic>;
        await DeviceService().deleteDevice(deviceData['deviceId']);

        if (context.mounted) {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const HomeScreen()),
            (route) => false,
          );

          SnackbarService.showSnackbar(
            context,
            message: AppLocalizations.of(context)!.deviceIsDeleted,
          );
        }
      }
    } catch (e) {
      if (context.mounted) {
        SnackbarService.showSnackbar(
          context,
          message:
              AppLocalizations.of(context)!.errorDeletingDevice(e.toString()),
          isError: true,
        );
      }
    }
  }

  Widget _buildFoodBowlContent(
      Map<String, dynamic> deviceData, BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: DeviceService().getDeviceStream(deviceData['deviceId']),
      builder: (context, snapshot) {
        if (!snapshot.hasData || !snapshot.data!.exists) {
          return const Center(child: CircularProgressIndicator());
        }

        final updatedDeviceData =
            snapshot.data!.data() as Map<String, dynamic>?;
        if (updatedDeviceData == null) {
          return const Center(child: Text('Cihaz verisi bulunamadı'));
        }

        final Map<String, dynamic> foodBowlSettings =
            updatedDeviceData['foodBowlSettings'] as Map<String, dynamic>? ??
                {};

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Porsiyon Miktarı Kartı
            _buildPortionSizeCard(
                context, foodBowlSettings, deviceData['deviceId']),
            const SizedBox(height: 10),

            // Mama Boşalt Kartı
            _buildDeviceCard(
                context,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSectionTitle(
                        context, AppLocalizations.of(context)!.manualFeeding),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () async {
                          try {
                            final currentFoodLevel =
                                foodBowlSettings['foodLevel'] as int;
                            final portionSize =
                                foodBowlSettings['portionSize'] as int;

                            if (currentFoodLevel < portionSize) {
                              SnackbarService.showSnackbar(
                                context,
                                message:
                                    AppLocalizations.of(context)!.notEnoughFood,
                                isError: true,
                              );
                              return;
                            }

                            final newFoodLevel = currentFoodLevel - portionSize;

                            await DeviceService().updateFoodBowlSettings(
                              deviceId: deviceData['deviceId'],
                              settings: {
                                ...foodBowlSettings,
                                'foodLevel':
                                    newFoodLevel >= 0 ? newFoodLevel : 0,
                              },
                            );

                            if (context.mounted) {
                              SnackbarService.showSnackbar(
                                context,
                                message: AppLocalizations.of(context)!
                                    .foodDispensed(portionSize.toString()),
                              );
                            }
                          } catch (e) {
                            if (context.mounted) {
                              SnackbarService.showSnackbar(
                                context,
                                message: AppLocalizations.of(context)!
                                    .errorUpdatingSettings(e.toString()),
                                isError: true,
                              );
                            }
                          }
                        },
                        icon: const Icon(Icons.pets),
                        label: Text(
                            '${foodBowlSettings['portionSize']} saniye Mama Ver'),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                  ],
                )),

            // Cihaz Durumu Kartı
            _buildDeviceStatusCard(context, updatedDeviceData),
          ],
        );
      },
    );
  }

  Widget _buildWaterBowlContent(
      Map<String, dynamic> deviceData, BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: DeviceService().getDeviceStream(deviceData['deviceId']),
      builder: (context, snapshot) {
        if (!snapshot.hasData || !snapshot.data!.exists) {
          return const Center(child: CircularProgressIndicator());
        }

        final updatedDeviceData =
            snapshot.data!.data() as Map<String, dynamic>?;
        if (updatedDeviceData == null) {
          return const Center(child: Text('Cihaz verisi bulunamadı'));
        }

        final Map<String, dynamic> waterBowlSettings =
            updatedDeviceData['waterBowlSettings'] as Map<String, dynamic>? ??
                {};

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Porsiyon Miktarı Kartı
            _buildWaterPortionSizeCard(
                context, waterBowlSettings, deviceData['deviceId']),
            const SizedBox(height: 10),

            // Su Boşalt Kartı
            _buildDeviceCard(
                context,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSectionTitle(
                        context, AppLocalizations.of(context)!.manualWatering),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: waterBowlSettings['waterLevel'] == 0
                            ? null
                            : () async {
                                try {
                                  final currentWaterLevel =
                                      waterBowlSettings['waterLevel'] as int;
                                  final portionSize =
                                      waterBowlSettings['portionSize'] as int;

                                  if (currentWaterLevel < portionSize) {
                                    SnackbarService.showSnackbar(
                                      context,
                                      message: AppLocalizations.of(context)!
                                          .notEnoughFood,
                                      isError: true,
                                    );
                                    return;
                                  }

                                  final newWaterLevel =
                                      currentWaterLevel - portionSize;

                                  await DeviceService().updateWaterBowlSettings(
                                    deviceId: deviceData['deviceId'],
                                    settings: {
                                      ...waterBowlSettings,
                                      'waterLevel': newWaterLevel >= 0
                                          ? newWaterLevel
                                          : 0,
                                    },
                                  );

                                  if (context.mounted) {
                                    SnackbarService.showSnackbar(
                                      context,
                                      message: AppLocalizations.of(context)!
                                          .waterPortionAmount(
                                              portionSize.toString()),
                                    );
                                  }
                                } catch (e) {
                                  if (context.mounted) {
                                    SnackbarService.showSnackbar(
                                      context,
                                      message: AppLocalizations.of(context)!
                                          .errorUpdatingSettings(e.toString()),
                                      isError: true,
                                    );
                                  }
                                }
                              },
                        icon: const Icon(Icons.water_drop),
                        label: Text(
                            '${waterBowlSettings['portionSize']} saniye Su Ver'),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                  ],
                )),

            // Cihaz Durumu Kartı
            _buildDeviceStatusCard(context, updatedDeviceData),
          ],
        );
      },
    );
  }

  Future<void> _showPortionEditDialog(
    BuildContext context,
    String deviceId,
    Map<String, dynamic> currentSettings,
  ) async {
    final maxCapacity = 600.0;
    double sliderValue = (currentSettings['portionSize'] != null &&
            currentSettings['portionSize'] >= 1 &&
            currentSettings['portionSize'] <= 600)
        ? currentSettings['portionSize'].toDouble()
        : 5.0;
    final TextEditingController portionController = TextEditingController(
      text: sliderValue.toInt().toString(),
    );

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Theme.of(context).cardColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        title: Column(
          children: [
            Icon(
              Icons.timer,
              size: 40,
              color: Colors.blue,
            ),
            const SizedBox(height: 10),
            Text(
              'Porsiyon Miktarı',
              style: TextStyle(
                color: Theme.of(context).textTheme.bodyLarge?.color,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        content: StatefulBuilder(
          builder: (context, setState) => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '${sliderValue.toInt()} saniye',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              const SizedBox(height: 20),
              SliderTheme(
                data: SliderThemeData(
                  activeTrackColor: Colors.blue,
                  thumbColor: Colors.blue,
                  overlayColor: Colors.blue.withOpacity(0.2),
                  valueIndicatorColor: Colors.blue,
                  valueIndicatorTextStyle: const TextStyle(color: Colors.white),
                ),
                child: Slider(
                  value: sliderValue,
                  min: 1,
                  max: 600,
                  divisions: 599,
                  label: '${sliderValue.toInt()} saniye',
                  onChanged: (value) {
                    setState(() {
                      sliderValue = value;
                      portionController.text = value.toInt().toString();
                    });
                  },
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: portionController,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodyLarge?.color,
                  fontSize: 18,
                ),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Theme.of(context).brightness == Brightness.dark
                      ? Colors.grey[800]
                      : Colors.grey[100],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none,
                  ),
                  suffixText: 'saniye',
                  hintText: 'Saniye',
                ),
                onChanged: (value) {
                  final newValue = int.tryParse(value);
                  if (newValue != null && newValue >= 1 && newValue <= 600) {
                    setState(() {
                      sliderValue = newValue.toDouble();
                    });
                  }
                },
              ),
            ],
          ),
        ),
        actionsPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        actions: [
          Row(
            children: [
              Expanded(
                child: TextButton(
                  onPressed: () => Navigator.pop(context),
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    textStyle: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  child: const Text('İptal'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  onPressed: () async {
                    final newPortionSize = int.tryParse(portionController.text);
                    if (newPortionSize != null &&
                        newPortionSize >= 1 &&
                        newPortionSize <= 600) {
                      try {
                        if (currentSettings.containsKey('foodLevel')) {
                          await DeviceService().updateFoodBowlSettings(
                            deviceId: deviceId,
                            settings: {
                              ...currentSettings,
                              'portionSize': newPortionSize,
                            },
                          );
                        } else {
                          await DeviceService().updateWaterBowlSettings(
                            deviceId: deviceId,
                            settings: {
                              ...currentSettings,
                              'portionSize': newPortionSize,
                            },
                          );
                        }

                        if (context.mounted) {
                          Navigator.pop(context);
                          SnackbarService.showSnackbar(
                            context,
                            message: 'Ayarlar güncellendi',
                          );
                        }
                      } catch (e) {
                        if (context.mounted) {
                          Navigator.pop(context);
                          SnackbarService.showSnackbar(
                            context,
                            message: AppLocalizations.of(context)!
                                .errorUpdatingSettings(e.toString()),
                            isError: true,
                          );
                        }
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    textStyle: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  child: const Text('Kaydet'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _showLocationEditDialog(
    BuildContext context,
    String deviceId,
    String currentLocation,
  ) async {
    final TextEditingController locationController = TextEditingController(
      text: currentLocation,
    );

    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(AppLocalizations.of(context)!.editLocation),
        content: TextField(
          controller: locationController,
          decoration: InputDecoration(
            labelText: AppLocalizations.of(context)!.location,
            hintText: AppLocalizations.of(context)!.locationHint,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(AppLocalizations.of(context)!.cancel),
          ),
          TextButton(
            onPressed: () async {
              final newLocation = locationController.text.trim();
              if (newLocation.isNotEmpty) {
                try {
                  await DeviceService().updateDeviceLocation(
                    deviceId: deviceId,
                    location: newLocation,
                  );
                  if (context.mounted) {
                    Navigator.pop(context);
                    SnackbarService.showSnackbar(
                      context,
                      message:
                          AppLocalizations.of(context)!.deviceLocationUpdated,
                    );
                  }
                } catch (e) {
                  if (context.mounted) {
                    SnackbarService.showSnackbar(
                      context,
                      message: AppLocalizations.of(context)!
                          .errorUpdatingSettings(e.toString()),
                      isError: true,
                    );
                  }
                }
              }
            },
            child: Text(
              AppLocalizations.of(context)!.save,
              style: TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _showWaterPortionEditDialog(
    BuildContext context,
    String deviceId,
    Map<String, dynamic> currentSettings,
  ) async {
    final TextEditingController portionController = TextEditingController(
      text: (currentSettings['portionSize'] != null &&
              currentSettings['portionSize'] >= 1 &&
              currentSettings['portionSize'] <= 600)
          ? currentSettings['portionSize'].toString()
          : '5',
    );
    double sliderValue =
        int.tryParse(portionController.text)?.toDouble() ?? 5.0;

    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Theme.of(context).cardColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: Column(
          children: [
            Icon(
              Icons.water_drop,
              size: 40,
              color: Colors.blue,
            ),
            const SizedBox(height: 10),
            Text(
              'Su Porsiyon Miktarı',
              style: TextStyle(
                color: Theme.of(context).textTheme.bodyLarge?.color,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        content: StatefulBuilder(
          builder: (context, setState) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '${sliderValue.toInt()} saniye',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
                const SizedBox(height: 20),
                SliderTheme(
                  data: SliderThemeData(
                    activeTrackColor: Colors.blue,
                    thumbColor: Colors.blue,
                    overlayColor: Colors.blue.withOpacity(0.2),
                    valueIndicatorColor: Colors.blue,
                    valueIndicatorTextStyle:
                        const TextStyle(color: Colors.white),
                  ),
                  child: Slider(
                    value: sliderValue,
                    min: 1,
                    max: 600,
                    divisions: 599,
                    label: '${sliderValue.toInt()} saniye',
                    onChanged: (value) {
                      setState(() {
                        sliderValue = value;
                        portionController.text = value.toInt().toString();
                      });
                    },
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: portionController,
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Theme.of(context).textTheme.bodyLarge?.color,
                          fontSize: 18,
                        ),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor:
                              Theme.of(context).brightness == Brightness.dark
                                  ? Colors.grey[800]
                                  : Colors.grey[100],
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide.none,
                          ),
                          suffixText: 'saniye',
                          hintText: 'Saniye',
                        ),
                        onChanged: (value) {
                          final newValue = int.tryParse(value);
                          if (newValue != null &&
                              newValue >= 1 &&
                              newValue <= 600) {
                            setState(() {
                              sliderValue = newValue.toDouble();
                            });
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              AppLocalizations.of(context)!.cancel,
              style: TextStyle(
                color: Theme.of(context).textTheme.bodyMedium?.color,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              final newPortion = int.tryParse(portionController.text) ?? 5;
              if (newPortion >= 1 && newPortion <= 600) {
                try {
                  await DeviceService().updateWaterBowlSettings(
                    deviceId: deviceId,
                    settings: {
                      ...currentSettings,
                      'portionSize': newPortion,
                    },
                  );
                  if (context.mounted) {
                    Navigator.pop(context);
                    SnackbarService.showSnackbar(
                      context,
                      message: AppLocalizations.of(context)!.portionSizeUpdated,
                    );
                  }
                } catch (e) {
                  if (context.mounted) {
                    SnackbarService.showSnackbar(
                      context,
                      message: AppLocalizations.of(context)!
                          .errorUpdatingSettings(e.toString()),
                      isError: true,
                    );
                  }
                }
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Text(
              AppLocalizations.of(context)!.save,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final deviceData = device.data() as Map<String, dynamic>;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor ??
            Theme.of(context).scaffoldBackgroundColor,
        title: Text(
          deviceData['deviceName'],
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.delete_outline,
              color: Theme.of(context).colorScheme.error,
            ),
            tooltip: AppLocalizations.of(context)!.delete,
            onPressed: () => _deleteDevice(context),
            style: IconButton.styleFrom(
              backgroundColor:
                  Theme.of(context).colorScheme.errorContainer.withOpacity(0.1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.all(8),
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            if (deviceData['status'] == 'online')
              Expanded(
                child: SingleChildScrollView(
                  child: deviceData['deviceType'] == 'food_bowl'
                      ? _buildFoodBowlContent(deviceData, context)
                      : _buildWaterBowlContent(deviceData, context),
                ),
              )
            else
              Expanded(
                child: Center(
                  child: Text(
                    'Cihaz çevrimdışı',
                    style: TextStyle(
                      fontSize: 18,
                      color: Theme.of(context).textTheme.bodyMedium?.color,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildDeviceCard(BuildContext context, Widget child) {
    return Card(
      elevation: 2,
      color: Theme.of(context).cardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
        side: BorderSide(
          color: Theme.of(context).dividerColor.withOpacity(0.1),
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: child,
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: Theme.of(context).textTheme.bodyLarge?.color,
      ),
    );
  }

  Widget _buildProgressIndicator(
    BuildContext context,
    double value,
    String label,
    bool isEmpty,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LinearProgressIndicator(
          value: value,
          backgroundColor: Theme.of(context).dividerColor.withOpacity(0.1),
          valueColor: AlwaysStoppedAnimation<Color>(
            isEmpty ? Colors.red : Colors.blue,
          ),
          minHeight: 10,
          borderRadius: BorderRadius.circular(5),
        ),
        const SizedBox(height: 5),
        Text(
          isEmpty ? AppLocalizations.of(context)!.noFoodLeft : label,
          style: TextStyle(
            color: isEmpty ? Colors.red : Colors.blue,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildDeviceStatusCard(
      BuildContext context, Map<String, dynamic> deviceData) {
    return Card(
      elevation: 2,
      color: Theme.of(context).cardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
        side: BorderSide(
          color: Theme.of(context).brightness == Brightness.dark
              ? const Color(0xFF232B3A)
              : Colors.grey.shade300,
          width: 1.2,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle(
                context, AppLocalizations.of(context)!.deviceStatus),
            const SizedBox(height: 16),
            // Pil Durumu
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.08),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Colors.blue.withOpacity(0.08),
                  width: 1,
                ),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? const Color(0xFF232B3A)
                          : Colors.blue.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      _getBatteryIcon(deviceData['batteryLevel']),
                      color: Colors.blue[700],
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.batteryStatus,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Theme.of(context).textTheme.bodyLarge?.color,
                          ),
                        ),
                        const SizedBox(height: 4),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: LinearProgressIndicator(
                            value: deviceData['batteryLevel'] / 100,
                            backgroundColor: Colors.grey[300],
                            valueColor: AlwaysStoppedAnimation<Color>(
                              _getBatteryColor(deviceData['batteryLevel']),
                            ),
                            minHeight: 6,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${deviceData['batteryLevel']}%',
                          style: TextStyle(
                            fontSize: 14,
                            color: _getBatteryColor(deviceData['batteryLevel']),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            // Konum
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.08),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Colors.blue.withOpacity(0.08),
                  width: 1,
                ),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? const Color(0xFF232B3A)
                          : Colors.blue.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(
                      Icons.location_on,
                      color: Colors.blue,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.location,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Theme.of(context).textTheme.bodyLarge?.color,
                          ),
                        ),
                        Text(
                          deviceData['generalSettings']['deviceLocation'] ??
                              AppLocalizations.of(context)!.home,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.edit, color: Colors.blue),
                    onPressed: () => _showLocationEditDialog(
                      context,
                      deviceData['deviceId'],
                      deviceData['generalSettings']['deviceLocation'] ??
                          AppLocalizations.of(context)!.home,
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

  // Pil durumuna göre renk belirleme fonksiyonu
  Color _getBatteryColor(int level) {
    if (level >= 60) return Colors.green;
    if (level >= 30) return Colors.orange;
    return Colors.red;
  }

  // Pil durumuna göre icon belirleme fonksiyonu
  IconData _getBatteryIcon(int level) {
    if (level >= 90) return Icons.battery_full;
    if (level >= 60) return Icons.battery_6_bar;
    if (level >= 30) return Icons.battery_3_bar;
    return Icons.battery_alert;
  }

  Widget _buildPortionSizeCard(BuildContext context,
      Map<String, dynamic> foodBowlSettings, String deviceId) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      color: Theme.of(context).cardColor,
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSectionTitle(
                        context, AppLocalizations.of(context)!.portionSize),
                    const SizedBox(height: 4),
                  ],
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: IconButton(
                    icon: Icon(Icons.edit_outlined, color: Colors.blue[700]),
                    onPressed: () => _showPortionEditDialog(
                      context,
                      deviceId,
                      foodBowlSettings,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.08),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? const Color(0xFF232B3A)
                          : Colors.blue.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      Icons.restaurant,
                      color: Colors.blue[700],
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${foodBowlSettings['portionSize']} saniye',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Colors.blue[200]
                              : Colors.blue,
                        ),
                      ),
                      Text(
                        'Her besleme için',
                        style: TextStyle(
                          fontSize: 14,
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Colors.blue[100]
                              : Colors.blue.withOpacity(0.7),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWaterPortionSizeCard(BuildContext context,
      Map<String, dynamic> waterBowlSettings, String deviceId) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      color: Theme.of(context).cardColor,
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildSectionTitle(
                          context, AppLocalizations.of(context)!.portionSize),
                      const SizedBox(height: 4),
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: IconButton(
                    icon: Icon(Icons.edit_outlined, color: Colors.blue[700]),
                    onPressed: () => _showWaterPortionEditDialog(
                      context,
                      deviceId,
                      waterBowlSettings,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.08),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? const Color(0xFF232B3A)
                          : const Color(0xFFF3F8FE),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      Icons.water_drop,
                      color: Colors.blue[700],
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${waterBowlSettings['portionSize']} saniye',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Colors.blue[200]
                              : Colors.blue,
                        ),
                      ),
                      Text(
                        'Her besleme için',
                        style: TextStyle(
                          fontSize: 14,
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Colors.blue[100]
                              : Colors.blue.withOpacity(0.7),
                        ),
                      ),
                    ],
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

class CountdownTimer extends StatefulWidget {
  final int duration;
  final VoidCallback onFinished;

  const CountdownTimer({
    super.key,
    required this.duration,
    required this.onFinished,
  });

  @override
  State<CountdownTimer> createState() => _CountdownTimerState();
}

class _CountdownTimerState extends State<CountdownTimer> {
  late Timer _timer;
  late int _remainingSeconds;

  @override
  void initState() {
    super.initState();
    _remainingSeconds = widget.duration;
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) {
        _timer.cancel();
        return;
      }
      setState(() {
        if (_remainingSeconds > 0) {
          _remainingSeconds--;
        } else {
          _timer.cancel();
          widget.onFinished();
        }
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.blue.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.timer,
            size: 16,
            color: Colors.blue,
          ),
          const SizedBox(width: 4),
          Text(
            'Kalan süre: $_remainingSeconds saniye',
            style: const TextStyle(
              color: Colors.blue,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
