// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a tr locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'tr';

  static String m0(amount, maxAmount) => "${amount} / ${maxAmount} gr mama var";

  static String m1(amount) => "${amount} ml Su Ver";

  static String m2(error) => "Cihaz silinirken hata oluştu: ${error}";

  static String m3(error) => "Hata: ${error}";

  static String m4(error) => "Ayarlar güncellenirken hata oluştu: ${error}";

  static String m5(amount) => "${amount} gr Mama Ver";

  static String m6(amount) => "${amount} gr mama verildi";

  static String m7(amount) => "Öğün başına ${amount} gr";

  static String m8(amount) => "${amount} gr";

  static String m9(amount) => "${amount} ml";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "addDevice": MessageLookupByLibrary.simpleMessage("Cihaz Ekle"),
        "addFirstDevice":
            MessageLookupByLibrary.simpleMessage("İlk cihazınızı ekleyin"),
        "agreePersonalData": MessageLookupByLibrary.simpleMessage(
            "Kişisel verilerimin işlenmesine ilişkin"),
        "agreePersonalDataSuffix": MessageLookupByLibrary.simpleMessage(
            "\'nı okudum ve kabul ediyorum."),
        "alreadyHaveAccount":
            MessageLookupByLibrary.simpleMessage("Zaten hesabınız var mı?"),
        "backToLogin":
            MessageLookupByLibrary.simpleMessage("Giriş Ekranına Dön"),
        "batteryLevel": MessageLookupByLibrary.simpleMessage("Pil Seviyesi"),
        "batteryStatus": MessageLookupByLibrary.simpleMessage("Pil Durumu"),
        "cancel": MessageLookupByLibrary.simpleMessage("İptal"),
        "createAccount":
            MessageLookupByLibrary.simpleMessage("Hesabınızı oluşturun"),
        "currentFoodLevel": m0,
        "darkTheme": MessageLookupByLibrary.simpleMessage("Koyu Tema"),
        "delete": MessageLookupByLibrary.simpleMessage("Sil"),
        "deleteConfirmation": MessageLookupByLibrary.simpleMessage(
            "Bu cihazı silmek istediğinizden emin misiniz?"),
        "deviceAddedSuccess":
            MessageLookupByLibrary.simpleMessage("Cihaz başarıyla eklendi"),
        "deviceAlreadyExists": MessageLookupByLibrary.simpleMessage(
            "Bu tipte bir cihaz zaten eklenmiş"),
        "deviceIsDeleted":
            MessageLookupByLibrary.simpleMessage("Cihaz başarıyla silindi"),
        "deviceIsOffline":
            MessageLookupByLibrary.simpleMessage("Cihaz şu anda çevrimdışı"),
        "deviceLocation": MessageLookupByLibrary.simpleMessage("Cihaz Konumu"),
        "deviceLocationUpdated":
            MessageLookupByLibrary.simpleMessage("Cihaz konumu güncellendi"),
        "deviceStatus": MessageLookupByLibrary.simpleMessage("Cihaz Durumu"),
        "dispenseWater": MessageLookupByLibrary.simpleMessage("Su Boşalt"),
        "dispenseWaterNow": m1,
        "dontHaveAccount":
            MessageLookupByLibrary.simpleMessage("Hesabınız yok mu?"),
        "editLocation": MessageLookupByLibrary.simpleMessage("Konumu Düzenle"),
        "email": MessageLookupByLibrary.simpleMessage("E-posta"),
        "emailRequired":
            MessageLookupByLibrary.simpleMessage("E-posta adresi gerekli"),
        "errorDeletingDevice": m2,
        "errorOccurred": m3,
        "errorUpdatingSettings": m4,
        "feedNow": m5,
        "foodDispensed": m6,
        "foodLevel": MessageLookupByLibrary.simpleMessage("Mama Seviyesi"),
        "foodPortionSize":
            MessageLookupByLibrary.simpleMessage("Mama Porsiyon Miktarı"),
        "forgotPassword":
            MessageLookupByLibrary.simpleMessage("Şifremi Unuttum"),
        "fullName": MessageLookupByLibrary.simpleMessage("Ad Soyad"),
        "generalError": MessageLookupByLibrary.simpleMessage(
            "Bir hata oluştu. Lütfen tekrar deneyin."),
        "gramsPerMeal": m7,
        "home": MessageLookupByLibrary.simpleMessage("Ev"),
        "homePage": MessageLookupByLibrary.simpleMessage("Ana Sayfa"),
        "invalidEmail":
            MessageLookupByLibrary.simpleMessage("Geçersiz e-posta adresi"),
        "lightTheme": MessageLookupByLibrary.simpleMessage("Açık Tema"),
        "location": MessageLookupByLibrary.simpleMessage("Konum"),
        "locationHint": MessageLookupByLibrary.simpleMessage(
            "Örn: Salon, Mutfak, Yatak Odası"),
        "locationPlaceholder": MessageLookupByLibrary.simpleMessage(
            "Örn: Salon, Mutfak, Yatak Odası"),
        "loginToAccount":
            MessageLookupByLibrary.simpleMessage("Hesabınıza giriş yapın"),
        "manualFeeding": MessageLookupByLibrary.simpleMessage("Manuel Besleme"),
        "manualWatering": MessageLookupByLibrary.simpleMessage("Manuel Sulama"),
        "mustAgreePersonalData": MessageLookupByLibrary.simpleMessage(
            "* Devam etmek için kişisel verilerin işlenmesini kabul etmelisiniz."),
        "nameMinLength": MessageLookupByLibrary.simpleMessage(
            "İsim en az 2 karakter olmalı"),
        "nameNoNumbers":
            MessageLookupByLibrary.simpleMessage("İsim rakam içeremez"),
        "nameRequired": MessageLookupByLibrary.simpleMessage("İsim gerekli"),
        "noDevicesFound":
            MessageLookupByLibrary.simpleMessage("Cihaz bulunamadı"),
        "noFoodLeft": MessageLookupByLibrary.simpleMessage("Mama kalmadı"),
        "notEnoughFood":
            MessageLookupByLibrary.simpleMessage("Yeterli mama yok!"),
        "offline": MessageLookupByLibrary.simpleMessage("Çevrimdışı"),
        "online": MessageLookupByLibrary.simpleMessage("Çevrimiçi"),
        "or": MessageLookupByLibrary.simpleMessage("veya"),
        "password": MessageLookupByLibrary.simpleMessage("Şifre"),
        "passwordMinLength": MessageLookupByLibrary.simpleMessage(
            "Şifre en az 6 karakter uzunluğunda olmalı"),
        "passwordRequired":
            MessageLookupByLibrary.simpleMessage("Lütfen şifrenizi girin"),
        "passwordRequirements_digit":
            MessageLookupByLibrary.simpleMessage("Rakam"),
        "passwordRequirements_minLength":
            MessageLookupByLibrary.simpleMessage("6+ karakter"),
        "passwordRequirements_specialChar":
            MessageLookupByLibrary.simpleMessage("Özel karakter"),
        "passwordRequirements_uppercase":
            MessageLookupByLibrary.simpleMessage("Büyük harf"),
        "passwordStrength_medium": MessageLookupByLibrary.simpleMessage("Orta"),
        "passwordStrength_strong":
            MessageLookupByLibrary.simpleMessage("Güçlü"),
        "passwordStrength_weak": MessageLookupByLibrary.simpleMessage("Zayıf"),
        "perMeal": MessageLookupByLibrary.simpleMessage("Her öğün için"),
        "perWatering": MessageLookupByLibrary.simpleMessage("Her sulama için"),
        "personalDataAgreement":
            MessageLookupByLibrary.simpleMessage("Gizlilik Politikası"),
        "portionAmount": m8,
        "portionSize": MessageLookupByLibrary.simpleMessage("Porsiyon Miktarı"),
        "portionSizeHint":
            MessageLookupByLibrary.simpleMessage("Porsiyon miktarı"),
        "portionSizeUpdated": MessageLookupByLibrary.simpleMessage(
            "Porsiyon miktarı güncellendi"),
        "resetPassword":
            MessageLookupByLibrary.simpleMessage("Şifremi Sıfırla"),
        "resetPasswordEmailSent": MessageLookupByLibrary.simpleMessage(
            "Şifre sıfırlama bağlantısı e-posta adresinize gönderildi"),
        "resetPasswordInstructions": MessageLookupByLibrary.simpleMessage(
            "Şifre sıfırlama bağlantısı almak için e-posta adresinize gönderilen bağlantıya tıklayın"),
        "save": MessageLookupByLibrary.simpleMessage("Kaydet"),
        "sendResetLink":
            MessageLookupByLibrary.simpleMessage("Sıfırlama Bağlantısı Gönder"),
        "signIn": MessageLookupByLibrary.simpleMessage("Giriş Yap"),
        "signInNow": MessageLookupByLibrary.simpleMessage("Giriş Yapın"),
        "signUp": MessageLookupByLibrary.simpleMessage("Kayıt Ol"),
        "signUpNow": MessageLookupByLibrary.simpleMessage("Şimdi Kaydolun"),
        "smartFoodBowl":
            MessageLookupByLibrary.simpleMessage("Akıllı Mama Kabı"),
        "smartFoodBowlDesc": MessageLookupByLibrary.simpleMessage(
            "Evcil hayvanınız için akıllı mama kabı"),
        "smartWaterBowl": MessageLookupByLibrary.simpleMessage("Akıllı Suluk"),
        "smartWaterBowlDesc": MessageLookupByLibrary.simpleMessage(
            "Evcil hayvanınız için akıllı suluk"),
        "startControlling": MessageLookupByLibrary.simpleMessage(
            "Akıllı cihazlarınızı kontrol edin"),
        "systemTheme": MessageLookupByLibrary.simpleMessage("Sistem Teması"),
        "userDisabled": MessageLookupByLibrary.simpleMessage(
            "Bu hesap devre dışı bırakılmış."),
        "userNotFound": MessageLookupByLibrary.simpleMessage(
            "Bu e-posta adresi ile kayıtlı kullanıcı bulunamadı."),
        "waterAmountHint": MessageLookupByLibrary.simpleMessage("Su miktarı"),
        "waterLevel": MessageLookupByLibrary.simpleMessage("Su Seviyesi"),
        "waterPortionAmount": m9,
        "waterPortionSize":
            MessageLookupByLibrary.simpleMessage("Su Porsiyon Miktarı"),
        "welcome": MessageLookupByLibrary.simpleMessage("Hoş Geldiniz"),
        "welcomeBack":
            MessageLookupByLibrary.simpleMessage("Tekrar Hoş Geldiniz"),
        "wrongPassword":
            MessageLookupByLibrary.simpleMessage("Hatalı şifre girdiniz.")
      };
}
