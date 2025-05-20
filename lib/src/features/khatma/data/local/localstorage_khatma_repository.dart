import 'dart:convert';

import 'package:khatma/src/fake/test_khatmat.dart';
import 'package:khatma/src/features/khatma/data/local/local_khatma_repository.dart';
import 'package:khatma/src/features/khatma/domain/khatma.dart';
import 'package:localstorage/localstorage.dart';
import 'package:uuid/uuid.dart';

class LocalStorageKhatmaRepository extends LocalKhatmaRepository {
  static const String khatmaList = "khatmaList";
  final LocalStorage storage = LocalStorage('khatmat.json');
  final _uuid = Uuid();

  Future<void> save(Khatma khatma) async {
    print('[save] Called with khatma: ${khatma.toString()}');
    print('[save] khatma.id: ${khatma.id}');

    String jsonString = storage.getItem(khatmaList) ?? '[]';
    print('[save] Existing JSON string from storage: $jsonString');

    List<dynamic> jsonList = jsonDecode(jsonString);
    List<Khatma> list =
    jsonList.map((jsonItem) => Khatma.fromJson(jsonItem)).toList();
    print('[save] Decoded list from storage: ${list.map((e) => e.id).toList()}');

    final updatedKhatma = khatma.id == null
        ? khatma.copyWith(id: _uuid.v4())
        : khatma;

    if (khatma.id == null) {
      print('[save] Assigned new UUID: ${updatedKhatma.id}');
    }

    int index = list.indexWhere((element) => element.id == updatedKhatma.id);
    print('[save] Index of existing khatma: $index');

    if (index != -1) {
      print('[save] Updating existing khatma with id: ${updatedKhatma.id}');
      list[index] = updatedKhatma;
    } else {
      print('[save] Adding new khatma with id: ${updatedKhatma.id}');
      list.add(updatedKhatma);
    }

    jsonString = jsonEncode(list.map((k) => k.toJson()).toList());
    print('[save] New JSON string to save: $jsonString');
    await storage.setItem(khatmaList, jsonString);
    print('[save] Save complete ✅');
  }



  Future<Khatma?> getById(String id) async {
    print('[getById] Searching for id: $id');

    List<Khatma> list = await fetchAll();
    Khatma? foundKhatma =
    list.firstWhere((khatma) => khatma.id == id, orElse: null);

    return foundKhatma;
  }

  Future<void> deleteById(String id) async {
    print('[deleteById] Deleting khatma with id: $id');
    String jsonString = storage.getItem(khatmaList) ?? '[]';
    List<dynamic> jsonList = jsonDecode(jsonString);
    List<Khatma> list =
    jsonList.map((jsonItem) => Khatma.fromJson(jsonItem)).toList();

    final beforeCount = list.length;
    list.removeWhere((khatma) => khatma.id == id);
    final afterCount = list.length;
    print('[deleteById] Removed ${beforeCount - afterCount} khatma(s)');

    jsonString = jsonEncode(list.map((khatma) => khatma.toJson()).toList());
    await storage.setItem(khatmaList, jsonString);
    print('[deleteById] Deletion complete ✅');
  }

  Future<List<Khatma>> fetchAll() async {
    print('[fetchAll] Fetching all khatma...');
    if (storage.getItem(khatmaList) == null) {
      print('[fetchAll] No data found. Running test() to generate defaults...');
      await test();
    }

    String jsonString = storage.getItem(khatmaList) ?? '[]';
    print('[fetchAll] Raw JSON string: $jsonString');

    List<dynamic> jsonList = jsonDecode(jsonString);
    List<Khatma> result =
    jsonList.map((jsonItem) => Khatma.fromJson(jsonItem)).toList();

    print('[fetchAll] Loaded ${result.length} khatma(s): ${result.map((e) => e.id).toList()}');
    return result;
  }

  Future<void> test() async {
    print('[test] Inserting test khatmas...');
    var uuid = Uuid();
    for (var khatma in kTestKhatmat) {
      var newKhatma = khatma.copyWith(id: uuid.v4());
      print('[test] Saving test khatma: ${newKhatma.id}');
      await save(newKhatma);
    }
    print('[test] Test khatmas inserted ✅');
  }
}
