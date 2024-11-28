import 'package:flutter/material.dart';
import 'package:iot/services/device_service.dart';
import 'package:iot/screens/home_screen.dart';
import 'package:iot/services/snackbar_service.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddDeviceScreen extends StatelessWidget {
  const AddDeviceScreen({super.key});

  Future<void> _handleDeviceSelection(
    BuildContext context,
    String deviceType,
    String deviceName,
    String deviceId,
  ) async {
    if (!context.mounted) return;

    try {
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

      await DeviceService().addNewDevice(
        deviceType: deviceType,
        deviceName: deviceName,
        deviceId: deviceId,
        initialStatus: 'online',
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
      if (!context.mounted) return;

      SnackbarService.showSnackbar(
        context,
        message: AppLocalizations.of(context)!.errorOccurred(e.toString()),
        isError: true,
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
              ),
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
          border: Border.all(color: Colors.blue.withOpacity(0.3)),
          borderRadius: BorderRadius.circular(10),
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
                      color: Colors.grey[600],
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
