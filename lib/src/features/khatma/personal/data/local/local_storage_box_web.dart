import 'dart:async';
import 'package:web/web.dart' as html;

import 'package:khatma/src/features/khatma/personal/data/local/base_khatma_repository.dart';

class LocalStorageBox implements StorageBox {
  final String boxName;
  final html.Storage _storage = html.window.localStorage;

  LocalStorageBox(this.boxName);

  List<String> get keys {
    final prefix = '${boxName}_';
    final storageKeys = <String>[];

    for (int i = 0; i < _storage.length; i++) {
      final key = _storage.key(i);
      if (key != null && key.startsWith(prefix)) {
        storageKeys.add(key.substring(prefix.length));
      }
    }
    return storageKeys;
  }

  @override
  Iterable<String> get values {
    final prefix = '${boxName}_';
    final storageValues = <String>[];

    for (int i = 0; i < _storage.length; i++) {
      final key = _storage.key(i);
      if (key != null && key.startsWith(prefix)) {
        final value = _storage.getItem(key);
        if (value != null && value.isNotEmpty) {
          storageValues.add(value);
        }
      }
    }
    return storageValues;
  }

  @override
  String? get(String key) {
    return _storage.getItem('${boxName}_$key');
  }

  @override
  Future<void> put(String key, String value) async {
    _storage.setItem('${boxName}_$key', value);
  }

  @override
  Future<void> delete(String key) async {
    _storage.removeItem('${boxName}_$key');
  }

  @override
  Future<void> clear() async {
    final prefix = '${boxName}_';
    final keysToRemove = <String>[];

    for (int i = 0; i < _storage.length; i++) {
      final key = _storage.key(i);
      if (key != null && key.startsWith(prefix)) {
        keysToRemove.add(key);
      }
    }

    for (String key in keysToRemove) {
      _storage.removeItem(key);
    }
  }
}

class LocalStorageKhatmaRepository extends BaseKhatmaRepository {
  @override
  Future<LocalStorageBox> openKhatmaBox() async {
    return LocalStorageBox(khatmaBox);
  }

  @override
  Future<LocalStorageBox> openHistoryBox() async {
    return LocalStorageBox(historyBox);
  }

  @override
  Iterable<String> getBoxValues(StorageBox box) {
    return (box as LocalStorageBox).values;
  }

  @override
  Future<void> clearBox(StorageBox box) async {
    await (box as LocalStorageBox).clear();
  }
}
