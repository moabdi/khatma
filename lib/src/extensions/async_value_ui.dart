import 'package:khatma/src/error/app_error_code.dart';
import 'package:khatma/src/error/app_error_dialog.dart';
import 'package:khatma/src/i18n/app_localizations_context.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khatma_ui/extentions/string_extensions.dart';

extension AsyncValueUI on AsyncValue {
  void showAlertDialogOnError(BuildContext context) {
    if (!isLoading && hasError) {
      AppErrorDialog.show(
        context,
        AppErrorCode.syncGeneralFailure,
        title: context.loc.error.capitalize,
        message: error?.toString() ?? context.loc.errorOccurred,
      );
    }
  }
}
