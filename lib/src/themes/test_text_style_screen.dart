import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khatma/src/themes/theme.dart';

void main(List<String> args) {
  runApp(
    ProviderScope(
        child: MaterialApp(
      theme: AppTheme.newLightTheme(),
      home: Scaffold(
        body: ThemeTextStyle(),
      ),
    )),
  );
}

class ThemeTextStyle extends StatelessWidget {
  const ThemeTextStyle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Display Large Text",
              style: Theme.of(context).textTheme.displayLarge,
            ),
            Text(
              "Display Medium Text",
              style: Theme.of(context).textTheme.displayMedium,
            ),
            Text(
              "Display Small Text",
              style: Theme.of(context).textTheme.displaySmall,
            ),
            Text(
              "Headline Large Text",
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            Text(
              "Headline Medium Text",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Text(
              "Headline Small Text",
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            Text(
              "Title Large Text",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Text(
              "Title Medium Text",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(
              "Title Small Text",
              style: Theme.of(context).textTheme.titleSmall,
            ),
            Text(
              "Body Large Text",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            Text(
              "Body Medium Text",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Text(
              "Body Small Text",
              style: Theme.of(context).textTheme.bodySmall,
            ),
            Text(
              "Label Large Text",
              style: Theme.of(context).textTheme.labelLarge,
            ),
            Text(
              "Label Medium Text",
              style: Theme.of(context).textTheme.labelMedium,
            ),
            Text(
              "Label Small Text",
              style: Theme.of(context).textTheme.labelSmall,
            ),
          ],
        ),
      ),
    );
  }
}
