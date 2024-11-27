import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FormValidators {
  static String? email(String? value) {
    if (value == null || value.isEmpty) {
      return 'E-posta adresi gerekli';
    }
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'Geçerli bir e-posta adresi giriniz';
    }
    return null;
  }

  static String? validatePassword(String? value, context) {
    if (value == null || value.isEmpty) {
      return AppLocalizations.of(context)!.passwordRequired;
    }

    if (value.length < 6) {
      return AppLocalizations.of(context)!.passwordMinLength;
    }

    return null;
  }

  static String? validateName(String? value, AppLocalizations localizations) {
    if (value == null || value.isEmpty) {
      return localizations.formValidation.nameRequired;
    }

    if (value.length < 2) {
      return localizations.formValidation.nameMinLength;
    }

    if (value.contains(RegExp(r'[0-9]'))) {
      return localizations.formValidation.nameNoNumbers;
    }

    return null;
  }
}

extension on AppLocalizations {
  get formValidation => null;
}
