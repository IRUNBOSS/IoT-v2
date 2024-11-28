import 'package:flutter/material.dart';
import 'package:iot/screens/signin_screen.dart';
import 'package:iot/screens/signup_screen.dart';
import 'package:iot/widgets/custom_scaffold.dart';
import 'package:iot/widgets/welcome_button.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:iot/providers/locale_provider.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () {
                    final provider =
                        Provider.of<LocaleProvider>(context, listen: false);
                    provider.setLocale(const Locale('tr'));
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Provider.of<LocaleProvider>(context)
                                    .locale
                                    .languageCode ==
                                'tr'
                            ? Colors.blue
                            : Colors.transparent,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Image.asset('assets/flags/tr.png', width: 24),
                        const SizedBox(width: 8),
                        const Text(
                          'TR',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                InkWell(
                  onTap: () {
                    Provider.of<LocaleProvider>(context, listen: false)
                        .setLocale(const Locale('en'));
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Provider.of<LocaleProvider>(context)
                                    .locale
                                    .languageCode ==
                                'en'
                            ? Colors.blue
                            : Colors.transparent,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Image.asset('assets/flags/en.png', width: 24),
                        const SizedBox(width: 8),
                        const Text(
                          'EN',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 16),
              ],
            ),
          ),
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.smart_toy,
                    size: 80,
                    color: Colors.white,
                  ),
                  const SizedBox(height: 30),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 25, vertical: 15),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Colors.blue.shade400.withOpacity(0.3),
                          Colors.blue.shade800.withOpacity(0.3),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 5,
                          offset: Offset(2, 2),
                        ),
                      ],
                    ),
                    child: Text(
                      AppLocalizations.of(context)!.welcome,
                      style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    AppLocalizations.of(context)!.startControlling,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.white.withOpacity(0.95),
                      letterSpacing: 0.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 50),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        WelcomeButton(
                          buttonText: AppLocalizations.of(context)!.signIn,
                          onTap: const SignInScreen(),
                          color: Colors.white,
                          textColor: Colors.blue,
                          isLeftButton: true,
                        ),
                        WelcomeButton(
                          buttonText: AppLocalizations.of(context)!.signUp,
                          onTap: const SignUpScreen(),
                          color: Colors.blue,
                          textColor: Colors.white,
                          isLeftButton: false,
                        ),
                      ],
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

extension on AppLocalizations {}
