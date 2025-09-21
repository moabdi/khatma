import 'package:khatma/src/features/khatma/personal/data/local/base_khatma_repository.dart';

const message = 'LocalStorage not supported on this platform';

class LocalStorageBox implements StorageBox {
  LocalStorageBox(String boxName);

  @override
  Iterable<String> get values {
    throw UnsupportedError(message);
  }

  @override
  String? get(String key) => throw UnsupportedError(message);

  @override
  Future<void> put(String key, String value) async =>
      throw UnsupportedError(message);

  @override
  Future<void> delete(String key) async => throw UnsupportedError(message);

  @override
  Future<void> clear() async => throw UnsupportedError(message);
}

class LocalStorageKhatmaRepository extends BaseKhatmaRepository {
  @override
  Future<StorageBox> openKhatmaBox() async => throw UnsupportedError(message);

  @override
  Future<StorageBox> openHistoryBox() async => throw UnsupportedError(message);

  @override
  Iterable<String> getBoxValues(StorageBox box) =>
      throw UnsupportedError(message);

  @override
  Future<void> clearBox(StorageBox box) async =>
      throw UnsupportedError(message);
}
