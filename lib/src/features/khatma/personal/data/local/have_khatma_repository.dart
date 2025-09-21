import 'dart:async';

import 'package:hive/hive.dart';
import 'package:khatma/src/features/khatma/personal/data/local/base_khatma_repository.dart';

class HiveBoxWrapper implements StorageBox {
  final Box<String> _box;

  HiveBoxWrapper(this._box);

  @override
  Iterable<String> get values => _box.values;
  @override
  Future<void> clear() => _box.clear();
  @override
  String? get(String key) => _box.get(key);
  @override
  Future<void> put(String key, String value) => _box.put(key, value);
  @override
  Future<void> delete(String key) => _box.delete(key);
}

class HiveKhatmaRepository extends BaseKhatmaRepository {
  @override
  Future<HiveBoxWrapper> openKhatmaBox() async {
    final box = await Hive.openBox<String>(khatmaBox);
    return HiveBoxWrapper(box);
  }

  @override
  Future<HiveBoxWrapper> openHistoryBox() async {
    final box = await Hive.openBox<String>(historyBox);
    return HiveBoxWrapper(box);
  }

  @override
  Iterable<String> getBoxValues(StorageBox box) {
    return (box as HiveBoxWrapper).values;
  }

  @override
  Future<void> clearBox(StorageBox box) async {
    await (box as HiveBoxWrapper).clear();
  }
}
