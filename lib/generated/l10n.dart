// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Welcome`
  String get welcome {
    return Intl.message(
      'Welcome',
      name: 'welcome',
      desc: '',
      args: [],
    );
  }

  /// `Control your smart devices`
  String get startControlling {
    return Intl.message(
      'Control your smart devices',
      name: 'startControlling',
      desc: '',
      args: [],
    );
  }

  /// `Create your account`
  String get createAccount {
    return Intl.message(
      'Create your account',
      name: 'createAccount',
      desc: '',
      args: [],
    );
  }

  /// `Sign In`
  String get signIn {
    return Intl.message(
      'Sign In',
      name: 'signIn',
      desc: '',
      args: [],
    );
  }

  /// `Sign Up`
  String get signUp {
    return Intl.message(
      'Sign Up',
      name: 'signUp',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get email {
    return Intl.message(
      'Email',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Full Name`
  String get fullName {
    return Intl.message(
      'Full Name',
      name: 'fullName',
      desc: '',
      args: [],
    );
  }

  /// `or`
  String get or {
    return Intl.message(
      'or',
      name: 'or',
      desc: '',
      args: [],
    );
  }

  /// `Already have an account?`
  String get alreadyHaveAccount {
    return Intl.message(
      'Already have an account?',
      name: 'alreadyHaveAccount',
      desc: '',
      args: [],
    );
  }

  /// `Sign In Now`
  String get signInNow {
    return Intl.message(
      'Sign In Now',
      name: 'signInNow',
      desc: '',
      args: [],
    );
  }

  /// `I have read and agree to the`
  String get agreePersonalData {
    return Intl.message(
      'I have read and agree to the',
      name: 'agreePersonalData',
      desc: '',
      args: [],
    );
  }

  /// `Privacy Policy`
  String get personalDataAgreement {
    return Intl.message(
      'Privacy Policy',
      name: 'personalDataAgreement',
      desc: '',
      args: [],
    );
  }

  /// `* You must agree to the processing of personal data to continue.`
  String get mustAgreePersonalData {
    return Intl.message(
      '* You must agree to the processing of personal data to continue.',
      name: 'mustAgreePersonalData',
      desc: '',
      args: [],
    );
  }

  /// `.`
  String get agreePersonalDataSuffix {
    return Intl.message(
      '.',
      name: 'agreePersonalDataSuffix',
      desc: '',
      args: [],
    );
  }

  /// `6+ characters`
  String get passwordRequirements_minLength {
    return Intl.message(
      '6+ characters',
      name: 'passwordRequirements_minLength',
      desc: '',
      args: [],
    );
  }

  /// `Uppercase letter`
  String get passwordRequirements_uppercase {
    return Intl.message(
      'Uppercase letter',
      name: 'passwordRequirements_uppercase',
      desc: '',
      args: [],
    );
  }

  /// `Number`
  String get passwordRequirements_digit {
    return Intl.message(
      'Number',
      name: 'passwordRequirements_digit',
      desc: '',
      args: [],
    );
  }

  /// `Special character`
  String get passwordRequirements_specialChar {
    return Intl.message(
      'Special character',
      name: 'passwordRequirements_specialChar',
      desc: '',
      args: [],
    );
  }

  /// `Weak`
  String get passwordStrength_weak {
    return Intl.message(
      'Weak',
      name: 'passwordStrength_weak',
      desc: '',
      args: [],
    );
  }

  /// `Medium`
  String get passwordStrength_medium {
    return Intl.message(
      'Medium',
      name: 'passwordStrength_medium',
      desc: '',
      args: [],
    );
  }

  /// `Strong`
  String get passwordStrength_strong {
    return Intl.message(
      'Strong',
      name: 'passwordStrength_strong',
      desc: '',
      args: [],
    );
  }

  /// `Welcome Back`
  String get welcomeBack {
    return Intl.message(
      'Welcome Back',
      name: 'welcomeBack',
      desc: '',
      args: [],
    );
  }

  /// `Login to your account`
  String get loginToAccount {
    return Intl.message(
      'Login to your account',
      name: 'loginToAccount',
      desc: '',
      args: [],
    );
  }

  /// `Forgot Password`
  String get forgotPassword {
    return Intl.message(
      'Forgot Password',
      name: 'forgotPassword',
      desc: '',
      args: [],
    );
  }

  /// `Don't have an account?`
  String get dontHaveAccount {
    return Intl.message(
      'Don\'t have an account?',
      name: 'dontHaveAccount',
      desc: '',
      args: [],
    );
  }

  /// `Sign Up Now`
  String get signUpNow {
    return Intl.message(
      'Sign Up Now',
      name: 'signUpNow',
      desc: '',
      args: [],
    );
  }

  /// `Email is required`
  String get emailRequired {
    return Intl.message(
      'Email is required',
      name: 'emailRequired',
      desc: '',
      args: [],
    );
  }

  /// `Invalid email address`
  String get invalidEmail {
    return Intl.message(
      'Invalid email address',
      name: 'invalidEmail',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your password`
  String get passwordRequired {
    return Intl.message(
      'Please enter your password',
      name: 'passwordRequired',
      desc: '',
      args: [],
    );
  }

  /// `Password must be at least 6 characters long`
  String get passwordMinLength {
    return Intl.message(
      'Password must be at least 6 characters long',
      name: 'passwordMinLength',
      desc: '',
      args: [],
    );
  }

  /// `No user found with this email address.`
  String get userNotFound {
    return Intl.message(
      'No user found with this email address.',
      name: 'userNotFound',
      desc: '',
      args: [],
    );
  }

  /// `Wrong password.`
  String get wrongPassword {
    return Intl.message(
      'Wrong password.',
      name: 'wrongPassword',
      desc: '',
      args: [],
    );
  }

  /// `This account has been disabled.`
  String get userDisabled {
    return Intl.message(
      'This account has been disabled.',
      name: 'userDisabled',
      desc: '',
      args: [],
    );
  }

  /// `An error occurred. Please try again.`
  String get generalError {
    return Intl.message(
      'An error occurred. Please try again.',
      name: 'generalError',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get homePage {
    return Intl.message(
      'Home',
      name: 'homePage',
      desc: '',
      args: [],
    );
  }

  /// `System Theme`
  String get systemTheme {
    return Intl.message(
      'System Theme',
      name: 'systemTheme',
      desc: '',
      args: [],
    );
  }

  /// `Light Theme`
  String get lightTheme {
    return Intl.message(
      'Light Theme',
      name: 'lightTheme',
      desc: '',
      args: [],
    );
  }

  /// `Dark Theme`
  String get darkTheme {
    return Intl.message(
      'Dark Theme',
      name: 'darkTheme',
      desc: '',
      args: [],
    );
  }

  /// `Online`
  String get online {
    return Intl.message(
      'Online',
      name: 'online',
      desc: '',
      args: [],
    );
  }

  /// `Offline`
  String get offline {
    return Intl.message(
      'Offline',
      name: 'offline',
      desc: '',
      args: [],
    );
  }

  /// `Add Device`
  String get addDevice {
    return Intl.message(
      'Add Device',
      name: 'addDevice',
      desc: '',
      args: [],
    );
  }

  /// `No devices found`
  String get noDevicesFound {
    return Intl.message(
      'No devices found',
      name: 'noDevicesFound',
      desc: '',
      args: [],
    );
  }

  /// `Add your first device`
  String get addFirstDevice {
    return Intl.message(
      'Add your first device',
      name: 'addFirstDevice',
      desc: '',
      args: [],
    );
  }

  /// `Smart Food Bowl`
  String get smartFoodBowl {
    return Intl.message(
      'Smart Food Bowl',
      name: 'smartFoodBowl',
      desc: '',
      args: [],
    );
  }

  /// `Smart Water Bowl`
  String get smartWaterBowl {
    return Intl.message(
      'Smart Water Bowl',
      name: 'smartWaterBowl',
      desc: '',
      args: [],
    );
  }

  /// `Smart food bowl for your pet`
  String get smartFoodBowlDesc {
    return Intl.message(
      'Smart food bowl for your pet',
      name: 'smartFoodBowlDesc',
      desc: '',
      args: [],
    );
  }

  /// `Smart water bowl for your pet`
  String get smartWaterBowlDesc {
    return Intl.message(
      'Smart water bowl for your pet',
      name: 'smartWaterBowlDesc',
      desc: '',
      args: [],
    );
  }

  /// `A device of this type already exists`
  String get deviceAlreadyExists {
    return Intl.message(
      'A device of this type already exists',
      name: 'deviceAlreadyExists',
      desc: '',
      args: [],
    );
  }

  /// `Device added successfully`
  String get deviceAddedSuccess {
    return Intl.message(
      'Device added successfully',
      name: 'deviceAddedSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Error: {error}`
  String errorOccurred(Object error) {
    return Intl.message(
      'Error: $error',
      name: 'errorOccurred',
      desc: '',
      args: [error],
    );
  }

  /// `Delete`
  String get delete {
    return Intl.message(
      'Delete',
      name: 'delete',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete this device?`
  String get deleteConfirmation {
    return Intl.message(
      'Are you sure you want to delete this device?',
      name: 'deleteConfirmation',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Food Level`
  String get foodLevel {
    return Intl.message(
      'Food Level',
      name: 'foodLevel',
      desc: '',
      args: [],
    );
  }

  /// `Portion Size`
  String get portionSize {
    return Intl.message(
      'Portion Size',
      name: 'portionSize',
      desc: '',
      args: [],
    );
  }

  /// `Manual Feeding`
  String get manualFeeding {
    return Intl.message(
      'Manual Feeding',
      name: 'manualFeeding',
      desc: '',
      args: [],
    );
  }

  /// `Water Level`
  String get waterLevel {
    return Intl.message(
      'Water Level',
      name: 'waterLevel',
      desc: '',
      args: [],
    );
  }

  /// `Manual Watering`
  String get manualWatering {
    return Intl.message(
      'Manual Watering',
      name: 'manualWatering',
      desc: '',
      args: [],
    );
  }

  /// `Location`
  String get location {
    return Intl.message(
      'Location',
      name: 'location',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get save {
    return Intl.message(
      'Save',
      name: 'save',
      desc: '',
      args: [],
    );
  }

  /// `Device deleted successfully`
  String get deviceIsDeleted {
    return Intl.message(
      'Device deleted successfully',
      name: 'deviceIsDeleted',
      desc: '',
      args: [],
    );
  }

  /// `Error deleting device: {error}`
  String errorDeletingDevice(Object error) {
    return Intl.message(
      'Error deleting device: $error',
      name: 'errorDeletingDevice',
      desc: '',
      args: [error],
    );
  }

  /// `Not enough food!`
  String get notEnoughFood {
    return Intl.message(
      'Not enough food!',
      name: 'notEnoughFood',
      desc: '',
      args: [],
    );
  }

  /// `{amount} gr food dispensed`
  String foodDispensed(Object amount) {
    return Intl.message(
      '$amount gr food dispensed',
      name: 'foodDispensed',
      desc: '',
      args: [amount],
    );
  }

  /// `Portion size updated`
  String get portionSizeUpdated {
    return Intl.message(
      'Portion size updated',
      name: 'portionSizeUpdated',
      desc: '',
      args: [],
    );
  }

  /// `Error updating settings: {error}`
  String errorUpdatingSettings(Object error) {
    return Intl.message(
      'Error updating settings: $error',
      name: 'errorUpdatingSettings',
      desc: '',
      args: [error],
    );
  }

  /// `Device is currently offline`
  String get deviceIsOffline {
    return Intl.message(
      'Device is currently offline',
      name: 'deviceIsOffline',
      desc: '',
      args: [],
    );
  }

  /// `{amount} gr per meal`
  String gramsPerMeal(Object amount) {
    return Intl.message(
      '$amount gr per meal',
      name: 'gramsPerMeal',
      desc: '',
      args: [amount],
    );
  }

  /// `Device location updated`
  String get deviceLocationUpdated {
    return Intl.message(
      'Device location updated',
      name: 'deviceLocationUpdated',
      desc: '',
      args: [],
    );
  }

  /// `Edit Location`
  String get editLocation {
    return Intl.message(
      'Edit Location',
      name: 'editLocation',
      desc: '',
      args: [],
    );
  }

  /// `Ex: Living Room, Kitchen, Bedroom`
  String get locationHint {
    return Intl.message(
      'Ex: Living Room, Kitchen, Bedroom',
      name: 'locationHint',
      desc: '',
      args: [],
    );
  }

  /// `Feed {amount} gr`
  String feedNow(Object amount) {
    return Intl.message(
      'Feed $amount gr',
      name: 'feedNow',
      desc: '',
      args: [amount],
    );
  }

  /// `{amount} / {maxAmount} gr food available`
  String currentFoodLevel(Object amount, Object maxAmount) {
    return Intl.message(
      '$amount / $maxAmount gr food available',
      name: 'currentFoodLevel',
      desc: '',
      args: [amount, maxAmount],
    );
  }

  /// `Battery Level`
  String get batteryLevel {
    return Intl.message(
      'Battery Level',
      name: 'batteryLevel',
      desc: '',
      args: [],
    );
  }

  /// `Device Location`
  String get deviceLocation {
    return Intl.message(
      'Device Location',
      name: 'deviceLocation',
      desc: '',
      args: [],
    );
  }

  /// `Ex: Living Room, Kitchen, Bedroom`
  String get locationPlaceholder {
    return Intl.message(
      'Ex: Living Room, Kitchen, Bedroom',
      name: 'locationPlaceholder',
      desc: '',
      args: [],
    );
  }

  /// `Device Status`
  String get deviceStatus {
    return Intl.message(
      'Device Status',
      name: 'deviceStatus',
      desc: '',
      args: [],
    );
  }

  /// `Battery Status`
  String get batteryStatus {
    return Intl.message(
      'Battery Status',
      name: 'batteryStatus',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get home {
    return Intl.message(
      'Home',
      name: 'home',
      desc: '',
      args: [],
    );
  }

  /// `Food Portion Size`
  String get foodPortionSize {
    return Intl.message(
      'Food Portion Size',
      name: 'foodPortionSize',
      desc: '',
      args: [],
    );
  }

  /// `Water Portion Size`
  String get waterPortionSize {
    return Intl.message(
      'Water Portion Size',
      name: 'waterPortionSize',
      desc: '',
      args: [],
    );
  }

  /// `{amount} gr`
  String portionAmount(Object amount) {
    return Intl.message(
      '$amount gr',
      name: 'portionAmount',
      desc: '',
      args: [amount],
    );
  }

  /// `{amount} ml`
  String waterPortionAmount(Object amount) {
    return Intl.message(
      '$amount ml',
      name: 'waterPortionAmount',
      desc: '',
      args: [amount],
    );
  }

  /// `Portion size`
  String get portionSizeHint {
    return Intl.message(
      'Portion size',
      name: 'portionSizeHint',
      desc: '',
      args: [],
    );
  }

  /// `Water amount`
  String get waterAmountHint {
    return Intl.message(
      'Water amount',
      name: 'waterAmountHint',
      desc: '',
      args: [],
    );
  }

  /// `No food left`
  String get noFoodLeft {
    return Intl.message(
      'No food left',
      name: 'noFoodLeft',
      desc: '',
      args: [],
    );
  }

  /// `Reset Password`
  String get resetPassword {
    return Intl.message(
      'Reset Password',
      name: 'resetPassword',
      desc: '',
      args: [],
    );
  }

  /// `Enter your email address to receive a password reset link`
  String get resetPasswordInstructions {
    return Intl.message(
      'Enter your email address to receive a password reset link',
      name: 'resetPasswordInstructions',
      desc: '',
      args: [],
    );
  }

  /// `Send Reset Link`
  String get sendResetLink {
    return Intl.message(
      'Send Reset Link',
      name: 'sendResetLink',
      desc: '',
      args: [],
    );
  }

  /// `Password reset link has been sent to your email`
  String get resetPasswordEmailSent {
    return Intl.message(
      'Password reset link has been sent to your email',
      name: 'resetPasswordEmailSent',
      desc: '',
      args: [],
    );
  }

  /// `Back to Login`
  String get backToLogin {
    return Intl.message(
      'Back to Login',
      name: 'backToLogin',
      desc: '',
      args: [],
    );
  }

  /// `Name is required`
  String get nameRequired {
    return Intl.message(
      'Name is required',
      name: 'nameRequired',
      desc: '',
      args: [],
    );
  }

  /// `Name must be at least 2 characters`
  String get nameMinLength {
    return Intl.message(
      'Name must be at least 2 characters',
      name: 'nameMinLength',
      desc: '',
      args: [],
    );
  }

  /// `Name cannot contain numbers`
  String get nameNoNumbers {
    return Intl.message(
      'Name cannot contain numbers',
      name: 'nameNoNumbers',
      desc: '',
      args: [],
    );
  }

  /// `Dispense Water`
  String get dispenseWater {
    return Intl.message(
      'Dispense Water',
      name: 'dispenseWater',
      desc: '',
      args: [],
    );
  }

  /// `Dispense {amount} ml`
  String dispenseWaterNow(Object amount) {
    return Intl.message(
      'Dispense $amount ml',
      name: 'dispenseWaterNow',
      desc: '',
      args: [amount],
    );
  }

  /// `Per meal`
  String get perMeal {
    return Intl.message(
      'Per meal',
      name: 'perMeal',
      desc: '',
      args: [],
    );
  }

  /// `Per watering`
  String get perWatering {
    return Intl.message(
      'Per watering',
      name: 'perWatering',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'tr'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
