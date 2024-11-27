import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:iot/screens/signin_screen.dart';
import 'package:iot/services/auth.dart';
import 'package:iot/widgets/custom_scaffold.dart';
import 'package:iot/screens/home_screen.dart';
import 'package:iot/utils/form_validators.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formSignupKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  String? errorMessage;

  bool agreePersonalData = false;

  bool _isPasswordVisible = false;

  bool _isLoading = false;

  double _passwordStrength = 0.0;

  bool _isPasswordEmpty = true;

  bool _showAgreementError = false;

  Future<void> signUp() async {
    setState(() {
      _showAgreementError = false;
    });

    if (!mounted || !_formSignupKey.currentState!.validate()) {
      return;
    }

    if (!agreePersonalData) {
      setState(() {
        _showAgreementError = true;
      });
      return;
    }

    setState(() {
      _isLoading = true;
      errorMessage = null;
    });

    try {
      await Auth().createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
        name: nameController.text,
      );

      if (!mounted) return;

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
        (route) => false,
      );
    } catch (e) {
      if (!mounted) return;

      setState(() {
        errorMessage = e.toString();
      });
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  bool _hasMinLength(String password) => password.length >= 6;
  bool _hasUppercase(String password) => password.contains(RegExp(r'[A-Z]'));
  bool _hasDigits(String password) => password.contains(RegExp(r'[0-9]'));
  bool _hasSpecialCharacters(String password) =>
      password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));

  Widget _buildRequirement(bool isMet, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isMet ? Icons.check_circle_outline : Icons.circle_outlined,
            size: 12,
            color: isMet ? Colors.green : Colors.grey[400],
          ),
          const SizedBox(width: 2),
          Flexible(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 10,
                color: isMet ? Colors.green : Colors.grey[600],
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _socialLoginButton({
    required Widget icon,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          border: Border.all(
            color: Theme.of(context).dividerColor,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: icon,
      ),
    );
  }

  String _getPasswordStrengthText(double strength) {
    if (strength <= 0.25) {
      return AppLocalizations.of(context)!.passwordStrength_weak;
    } else if (strength <= 0.75) {
      return AppLocalizations.of(context)!.passwordStrength_medium;
    } else {
      return AppLocalizations.of(context)!.passwordStrength_strong;
    }
  }

  String _getPasswordRequirement(String type) {
    final isEnglish = Localizations.localeOf(context).languageCode == 'en';

    switch (type) {
      case 'minLength':
        return isEnglish ? '6+ characters' : '6+ karakter';
      case 'uppercase':
        return isEnglish ? 'Uppercase letter' : 'Büyük harf';
      case 'digit':
        return isEnglish ? 'Number' : 'Rakam';
      case 'specialChar':
        return isEnglish ? 'Special character' : 'Özel karakter';
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      child: Column(
        children: [
          const Expanded(flex: 1, child: SizedBox(height: 10)),
          Expanded(
            flex: 7,
            child: Container(
              padding: const EdgeInsets.fromLTRB(25.0, 50.0, 25.0, 20.0),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(40.0),
                  topRight: Radius.circular(40.0),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 10,
                    offset: const Offset(0, -5),
                  ),
                ],
              ),
              child: SingleChildScrollView(
                child: Form(
                  key: _formSignupKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.welcome,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        AppLocalizations.of(context)!.createAccount,
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Theme.of(context).textTheme.bodyMedium?.color,
                        ),
                      ),
                      const SizedBox(height: 40.0),

                      if (errorMessage != null)
                        Container(
                          margin: const EdgeInsets.only(bottom: 20),
                          padding: const EdgeInsets.symmetric(
                            vertical: 8,
                            horizontal: 16,
                          ),
                          decoration: BoxDecoration(
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                    ? Colors.red.shade900.withOpacity(0.2)
                                    : Colors.red.shade50,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            errorMessage!,
                            style: TextStyle(
                              color: Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? Colors.red.shade200
                                  : Colors.red,
                            ),
                          ),
                        ),

                      TextFormField(
                        controller: nameController,
                        validator: (value) => FormValidators.validateName(
                            value, AppLocalizations.of(context)!),
                        decoration: InputDecoration(
                          hintText: AppLocalizations.of(context)!.fullName,
                          prefixIcon: const Icon(Icons.person_outline),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Theme.of(context).dividerColor,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              color: Colors.blue,
                              width: 2,
                            ),
                          ),
                          filled: true,
                          fillColor:
                              Theme.of(context).brightness == Brightness.dark
                                  ? Theme.of(context).colorScheme.surface
                                  : Colors.white,
                        ),
                      ),
                      const SizedBox(height: 20),

                      TextFormField(
                        controller: emailController,
                        validator: (value) => FormValidators.email(value),
                        decoration: InputDecoration(
                          hintText: AppLocalizations.of(context)!.email,
                          prefixIcon: const Icon(Icons.email_outlined),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Theme.of(context).dividerColor,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              color: Colors.blue,
                              width: 2,
                            ),
                          ),
                          filled: true,
                          fillColor:
                              Theme.of(context).brightness == Brightness.dark
                                  ? Theme.of(context).colorScheme.surface
                                  : Colors.white,
                        ),
                      ),
                      const SizedBox(height: 20),

                      TextFormField(
                        controller: passwordController,
                        obscureText: !_isPasswordVisible,
                        decoration: InputDecoration(
                          hintText: AppLocalizations.of(context)!.password,
                          prefixIcon: const Icon(Icons.lock_outline),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isPasswordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Theme.of(context)
                                  .iconTheme
                                  .color
                                  ?.withOpacity(0.7),
                            ),
                            onPressed: () {
                              setState(() {
                                _isPasswordVisible = !_isPasswordVisible;
                              });
                            },
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Theme.of(context).dividerColor,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              color: Colors.blue,
                              width: 2,
                            ),
                          ),
                          filled: true,
                          fillColor:
                              Theme.of(context).brightness == Brightness.dark
                                  ? Theme.of(context).colorScheme.surface
                                  : Colors.white,
                        ),
                        onChanged: (value) {
                          setState(() {
                            _isPasswordEmpty = value.isEmpty;

                            if (value.isEmpty) {
                              _passwordStrength = 0;
                            } else {
                              double strength = 0;

                              if (_hasMinLength(value)) strength += 0.25;
                              if (_hasUppercase(value)) strength += 0.25;
                              if (_hasDigits(value)) strength += 0.25;
                              if (_hasSpecialCharacters(value))
                                strength += 0.25;

                              _passwordStrength = strength;
                            }
                          });
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Lütfen şifre giriniz';
                          }
                          if (value.length < 6) {
                            return 'Şifre en az 6 karakter olmalıdır';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 8.0),
                      // Şifre gücü göstergesi
                      AnimatedOpacity(
                        opacity: _isPasswordEmpty ? 0.0 : 1.0,
                        duration: const Duration(milliseconds: 200),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          height: _isPasswordEmpty ? 0 : 90,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 4),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(4),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Container(
                                                height: 4,
                                                color: _passwordStrength >= 0.25
                                                    ? (_passwordStrength <= 0.5
                                                        ? Colors.red
                                                        : Colors.red)
                                                    : Theme.of(context)
                                                                .brightness ==
                                                            Brightness.dark
                                                        ? Colors.grey[800]
                                                        : Colors.grey[200],
                                              ),
                                            ),
                                            const SizedBox(width: 2),
                                            Expanded(
                                              child: Container(
                                                height: 4,
                                                color: _passwordStrength >= 0.5
                                                    ? (_passwordStrength <= 0.75
                                                        ? Colors.yellow[700]
                                                        : Colors.yellow[700])
                                                    : Theme.of(context)
                                                                .brightness ==
                                                            Brightness.dark
                                                        ? Colors.grey[800]
                                                        : Colors.grey[200],
                                              ),
                                            ),
                                            const SizedBox(width: 2),
                                            Expanded(
                                              child: Container(
                                                height: 4,
                                                color: _passwordStrength >= 0.75
                                                    ? Colors.green
                                                    : Theme.of(context)
                                                                .brightness ==
                                                            Brightness.dark
                                                        ? Colors.grey[800]
                                                        : Colors.grey[200],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      _getPasswordStrengthText(
                                          _passwordStrength),
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: _passwordStrength <= 0.25
                                            ? Colors.red
                                            : _passwordStrength <= 0.75
                                                ? Colors.yellow[700]
                                                : Colors.green,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 12),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 4),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: _buildRequirement(
                                        _hasMinLength(passwordController.text),
                                        _getPasswordRequirement('minLength'),
                                      ),
                                    ),
                                    const SizedBox(width: 2),
                                    Expanded(
                                      flex: 1,
                                      child: _buildRequirement(
                                        _hasUppercase(passwordController.text),
                                        _getPasswordRequirement('uppercase'),
                                      ),
                                    ),
                                    const SizedBox(width: 2),
                                    Expanded(
                                      flex: 1,
                                      child: _buildRequirement(
                                        _hasDigits(passwordController.text),
                                        _getPasswordRequirement('digit'),
                                      ),
                                    ),
                                    const SizedBox(width: 2),
                                    Expanded(
                                      flex: 1,
                                      child: _buildRequirement(
                                        _hasSpecialCharacters(
                                            passwordController.text),
                                        _getPasswordRequirement('specialChar'),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 25.0),
                      // Kişisel veriler bölümü
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Colors.blue.withOpacity(0.1)
                              : Colors.blue.shade50,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                    ? Colors.blue.withOpacity(0.3)
                                    : Colors.blue.shade100,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Checkbox(
                                  value: agreePersonalData,
                                  onChanged: (value) {
                                    setState(() {
                                      agreePersonalData = value!;
                                    });
                                  },
                                  activeColor:
                                      Theme.of(context).colorScheme.primary,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                ),
                                Expanded(
                                  child: RichText(
                                    text: TextSpan(
                                      style: TextStyle(
                                        color: Theme.of(context).brightness ==
                                                Brightness.dark
                                            ? Colors.white.withOpacity(0.9)
                                            : Colors.black87,
                                        fontSize: 15,
                                      ),
                                      children: [
                                        TextSpan(
                                          text:
                                              '${AppLocalizations.of(context)!.agreePersonalData} ',
                                        ),
                                        TextSpan(
                                          text: AppLocalizations.of(context)!
                                              .personalDataAgreement,
                                          style: const TextStyle(
                                            color: Colors.blue,
                                            fontWeight: FontWeight.bold,
                                            decoration:
                                                TextDecoration.underline,
                                          ),
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () {
                                              // KVKK dialog'u göster
                                            },
                                        ),
                                        TextSpan(
                                          text: AppLocalizations.of(context)!
                                              .agreePersonalDataSuffix,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            if (_showAgreementError ||
                                (!agreePersonalData &&
                                    errorMessage != null)) ...[
                              const SizedBox(height: 8),
                              Text(
                                AppLocalizations.of(context)!
                                    .mustAgreePersonalData,
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.error,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                      const SizedBox(height: 30),

                      // Kayıt ol butonu
                      SizedBox(
                        width: double.infinity,
                        height: 55,
                        child: ElevatedButton(
                          onPressed: _isLoading ? null : signUp,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            elevation: 2,
                          ),
                          child: _isLoading
                              ? const CircularProgressIndicator(
                                  color: Colors.white)
                              : Text(
                                  AppLocalizations.of(context)!.signUp,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                        ),
                      ),
                      const SizedBox(height: 30),

                      // Ayraç
                      Row(
                        children: [
                          Expanded(
                            child: Divider(
                              color: Colors.grey[300],
                              thickness: 1,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Text(
                              AppLocalizations.of(context)!.or,
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 16,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Divider(
                              color: Colors.grey[300],
                              thickness: 1,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),

                      // Sosyal medya butonları
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _socialLoginButton(
                            icon: Brand(Brands.twitterx_2),
                            onTap: () {
                              // Google ile kayıt
                            },
                          ),
                          _socialLoginButton(
                            icon: Brand(Brands.apple_logo),
                            onTap: () {
                              // Apple ile kayıt
                            },
                          ),
                          _socialLoginButton(
                            icon: Brand(Brands.google),
                            onTap: () {
                              // Twitter ile kayıt
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),

                      // Giriş yap yönlendirmesi
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "${AppLocalizations.of(context)!.alreadyHaveAccount} ",
                            style: TextStyle(
                              color:
                                  Theme.of(context).textTheme.bodyMedium?.color,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const SignInScreen(),
                                ),
                              );
                            },
                            child: Text(
                              AppLocalizations.of(context)!.signInNow,
                              style: const TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
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
        ],
      ),
    );
  }
}
