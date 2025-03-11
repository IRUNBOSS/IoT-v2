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
import 'package:iot/providers/locale_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Stream<QuerySnapshot> _devicesStream;

  @override
  void initState() {
    super.initState();
    _devicesStream = DeviceService().getUserDevices();
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
              icon: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white.withOpacity(0.1)
                      : Colors.blue.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.settings,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : Colors.blue,
                  size: 24,
                ),
              ),
              offset: const Offset(0, 10),
              color: Theme.of(context).brightness == Brightness.dark
                  ? const Color(0xFF1E1E1E)
                  : Colors.white,
              elevation: 10,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: BorderSide(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white.withOpacity(0.1)
                      : Colors.grey.shade200,
                  width: 1,
                ),
              ),
              constraints: const BoxConstraints(
                minWidth: 300,
                maxWidth: 340,
              ),
              itemBuilder: (context) => [
                PopupMenuItem(
                  padding: EdgeInsets.zero,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? const Color(0xFF1E1E1E)
                          : Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Consumer<ThemeProvider>(
                      builder: (context, themeProvider, child) => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 16),
                            decoration: BoxDecoration(
                              color: Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? Colors.black.withOpacity(0.3)
                                  : Colors.blue.withOpacity(0.08),
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20),
                              ),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.palette_outlined,
                                  color: Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? Colors.white
                                      : Colors.blue,
                                  size: 20,
                                ),
                                const SizedBox(width: 12),
                                Text(
                                  'Tema / Theme',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? Colors.white
                                        : Colors.blue,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 8),
                          _buildThemeOption(
                            context,
                            themeProvider,
                            ThemeMode.system,
                            Icons.brightness_auto,
                            AppLocalizations.of(context)!.systemTheme,
                          ),
                          _buildThemeOption(
                            context,
                            themeProvider,
                            ThemeMode.light,
                            Icons.light_mode,
                            AppLocalizations.of(context)!.lightTheme,
                          ),
                          _buildThemeOption(
                            context,
                            themeProvider,
                            ThemeMode.dark,
                            Icons.dark_mode,
                            AppLocalizations.of(context)!.darkTheme,
                          ),
                          const SizedBox(height: 8),
                        ],
                      ),
                    ),
                  ),
                ),
                PopupMenuItem(
                  padding: EdgeInsets.zero,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    height: 1,
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.white.withOpacity(0.1)
                        : Colors.grey.shade200,
                  ),
                ),
                PopupMenuItem(
                  padding: EdgeInsets.zero,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? const Color(0xFF1E1E1E)
                          : Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Consumer<LocaleProvider>(
                      builder: (context, localeProvider, child) => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 16),
                            decoration: BoxDecoration(
                              color: Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? Colors.black.withOpacity(0.3)
                                  : Colors.blue.withOpacity(0.08),
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20),
                              ),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.language_outlined,
                                  color: Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? Colors.white
                                      : Colors.blue,
                                  size: 20,
                                ),
                                const SizedBox(width: 12),
                                Text(
                                  'Dil / Language',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? Colors.white
                                        : Colors.blue,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 8),
                          _buildLanguageOption(
                            context,
                            localeProvider,
                            const Locale('tr'),
                            'Türkçe',
                          ),
                          _buildLanguageOption(
                            context,
                            localeProvider,
                            const Locale('en'),
                            'English',
                          ),
                          const SizedBox(height: 8),
                        ],
                      ),
                    ),
                  ),
                ),
                PopupMenuItem(
                  padding: EdgeInsets.zero,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    height: 1,
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.white.withOpacity(0.1)
                        : Colors.grey.shade200,
                  ),
                ),
                PopupMenuItem(
                  padding: EdgeInsets.zero,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? const Color(0xFF1E1E1E)
                          : Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 8),
                      leading: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Theme.of(context)
                                  .colorScheme
                                  .error
                                  .withOpacity(0.1)
                              : Theme.of(context)
                                  .colorScheme
                                  .error
                                  .withOpacity(0.08),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.logout_rounded,
                          color: Theme.of(context).colorScheme.error,
                          size: 22,
                        ),
                      ),
                      title: Text(
                        'Çıkış Yap',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.error,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      onTap: () async {
                        Navigator.pop(context);
                        try {
                          await Auth().signOut();
                          if (context.mounted) {
                            // Tüm sayfaları temizle ve giriş ekranına yönlendir
                            Navigator.pushNamedAndRemoveUntil(
                              context,
                              '/welcome', // Ana giriş/kayıt ekranına yönlendir
                              (route) => false,
                            );
                          }
                        } catch (e) {
                          if (context.mounted) {
                            SnackbarService.showSnackbar(
                              context,
                              message: 'Çıkış yapılırken bir hata oluştu: $e',
                              isError: true,
                            );
                          }
                        }
                      },
                    ),
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
                            childAspectRatio: 0.85,
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
            borderRadius: BorderRadius.circular(15),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
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
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: updatedDeviceData['status'] == 'online'
                          ? Colors.green.withOpacity(
                              Theme.of(context).brightness == Brightness.dark
                                  ? 0.2
                                  : 0.1)
                          : Colors.red.withOpacity(
                              Theme.of(context).brightness == Brightness.dark
                                  ? 0.2
                                  : 0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 4, vertical: 2),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const SizedBox(width: 4),
                              Icon(
                                Icons.circle,
                                size: 8,
                                color: updatedDeviceData['status'] == 'online'
                                    ? Colors.green
                                    : Colors.red,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                updatedDeviceData['status'] == 'online'
                                    ? AppLocalizations.of(context)!.online
                                    : AppLocalizations.of(context)!.offline,
                                style: TextStyle(
                                  fontSize: 11,
                                  color: updatedDeviceData['status'] == 'online'
                                      ? Colors.green
                                      : Colors.red,
                                  fontWeight: FontWeight.w500,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                          Transform.scale(
                            scale: 0.6,
                            child: Switch(
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
                          ),
                        ],
                      ),
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

  Widget _buildThemeOption(
    BuildContext context,
    ThemeProvider themeProvider,
    ThemeMode mode,
    IconData icon,
    String title,
  ) {
    final isSelected = themeProvider.themeMode == mode;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return InkWell(
      onTap: () {
        Provider.of<ThemeProvider>(context, listen: false).setThemeMode(mode);
        Navigator.pop(context);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        margin: const EdgeInsets.symmetric(vertical: 2),
        decoration: BoxDecoration(
          color: isSelected
              ? (isDark
                  ? Colors.white.withOpacity(0.05)
                  : Colors.blue.withOpacity(0.08))
              : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: isSelected
                    ? (isDark
                        ? Colors.white.withOpacity(0.1)
                        : Colors.blue.withOpacity(0.15))
                    : isDark
                        ? Colors.white.withOpacity(0.05)
                        : Colors.grey.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: isSelected
                    ? (isDark ? Colors.white : Colors.blue.shade700)
                    : isDark
                        ? Colors.white.withOpacity(0.7)
                        : Colors.grey.shade700,
                size: 18,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  color: isSelected
                      ? (isDark ? Colors.white : Colors.blue.shade700)
                      : isDark
                          ? Colors.white.withOpacity(0.7)
                          : Colors.grey.shade800,
                ),
              ),
            ),
            if (isSelected)
              Icon(
                Icons.check_circle,
                color: isDark ? Colors.white : Colors.blue.shade700,
                size: 20,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildLanguageOption(
    BuildContext context,
    LocaleProvider localeProvider,
    Locale locale,
    String title,
  ) {
    final isSelected =
        localeProvider.locale.languageCode == locale.languageCode;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return InkWell(
      onTap: () {
        Provider.of<LocaleProvider>(context, listen: false).setLocale(locale);
        Navigator.pop(context);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        margin: const EdgeInsets.symmetric(vertical: 2),
        decoration: BoxDecoration(
          color: isSelected
              ? (isDark
                  ? Colors.white.withOpacity(0.05)
                  : Colors.blue.withOpacity(0.08))
              : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: isSelected
                    ? (isDark
                        ? Colors.white.withOpacity(0.1)
                        : Colors.blue.withOpacity(0.15))
                    : isDark
                        ? Colors.white.withOpacity(0.05)
                        : Colors.grey.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.language,
                color: isSelected
                    ? (isDark ? Colors.white : Colors.blue.shade700)
                    : isDark
                        ? Colors.white.withOpacity(0.7)
                        : Colors.grey.shade700,
                size: 18,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  color: isSelected
                      ? (isDark ? Colors.white : Colors.blue.shade700)
                      : isDark
                          ? Colors.white.withOpacity(0.7)
                          : Colors.grey.shade800,
                ),
              ),
            ),
            if (isSelected)
              Icon(
                Icons.check_circle,
                color: isDark ? Colors.white : Colors.blue.shade700,
                size: 20,
              ),
          ],
        ),
      ),
    );
  }
}
