import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:iot/services/device_service.dart';
import 'package:iot/screens/device_detail_screen.dart';
import 'package:iot/screens/add_device_screen.dart';
import 'package:iot/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:iot/providers/theme_provider.dart';
import 'package:iot/services/snackbar_service.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeScreen extends StatefulWidget {
  final bool showDeleteMessage;
  final String? deletedDeviceMessage;

  const HomeScreen({
    super.key,
    this.showDeleteMessage = false,
    this.deletedDeviceMessage,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Stream<QuerySnapshot> _devicesStream;

  @override
  void initState() {
    super.initState();
    _devicesStream = DeviceService().getUserDevices();

    // Cihaz silme mesajını göster
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.showDeleteMessage && widget.deletedDeviceMessage != null) {
        SnackbarService.showSnackbar(
          context,
          message: widget.deletedDeviceMessage!,
        );
      }
    });
  }

  @override
  void dispose() {
    // Stream'i temizle
    _devicesStream = const Stream.empty();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).cardColor,
        title: Text(
          AppLocalizations.of(context)!.homePage,
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
        actions: [
          StatefulBuilder(
            builder: (context, setState) => PopupMenuButton(
              icon: const Icon(
                Icons.settings,
                color: Colors.blue,
              ),
              color: Theme.of(context).cardColor,
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white24
                      : Colors.grey.shade200,
                  width: 1,
                ),
              ),
              itemBuilder: (context) => [
                PopupMenuItem(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Consumer<ThemeProvider>(
                      builder: (context, themeProvider, child) => Column(
                        children: [
                          ListTile(
                            leading: const Icon(Icons.brightness_auto,
                                color: Colors.blue),
                            title: Text(
                              AppLocalizations.of(context)!.systemTheme,
                              style: TextStyle(
                                color: Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? Colors.white
                                    : Colors.black87,
                              ),
                            ),
                            trailing: Theme(
                              data: ThemeData(
                                unselectedWidgetColor: Colors.grey.shade400,
                                radioTheme: RadioThemeData(
                                  fillColor:
                                      WidgetStateProperty.resolveWith<Color>(
                                    (Set<WidgetState> states) {
                                      if (states
                                          .contains(WidgetState.selected)) {
                                        return Colors.blue;
                                      }
                                      return Colors.grey.shade400;
                                    },
                                  ),
                                ),
                              ),
                              child: Radio<ThemeMode>(
                                value: ThemeMode.system,
                                groupValue: themeProvider.themeMode,
                                onChanged: (ThemeMode? value) {
                                  if (value != null) {
                                    Provider.of<ThemeProvider>(context,
                                            listen: false)
                                        .setThemeMode(value);
                                  }
                                },
                              ),
                            ),
                          ),
                          ListTile(
                            leading: const Icon(Icons.light_mode,
                                color: Colors.blue),
                            title: Text(
                              AppLocalizations.of(context)!.lightTheme,
                              style: TextStyle(
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.color,
                              ),
                            ),
                            trailing: Theme(
                              data: ThemeData(
                                unselectedWidgetColor: Colors.grey.shade400,
                                radioTheme: RadioThemeData(
                                  fillColor:
                                      WidgetStateProperty.resolveWith<Color>(
                                    (Set<WidgetState> states) {
                                      if (states
                                          .contains(WidgetState.selected)) {
                                        return Colors.blue;
                                      }
                                      return Colors.grey.shade400;
                                    },
                                  ),
                                ),
                              ),
                              child: Radio<ThemeMode>(
                                value: ThemeMode.light,
                                groupValue: themeProvider.themeMode,
                                onChanged: (ThemeMode? value) {
                                  if (value != null) {
                                    Provider.of<ThemeProvider>(context,
                                            listen: false)
                                        .setThemeMode(value);
                                  }
                                },
                              ),
                            ),
                          ),
                          ListTile(
                            leading:
                                const Icon(Icons.dark_mode, color: Colors.blue),
                            title: Text(
                              AppLocalizations.of(context)!.darkTheme,
                              style: TextStyle(
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.color,
                              ),
                            ),
                            trailing: Theme(
                              data: ThemeData(
                                unselectedWidgetColor: Colors.grey.shade400,
                                radioTheme: RadioThemeData(
                                  fillColor:
                                      WidgetStateProperty.resolveWith<Color>(
                                    (Set<WidgetState> states) {
                                      if (states
                                          .contains(WidgetState.selected)) {
                                        return Colors.blue;
                                      }
                                      return Colors.grey.shade400;
                                    },
                                  ),
                                ),
                              ),
                              child: Radio<ThemeMode>(
                                value: ThemeMode.dark,
                                groupValue: themeProvider.themeMode,
                                onChanged: (ThemeMode? value) {
                                  if (value != null) {
                                    Provider.of<ThemeProvider>(context,
                                            listen: false)
                                        .setThemeMode(value);
                                  }
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const PopupMenuItem(child: Divider()),
                PopupMenuItem(
                  child: ListTile(
                    leading: Icon(
                      Icons.logout,
                      color: Theme.of(context).colorScheme.error,
                    ),
                    title: Text(
                      'Çıkış Yap',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.error,
                      ),
                    ),
                    onTap: () async {
                      if (!context.mounted) return;

                      try {
                        await Auth().signOut();
                        if (!context.mounted) return;

                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          '/welcome',
                          (route) => false,
                        );
                      } catch (e) {
                        if (!context.mounted) return;

                        SnackbarService.showSnackbar(
                          context,
                          message: AppLocalizations.of(context)!
                              .errorWhileSigningOut(e.toString()),
                          isError: true,
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Hoş geldiniz kartı
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Colors.blue,
                            Colors.blue.shade700,
                          ],
                        ),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.blue.withOpacity(0.3),
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.person,
                              size: 35,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(width: 15),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                AppLocalizations.of(context)!.welcome,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                Auth().currentUser?.email ?? '',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),

                    // Cihazlar Listesi
                    StreamBuilder<QuerySnapshot>(
                      stream: _devicesStream,
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return const Text('Bir hata oluştu');
                        }

                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }

                        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                          return Center(
                            child: Text(
                                AppLocalizations.of(context)!.noDevicesFound),
                          );
                        }

                        return GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 15,
                            mainAxisSpacing: 15,
                          ),
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            final device = snapshot.data!.docs[index];
                            return _buildDeviceCard(device);
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            // Yeni cihaz ekleme butonu
            Padding(
              padding: const EdgeInsets.all(20),
              child: SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AddDeviceScreen(),
                      ),
                    );
                  },
                  icon: const Icon(Icons.add, color: Colors.white),
                  label: Text(
                    AppLocalizations.of(context)!.addDevice,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 2,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDeviceCard(DocumentSnapshot device) {
    final deviceData = device.data() as Map<String, dynamic>;
    final deviceName = deviceData['deviceName'] as String;

    IconData getDeviceIcon() {
      switch (deviceData['deviceType']) {
        case 'food_bowl':
          return Icons.pets;
        case 'water_bowl':
          return Icons.water_drop;
        default:
          return Icons.device_unknown;
      }
    }

    String getDeviceName() {
      switch (deviceData['deviceType']) {
        case 'food_bowl':
          return AppLocalizations.of(context)!.smartFoodBowl;
        case 'water_bowl':
          return AppLocalizations.of(context)!.smartWaterBowl;
        default:
          return deviceName;
      }
    }

    return StreamBuilder<DocumentSnapshot>(
      stream: DeviceService().getDeviceStream(deviceData['deviceId']),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final updatedDeviceData =
            snapshot.data?.data() as Map<String, dynamic>?;
        if (updatedDeviceData == null) {
          return const Center(child: Text('Cihaz verisi bulunamadı'));
        }

        return Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          elevation: 2,
          color: Theme.of(context).cardColor,
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DeviceDetailScreen(device: device),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    getDeviceIcon(),
                    size: 40,
                    color: Colors.blue,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    getDeviceName(),
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).textTheme.bodyLarge?.color,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Expanded(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.circle,
                          size: 8,
                          color: updatedDeviceData['status'] == 'online'
                              ? Colors.green
                              : Colors.red,
                        ),
                        const SizedBox(width: 4),
                        Flexible(
                          child: Text(
                            updatedDeviceData['status'] == 'online'
                                ? AppLocalizations.of(context)!.online
                                : AppLocalizations.of(context)!.offline,
                            style: TextStyle(
                              fontSize: 12,
                              color: updatedDeviceData['status'] == 'online'
                                  ? Colors.green
                                  : Colors.red,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Switch(
                          value: updatedDeviceData['status'] == 'online',
                          onChanged: (bool value) async {
                            try {
                              await DeviceService().updateDeviceStatus(
                                deviceData['deviceId'],
                                value ? 'online' : 'offline',
                              );
                            } catch (e) {
                              if (context.mounted) {
                                SnackbarService.showSnackbar(
                                  context,
                                  message: 'Hata: $e',
                                  isError: true,
                                );
                              }
                            }
                          },
                          activeColor: Colors.green,
                          inactiveThumbColor: Colors.red,
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
