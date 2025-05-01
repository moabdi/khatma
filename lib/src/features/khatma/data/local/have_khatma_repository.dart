import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:khatma/src/unused/test_khatmat.dart';
import 'package:khatma/src/features/khatma/data/local/local_khatma_repository.dart';
import 'package:khatma/src/features/khatma/domain/khatma.dart';
import 'package:uuid/uuid.dart';

class HaveKhatmaRepository extends LocalKhatmaRepository {
  static const String khatmaBox = "KHATMAT_BOX";

  static Future<Box<String>> openBox() async {
    return await Hive.openBox<String>(khatmaBox);
  }

  Future<void> save(Khatma khatma) async {
    var box = await openBox();
    if (khatma.id == null) {
      khatma = khatma.copyWith(id: Uuid().v4());
    }
    String jsonString = jsonEncode(khatma.toJson());

    await box.put(khatma.id, jsonString);
  }

  Future<Khatma?> getById(String id) async {
    var box = await openBox();
    String? jsonString = box.get(id);

    if (jsonString != null) {
      return Khatma.fromJson(jsonDecode(jsonString));
    }
    box.close();
    return null;
  }

  Future<void> deleteById(String id) async {
    var box = await openBox();
    box.delete(id);
    box.close();
  }

  Future<List<Khatma>> fetchAll() async {
    // await test();
    // delay(true);
    var box = await openBox();

    var list = box.values
        .map((jsonString) => Khatma.fromJson(jsonDecode(jsonString)))
        .toList();

    list.sort((k1, k2) => k1.createDate.compareTo(k2.createDate));
    box.close();
    return list;
  }

  Future<void> test() async {
    var uuid = Uuid();

    var box = await openBox();
    box.clear();
    box.keys.forEach((element) {
      box.delete(element);
    });

    String id;
    kTestKhatmat.forEach(
      (khatma) async {
        id = uuid.v4();
        await box.put(id, jsonEncode(khatma.copyWith(id: id).toJson()));
      },
    );
    box.close();
  }
}
