import 'package:khatma/src/i18n/app_localizations_context.dart';
import 'package:khatma/src/widgets/empty_placeholder_widget.dart';
import 'package:flutter/material.dart';

/// Simple not found screen used for 404 errors (page not found on web)
class NotFoundScreen extends StatelessWidget {
  const NotFoundScreen({super.key, this.errorMessage});

  final String? errorMessage;

  @override
  Widget build(BuildContext context) {
    print('NotFoundScreen: $errorMessage');
    return Scaffold(
      appBar: AppBar(
        title: Text(context.loc.pageNotFound),
      ),
      body: EmptyPlaceholderWidget(
        message: errorMessage ?? context.loc.pageNotFound404,
      ),
    );
  }
}
