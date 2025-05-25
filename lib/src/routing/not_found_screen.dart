import 'package:khatma/src/i18n/string_hardcoded.dart';
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
        title: Text("Page not found".hardcoded),
      ),
      body: EmptyPlaceholderWidget(
        message: errorMessage ?? '404 - Page not found!'.hardcoded,
      ),
    );
  }
}
