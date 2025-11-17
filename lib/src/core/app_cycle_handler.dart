import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppLifecycleHandler extends WidgetsBindingObserver {
  final WidgetRef ref;

  AppLifecycleHandler(this.ref);

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (kDebugMode) {
      debugPrint("App lifecycle changed: $state");
    }
    if (state == AppLifecycleState.resumed) {
     // ref.read(khatmaNotifierProvider.notifier).performSync();
    }
  }
}
