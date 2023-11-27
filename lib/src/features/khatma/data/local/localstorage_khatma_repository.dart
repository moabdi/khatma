import 'dart:convert';

import 'package:khatma/src/common/constants/test_khatmat.dart';
import 'package:khatma/src/features/khatma/data/local/local_khatma_repository.dart';
import 'package:khatma/src/features/khatma/domain/khatma.dart';
import 'package:localstorage/localstorage.dart';
import 'package:uuid/uuid.dart';

class LocalStorageKhatmaRepository extends LocalKhatmaRepository {
  static const String khatmaList = "khatmaList";
  final LocalStorage storage = new LocalStorage('khatmat.json');

  Future<void> save(Khatma khatma) async {
    String jsonString = storage.getItem(khatmaList) ?? '[]';
    List<dynamic> jsonList = jsonDecode(jsonString);

    List<Khatma> list =
        jsonList.map((jsonItem) => Khatma.fromJson(jsonItem)).toList();

    int index = list.indexWhere((element) => element.id == khatma.id);

    if (index != -1) {
      list[index] = khatma;
    } else {
      list.add(khatma);
    }

    jsonString = jsonEncode(list.map((khatma) => khatma.toJson()).toList());
    await storage.setItem(khatmaList, jsonString);
  }

  Future<Khatma?> getById(String id) async {
    String jsonString = storage.getItem(khatmaList) ?? '[]';
    List<dynamic> jsonList = jsonDecode(jsonString);
    List<Khatma> list =
        jsonList.map((jsonItem) => Khatma.fromJson(jsonItem)).toList();
    Khatma? foundKhatma =
        list.firstWhere((khatma) => khatma.id == id, orElse: null);

    return foundKhatma;
  }

  Future<void> deleteById(String id) async {
    String jsonString = storage.getItem(khatmaList) ?? '[]';
    List<dynamic> jsonList = jsonDecode(jsonString);
    List<Khatma> list =
        jsonList.map((jsonItem) => Khatma.fromJson(jsonItem)).toList();
    list.removeWhere((khatma) => khatma.id == id);
    jsonString = jsonEncode(list.map((khatma) => khatma.toJson()).toList());
    await storage.setItem(khatmaList, jsonString);
  }

  Future<List<Khatma>> fetchAll() async {
    if (storage.getItem(khatmaList) == null) {
      await test();
    }
    String jsonString = storage.getItem(khatmaList) ?? '[]';
    List<dynamic> jsonList = jsonDecode(jsonString);
    return jsonList.map((jsonItem) => Khatma.fromJson(jsonItem)).toList();
  }

  Future<void> test() async {
    var uuid = Uuid();
    kTestKhatmat.forEach(
      (khatma) async => save(khatma.copyWith(id: uuid.v4())),
    );
  }
}
