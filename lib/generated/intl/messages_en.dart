// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
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
  String get localeName => 'en';

  static String m0(amount, maxAmount) =>
      "${amount} / ${maxAmount} gr food available";

  static String m1(amount) => "Dispense ${amount} ml";

  static String m2(error) => "Error deleting device: ${error}";

  static String m3(error) => "Error: ${error}";

  static String m4(error) => "Error updating settings: ${error}";

  static String m5(amount) => "Feed ${amount} gr";

  static String m6(amount) => "${amount} gr food dispensed";

  static String m7(amount) => "${amount} gr per meal";

  static String m8(amount) => "${amount} gr";

  static String m9(amount) => "${amount} ml";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "addDevice": MessageLookupByLibrary.simpleMessage("Add Device"),
        "addFirstDevice":
            MessageLookupByLibrary.simpleMessage("Add your first device"),
        "agreePersonalData": MessageLookupByLibrary.simpleMessage(
            "I have read and agree to the"),
        "agreePersonalDataSuffix": MessageLookupByLibrary.simpleMessage("."),
        "alreadyHaveAccount":
            MessageLookupByLibrary.simpleMessage("Already have an account?"),
        "backToLogin": MessageLookupByLibrary.simpleMessage("Back to Login"),
        "batteryLevel": MessageLookupByLibrary.simpleMessage("Battery Level"),
        "batteryStatus": MessageLookupByLibrary.simpleMessage("Battery Status"),
        "cancel": MessageLookupByLibrary.simpleMessage("Cancel"),
        "createAccount":
            MessageLookupByLibrary.simpleMessage("Create your account"),
        "currentFoodLevel": m0,
        "darkTheme": MessageLookupByLibrary.simpleMessage("Dark Theme"),
        "delete": MessageLookupByLibrary.simpleMessage("Delete"),
        "deleteConfirmation": MessageLookupByLibrary.simpleMessage(
            "Are you sure you want to delete this device?"),
        "deviceAddedSuccess":
            MessageLookupByLibrary.simpleMessage("Device added successfully"),
        "deviceAlreadyExists": MessageLookupByLibrary.simpleMessage(
            "A device of this type already exists"),
        "deviceIsDeleted":
            MessageLookupByLibrary.simpleMessage("Device deleted successfully"),
        "deviceIsOffline":
            MessageLookupByLibrary.simpleMessage("Device is currently offline"),
        "deviceLocation":
            MessageLookupByLibrary.simpleMessage("Device Location"),
        "deviceLocationUpdated":
            MessageLookupByLibrary.simpleMessage("Device location updated"),
        "deviceStatus": MessageLookupByLibrary.simpleMessage("Device Status"),
        "dispenseWater": MessageLookupByLibrary.simpleMessage("Dispense Water"),
        "dispenseWaterNow": m1,
        "dontHaveAccount":
            MessageLookupByLibrary.simpleMessage("Don\'t have an account?"),
        "editLocation": MessageLookupByLibrary.simpleMessage("Edit Location"),
        "email": MessageLookupByLibrary.simpleMessage("Email"),
        "emailRequired":
            MessageLookupByLibrary.simpleMessage("Email is required"),
        "errorDeletingDevice": m2,
        "errorOccurred": m3,
        "errorUpdatingSettings": m4,
        "feedNow": m5,
        "foodDispensed": m6,
        "foodLevel": MessageLookupByLibrary.simpleMessage("Food Level"),
        "foodPortionSize":
            MessageLookupByLibrary.simpleMessage("Food Portion Size"),
        "forgotPassword":
            MessageLookupByLibrary.simpleMessage("Forgot Password"),
        "fullName": MessageLookupByLibrary.simpleMessage("Full Name"),
        "generalError": MessageLookupByLibrary.simpleMessage(
            "An error occurred. Please try again."),
        "gramsPerMeal": m7,
        "home": MessageLookupByLibrary.simpleMessage("Home"),
        "homePage": MessageLookupByLibrary.simpleMessage("Home"),
        "invalidEmail":
            MessageLookupByLibrary.simpleMessage("Invalid email address"),
        "lightTheme": MessageLookupByLibrary.simpleMessage("Light Theme"),
        "location": MessageLookupByLibrary.simpleMessage("Location"),
        "locationHint": MessageLookupByLibrary.simpleMessage(
            "Ex: Living Room, Kitchen, Bedroom"),
        "locationPlaceholder": MessageLookupByLibrary.simpleMessage(
            "Ex: Living Room, Kitchen, Bedroom"),
        "loginToAccount":
            MessageLookupByLibrary.simpleMessage("Login to your account"),
        "manualFeeding": MessageLookupByLibrary.simpleMessage("Manual Feeding"),
        "manualWatering":
            MessageLookupByLibrary.simpleMessage("Manual Watering"),
        "mustAgreePersonalData": MessageLookupByLibrary.simpleMessage(
            "* You must agree to the processing of personal data to continue."),
        "nameMinLength": MessageLookupByLibrary.simpleMessage(
            "Name must be at least 2 characters"),
        "nameNoNumbers":
            MessageLookupByLibrary.simpleMessage("Name cannot contain numbers"),
        "nameRequired":
            MessageLookupByLibrary.simpleMessage("Name is required"),
        "noDevicesFound":
            MessageLookupByLibrary.simpleMessage("No devices found"),
        "noFoodLeft": MessageLookupByLibrary.simpleMessage("No food left"),
        "notEnoughFood":
            MessageLookupByLibrary.simpleMessage("Not enough food!"),
        "offline": MessageLookupByLibrary.simpleMessage("Offline"),
        "online": MessageLookupByLibrary.simpleMessage("Online"),
        "or": MessageLookupByLibrary.simpleMessage("or"),
        "password": MessageLookupByLibrary.simpleMessage("Password"),
        "passwordMinLength": MessageLookupByLibrary.simpleMessage(
            "Password must be at least 6 characters long"),
        "passwordRequired":
            MessageLookupByLibrary.simpleMessage("Please enter your password"),
        "passwordRequirements_digit":
            MessageLookupByLibrary.simpleMessage("Number"),
        "passwordRequirements_minLength":
            MessageLookupByLibrary.simpleMessage("6+ characters"),
        "passwordRequirements_specialChar":
            MessageLookupByLibrary.simpleMessage("Special character"),
        "passwordRequirements_uppercase":
            MessageLookupByLibrary.simpleMessage("Uppercase letter"),
        "passwordStrength_medium":
            MessageLookupByLibrary.simpleMessage("Medium"),
        "passwordStrength_strong":
            MessageLookupByLibrary.simpleMessage("Strong"),
        "passwordStrength_weak": MessageLookupByLibrary.simpleMessage("Weak"),
        "perMeal": MessageLookupByLibrary.simpleMessage("Per meal"),
        "perWatering": MessageLookupByLibrary.simpleMessage("Per watering"),
        "personalDataAgreement":
            MessageLookupByLibrary.simpleMessage("Privacy Policy"),
        "portionAmount": m8,
        "portionSize": MessageLookupByLibrary.simpleMessage("Portion Size"),
        "portionSizeHint": MessageLookupByLibrary.simpleMessage("Portion size"),
        "portionSizeUpdated":
            MessageLookupByLibrary.simpleMessage("Portion size updated"),
        "resetPassword": MessageLookupByLibrary.simpleMessage("Reset Password"),
        "resetPasswordEmailSent": MessageLookupByLibrary.simpleMessage(
            "Password reset link has been sent to your email"),
        "resetPasswordInstructions": MessageLookupByLibrary.simpleMessage(
            "Enter your email address to receive a password reset link"),
        "save": MessageLookupByLibrary.simpleMessage("Save"),
        "sendResetLink":
            MessageLookupByLibrary.simpleMessage("Send Reset Link"),
        "signIn": MessageLookupByLibrary.simpleMessage("Sign In"),
        "signInNow": MessageLookupByLibrary.simpleMessage("Sign In Now"),
        "signUp": MessageLookupByLibrary.simpleMessage("Sign Up"),
        "signUpNow": MessageLookupByLibrary.simpleMessage("Sign Up Now"),
        "smartFoodBowl":
            MessageLookupByLibrary.simpleMessage("Smart Food Bowl"),
        "smartFoodBowlDesc": MessageLookupByLibrary.simpleMessage(
            "Smart food bowl for your pet"),
        "smartWaterBowl":
            MessageLookupByLibrary.simpleMessage("Smart Water Bowl"),
        "smartWaterBowlDesc": MessageLookupByLibrary.simpleMessage(
            "Smart water bowl for your pet"),
        "startControlling":
            MessageLookupByLibrary.simpleMessage("Control your smart devices"),
        "systemTheme": MessageLookupByLibrary.simpleMessage("System Theme"),
        "userDisabled": MessageLookupByLibrary.simpleMessage(
            "This account has been disabled."),
        "userNotFound": MessageLookupByLibrary.simpleMessage(
            "No user found with this email address."),
        "waterAmountHint": MessageLookupByLibrary.simpleMessage("Water amount"),
        "waterLevel": MessageLookupByLibrary.simpleMessage("Water Level"),
        "waterPortionAmount": m9,
        "waterPortionSize":
            MessageLookupByLibrary.simpleMessage("Water Portion Size"),
        "welcome": MessageLookupByLibrary.simpleMessage("Welcome"),
        "welcomeBack": MessageLookupByLibrary.simpleMessage("Welcome Back"),
        "wrongPassword": MessageLookupByLibrary.simpleMessage("Wrong password.")
      };
}
