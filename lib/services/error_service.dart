import 'package:logging/logging.dart';
import 'package:flutter/material.dart';
import 'package:iot/services/snackbar_service.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ErrorService {
  static final _logger = Logger('ErrorService');

  static void handleError({
    required BuildContext context,
    required String error,
    required String operation,
    bool showSnackbar = true,
  }) {
    _logger.severe('$operation hatası: $error');

    if (showSnackbar && context.mounted) {
      SnackbarService.showSnackbar(
        context,
        message: AppLocalizations.of(context)!.errorOccurred(error),
        isError: true,
      );
    }
  }

  static Future<T?> wrapError<T>({
    required BuildContext context,
    required Future<T> Function() operation,
    required String errorMessage,
    bool showSnackbar = true,
  }) async {
    try {
      return await operation();
    } catch (e) {
      handleError(
        context: context,
        error: e.toString(),
        operation: errorMessage,
        showSnackbar: showSnackbar,
      );
      return null;
    }
  }

  static Future<T?> handleAsyncOperation<T>({
    required BuildContext context,
    required Future<T> Function() operation,
    required String successMessage,
    void Function(T result)? onSuccess,
    bool showSuccessMessage = true,
  }) async {
    if (!context.mounted) return null;

    try {
      final result = await operation();

      if (!context.mounted) return null;

      if (showSuccessMessage) {
        SnackbarService.showSnackbar(
          context,
          message: successMessage,
        );
      }

      onSuccess?.call(result);
      return result;
    } catch (e) {
      if (!context.mounted) return null;

      SnackbarService.showSnackbar(
        context,
        message: AppLocalizations.of(context)!.errorOccurred(e.toString()),
        isError: true,
      );
      return null;
    }
  }
}
