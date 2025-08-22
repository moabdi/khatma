import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:khatma/firebase_options.dart';
import 'package:khatma/src/app.dart';
import 'package:khatma/src/i18n/string_hardcoded.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

// Initialize Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  usePathUrlStrategy();

  if (!kIsWeb) {
    final appDocumentDirectory = await getApplicationDocumentsDirectory();
    Hive.init(appDocumentDirectory.path);
  }

  LicenseRegistry.addLicense(() async* {
    final license =
        await rootBundle.loadString('assets/fonts/google_fonts/OFL.txt');
    yield LicenseEntryWithLineBreaks(['google_fonts'], license);
  });

  await registerErrorHandlers();

  runApp(const ProviderScope(child: MainApp()));
}

Future<void> registerErrorHandlers() async {
  if (!kIsWeb) {
    // Enable Crashlytics
    await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);

    // Non-fatal Flutter errors
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
    // Fatal errors (Dart/Platform level)
    PlatformDispatcher.instance.onError = (Object error, StackTrace stack) {
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      debugPrint(error.toString());
      return true;
    };
  } else {
    // Fatal errors (Dart/Platform level)
    PlatformDispatcher.instance.onError = (Object error, StackTrace stack) {
      debugPrint(error.toString());
      return true;
    };
  }
  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.presentError(details);
    debugPrint(details.toString());
  };

  ErrorWidget.builder = (FlutterErrorDetails details) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text('An error occurred'.hardcoded),
      ),
      body: Center(child: Text(details.toString())),
    );
  };
}
