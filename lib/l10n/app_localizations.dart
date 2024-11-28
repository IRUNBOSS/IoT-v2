import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
export 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  static Future<AppLocalizations> load(Locale locale) async {
    return AppLocalizations(locale);
  }

  String get welcome {
    switch (locale.languageCode) {
      case 'tr':
        return 'Hoş Geldiniz';
      default:
        return 'Welcome';
    }
  }

  String get startControlling {
    switch (locale.languageCode) {
      case 'tr':
        return 'Akıllı cihazlarınızı kontrol edin';
      default:
        return 'Control your smart devices';
    }
  }

  PasswordRequirements get passwordRequirements {
    return PasswordRequirements(
      minLength: _getLocalizedValue('passwordRequirements_minLength'),
      uppercase: _getLocalizedValue('passwordRequirements_uppercase'),
      digit: _getLocalizedValue('passwordRequirements_digit'),
      specialChar: _getLocalizedValue('passwordRequirements_specialChar'),
    );
  }

  String _getLocalizedValue(String key) {
    switch (locale.languageCode) {
      case 'tr':
        return _getTurkishValue(key);
      default:
        return _getEnglishValue(key);
    }
  }

  String _getTurkishValue(String key) {
    final values = {
      'passwordRequirements_minLength': '6+ karakter',
      'passwordRequirements_uppercase': 'Büyük harf',
      'passwordRequirements_digit': 'Rakam',
      'passwordRequirements_specialChar': 'Özel karakter',
    };
    return values[key] ?? key;
  }

  String _getEnglishValue(String key) {
    final values = {
      'passwordRequirements_minLength': '6+ characters',
      'passwordRequirements_uppercase': 'Uppercase letter',
      'passwordRequirements_digit': 'Number',
      'passwordRequirements_specialChar': 'Special character',
    };
    return values[key] ?? key;
  }

  String get specialChar {
    switch (locale.languageCode) {
      case 'tr':
        return 'Özel karakter';
      default:
        return 'Special character';
    }
  }

  String get welcomeBack {
    switch (locale.languageCode) {
      case 'tr':
        return 'Tekrar Hoş Geldiniz';
      default:
        return 'Welcome Back';
    }
  }

  String get loginToAccount {
    switch (locale.languageCode) {
      case 'tr':
        return 'Hesabınıza giriş yapın';
      default:
        return 'Login to your account';
    }
  }

  String get forgotPassword {
    switch (locale.languageCode) {
      case 'tr':
        return 'Şifremi Unuttum';
      default:
        return 'Forgot Password';
    }
  }

  String get dontHaveAccount {
    switch (locale.languageCode) {
      case 'tr':
        return 'Hesabınız yok mu?';
      default:
        return 'Don\'t have an account?';
    }
  }

  String get signUpNow {
    switch (locale.languageCode) {
      case 'tr':
        return 'Şimdi Kaydol';
      default:
        return 'Sign Up Now';
    }
  }

  String get userNotFound {
    switch (locale.languageCode) {
      case 'tr':
        return 'Bu e-posta adresi ile kayıtlı kullanıcı bulunamadı.';
      default:
        return 'No user found with this email address.';
    }
  }

  String get wrongPassword {
    switch (locale.languageCode) {
      case 'tr':
        return 'Hatalı şifre girdiniz.';
      default:
        return 'Wrong password.';
    }
  }

  String get invalidEmail {
    switch (locale.languageCode) {
      case 'tr':
        return 'Geçersiz e-posta adresi.';
      default:
        return 'Invalid email address.';
    }
  }

  String get userDisabled {
    switch (locale.languageCode) {
      case 'tr':
        return 'Bu hesap devre dışı bırakılmış.';
      default:
        return 'This account has been disabled.';
    }
  }

  String get generalError {
    switch (locale.languageCode) {
      case 'tr':
        return 'Bir hata oluştu. Lütfen tekrar deneyin.';
      default:
        return 'An error occurred. Please try again.';
    }
  }

  String get homePage {
    switch (locale.languageCode) {
      case 'tr':
        return 'Ana Sayfa';
      default:
        return 'Home Page';
    }
  }

  String get systemTheme {
    switch (locale.languageCode) {
      case 'tr':
        return 'Sistem Teması';
      default:
        return 'System Theme';
    }
  }

  String get lightTheme {
    switch (locale.languageCode) {
      case 'tr':
        return 'Açık Tema';
      default:
        return 'Light Theme';
    }
  }

  String get darkTheme {
    switch (locale.languageCode) {
      case 'tr':
        return 'Koyu Tema';
      default:
        return 'Dark Theme';
    }
  }

  String get online {
    switch (locale.languageCode) {
      case 'tr':
        return 'Çevrimiçi';
      default:
        return 'Online';
    }
  }

  String get offline {
    switch (locale.languageCode) {
      case 'tr':
        return 'Çevrimdışı';
      default:
        return 'Offline';
    }
  }

  String get noDevicesYet {
    switch (locale.languageCode) {
      case 'tr':
        return 'Henüz cihaz eklenmemiş';
      default:
        return 'No devices yet';
    }
  }

  String get addNewDevice {
    switch (locale.languageCode) {
      case 'tr':
        return 'Yeni Cihaz Ekle';
      default:
        return 'Add New Device';
    }
  }

  String get signOut {
    switch (locale.languageCode) {
      case 'tr':
        return 'Çıkış Yap';
      default:
        return 'Sign Out';
    }
  }

  String errorWhileSigningOut(String error) {
    switch (locale.languageCode) {
      case 'tr':
        return 'Çıkış yapılırken bir hata oluştu: $error';
      default:
        return 'Error while signing out: $error';
    }
  }

  String get deviceAddedSuccess {
    switch (locale.languageCode) {
      case 'tr':
        return 'Cihaz başarıyla eklendi';
      default:
        return 'Device added successfully';
    }
  }

  String get deviceAlreadyExists {
    switch (locale.languageCode) {
      case 'tr':
        return 'Bu tipte bir cihaz zaten eklenmiş';
      default:
        return 'A device of this type already exists';
    }
  }

  String get addDevice {
    switch (locale.languageCode) {
      case 'tr':
        return 'Cihaz Ekle';
      default:
        return 'Add Device';
    }
  }

  String get smartFoodBowl {
    switch (locale.languageCode) {
      case 'tr':
        return 'Akıllı Mama Kabı';
      default:
        return 'Smart Food Bowl';
    }
  }

  String get smartWaterBowl {
    switch (locale.languageCode) {
      case 'tr':
        return 'Akıllı Suluk';
      default:
        return 'Smart Water Bowl';
    }
  }

  String get smartFoodBowlDesc {
    switch (locale.languageCode) {
      case 'tr':
        return 'Evcil hayvanınız için akıllı mama kabı';
      default:
        return 'Smart food bowl for your pet';
    }
  }

  String get smartWaterBowlDesc {
    switch (locale.languageCode) {
      case 'tr':
        return 'Evcil hayvanınız için akıllı suluk';
      default:
        return 'Smart water bowl for your pet';
    }
  }

  String get errorOccurred {
    switch (locale.languageCode) {
      case 'tr':
        return 'Hata: {error}';
      default:
        return 'Error: {error}';
    }
  }

  String get deviceDeleted {
    switch (locale.languageCode) {
      case 'tr':
        return 'Cihaz başarıyla silindi';
      default:
        return 'Device successfully deleted';
    }
  }

  String get errorDeletingDevice {
    switch (locale.languageCode) {
      case 'tr':
        return 'Cihaz silinirken hata oluştu: {error}';
      default:
        return 'Error deleting device: {error}';
    }
  }

  String get notEnoughFood {
    switch (locale.languageCode) {
      case 'tr':
        return 'Yeterli mama yok';
      default:
        return 'Not enough food';
    }
  }

  String get foodDispensed {
    switch (locale.languageCode) {
      case 'tr':
        return '{amount} gr mama verildi';
      default:
        return '{amount} gr food dispensed';
    }
  }

  String get errorUpdatingSettings {
    switch (locale.languageCode) {
      case 'tr':
        return 'Ayarlar güncellenirken hata oluştu: {error}';
      default:
        return 'Error updating settings: {error}';
    }
  }

  String get portionSizeUpdated {
    switch (locale.languageCode) {
      case 'tr':
        return 'Porsiyon miktarı güncellendi';
      default:
        return 'Portion size updated';
    }
  }

  String get deviceLocationUpdated {
    switch (locale.languageCode) {
      case 'tr':
        return 'Cihaz konumu güncellendi';
      default:
        return 'Device location updated';
    }
  }

  String get deviceOffline {
    switch (locale.languageCode) {
      case 'tr':
        return 'Cihaz çevrimdışı';
      default:
        return 'Device is offline';
    }
  }

  String get gramsPerMeal {
    switch (locale.languageCode) {
      case 'tr':
        return 'Her öğünde {amount} gr';
      default:
        return '{amount} gr per meal';
    }
  }

  String get foodLevel {
    switch (locale.languageCode) {
      case 'tr':
        return 'Mama Seviyesi';
      default:
        return 'Food Level';
    }
  }

  String get portionSize {
    switch (locale.languageCode) {
      case 'tr':
        return 'Porsiyon Miktarı';
      default:
        return 'Portion Size';
    }
  }

  String get manualFeeding {
    switch (locale.languageCode) {
      case 'tr':
        return 'Manuel Besleme';
      default:
        return 'Manual Feeding';
    }
  }

  String feedNow(String amount) {
    switch (locale.languageCode) {
      case 'tr':
        return '$amount gr Mama Ver';
      default:
        return 'Feed $amount gr';
    }
  }

  String currentFoodLevel(String amount, String maxAmount) {
    switch (locale.languageCode) {
      case 'tr':
        return '$amount / $maxAmount gr mama var';
      default:
        return '$amount / $maxAmount gr food available';
    }
  }

  String get noFoodLeft {
    switch (locale.languageCode) {
      case 'tr':
        return 'Mama kalmadı';
      default:
        return 'No food left';
    }
  }

  String get resetPasswordTitle {
    switch (locale.languageCode) {
      case 'tr':
        return 'Şifremi Sıfırla';
      default:
        return 'Reset Password';
    }
  }

  String get resetPasswordDescription {
    switch (locale.languageCode) {
      case 'tr':
        return 'Şifrenizi sıfırlamak için e-posta adresinizi girin';
      default:
        return 'Enter your email to reset your password';
    }
  }

  String get resetPasswordEmailSent {
    switch (locale.languageCode) {
      case 'tr':
        return 'Şifre sıfırlama bağlantısı e-posta adresinize gönderildi';
      default:
        return 'Password reset link has been sent to your email';
    }
  }

  String get backToLogin {
    switch (locale.languageCode) {
      case 'tr':
        return 'Giriş Ekranına Dön';
      default:
        return 'Back to Login';
    }
  }

  String get nameRequired {
    switch (locale.languageCode) {
      case 'tr':
        return 'İsim gerekli';
      default:
        return 'Name is required';
    }
  }

  String get nameMinLength {
    switch (locale.languageCode) {
      case 'tr':
        return 'İsim en az 2 karakter olmalı';
      default:
        return 'Name must be at least 2 characters';
    }
  }

  String get nameNoNumbers {
    switch (locale.languageCode) {
      case 'tr':
        return 'İsim rakam içeremez';
      default:
        return 'Name cannot contain numbers';
    }
  }

  String dispenseWaterNow(String amount) {
    switch (locale.languageCode) {
      case 'tr':
        return '$amount ml Su Ver';
      default:
        return 'Dispense $amount ml';
    }
  }

  String get perMeal {
    switch (locale.languageCode) {
      case 'tr':
        return 'Her öğün için';
      default:
        return 'Per meal';
    }
  }

  String get perWatering {
    switch (locale.languageCode) {
      case 'tr':
        return 'Her sulama için';
      default:
        return 'Per watering';
    }
  }

  String get databaseError {
    switch (locale.languageCode) {
      case 'tr':
        return 'Veritabanı hatası: {error}';
      default:
        return 'Database error: {error}';
    }
  }

  String get deviceOperationError {
    switch (locale.languageCode) {
      case 'tr':
        return 'Cihaz işlemi sırasında hata: {error}';
      default:
        return 'Device operation error: {error}';
    }
  }

  String get networkError {
    switch (locale.languageCode) {
      case 'tr':
        return 'Ağ hatası: {error}';
      default:
        return 'Network error: {error}';
    }
  }

  String get unknownError {
    switch (locale.languageCode) {
      case 'tr':
        return 'Bilinmeyen bir hata oluştu: {error}';
      default:
        return 'An unknown error occurred: {error}';
    }
  }

  String get customDeviceProperties {
    switch (locale.languageCode) {
      case 'tr':
        return 'Cihaz Özellikleri';
      default:
        return 'Device Properties';
    }
  }

  String get addProperty {
    switch (locale.languageCode) {
      case 'tr':
        return 'Özellik Ekle';
      default:
        return 'Add Property';
    }
  }

  String get propertyName {
    switch (locale.languageCode) {
      case 'tr':
        return 'Özellik Adı';
      default:
        return 'Property Name';
    }
  }

  String get propertyType {
    switch (locale.languageCode) {
      case 'tr':
        return 'Özellik Tipi';
      default:
        return 'Property Type';
    }
  }

  String get propertyDefaultValue {
    switch (locale.languageCode) {
      case 'tr':
        return 'Varsayılan Değer';
      default:
        return 'Default Value';
    }
  }

  String get fieldRequired {
    switch (locale.languageCode) {
      case 'tr':
        return 'Bu alan zorunludur';
      default:
        return 'This field is required';
    }
  }

  String get invalidNumber {
    switch (locale.languageCode) {
      case 'tr':
        return 'Geçerli bir sayı giriniz';
      default:
        return 'Please enter a valid number';
    }
  }

  String get numberType {
    switch (locale.languageCode) {
      case 'tr':
        return 'Sayı';
      default:
        return 'Number';
    }
  }

  String get booleanType {
    switch (locale.languageCode) {
      case 'tr':
        return 'Açık/Kapalı';
      default:
        return 'On/Off';
    }
  }

  String get textType {
    switch (locale.languageCode) {
      case 'tr':
        return 'Metin';
      default:
        return 'Text';
    }
  }

  // Diğer çeviriler için de aynı yapıyı kullan
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'tr'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) async {
    return AppLocalizations(locale);
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

class PasswordRequirements {
  final String minLength;
  final String uppercase;
  final String digit;
  final String specialChar;

  PasswordRequirements({
    required this.minLength,
    required this.uppercase,
    required this.digit,
    required this.specialChar,
  });
}

extension AppLocalizationsX on BuildContext {
  AppLocalizations? get l10n => AppLocalizations.of(this);
}
