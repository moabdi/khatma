import 'package:firebase_ui_localizations/firebase_ui_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:khatma/src/common/utils/common.dart';
import 'package:khatma/src/features/authentication/data/auth_repository.dart';
import 'package:khatma/src/i18n/local_provider.dart';
import 'package:khatma/src/i18n/string_hardcoded.dart';
import 'package:khatma/src/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khatma/src/themes/theme.dart';
import 'package:khatma/src/themes/theme_provider.dart';

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.read(authRepositoryProvider).signInAnonymously();

    return MaterialApp.router(
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        FirebaseUILocalizations.delegate,
      ],
      supportedLocales: supportedLocales,
      debugShowCheckedModeBanner: false,
      restorationScopeId: 'app',
      onGenerateTitle: (BuildContext context) => 'Khatma'.hardcoded,
      theme: AppTheme.newLightTheme(),
      darkTheme: AppTheme.newDarkTheme(),
      locale: ref.watch(localeProvider),
      routerConfig: ref.watch(goRouterProvider),
      themeMode: ref.watch(themeProvider),
      localeResolutionCallback: (deviceLocale, supportedLocales) {
        if (deviceLocale != null) {
          for (var locale in supportedLocales) {
            if (locale.languageCode == deviceLocale.languageCode) {
              return locale;
            }
          }
        }
        return supportedLocales.first;
      },
    );
  }
}
