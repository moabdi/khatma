import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khatma/src/features/settings/domain/settings.dart';

final settingsProvider = NotifierProvider<SettingsNotifier, Settings>(
  SettingsNotifier.new,
);

class SettingsNotifier extends Notifier<Settings> {
  @override
  Settings build() {
    return Settings();
  }

  void updateRiwaya(String riwaya) {
    if (state.riwaya != riwaya) {
      state = state.copyWith(riwaya: riwaya);
    }
  }

  void replace(Settings newPreferences) {
    state = newPreferences;
  }

  String toJson() => state.toJson();
}
