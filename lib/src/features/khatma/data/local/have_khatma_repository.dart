import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:khatma/src/common/constants/test_khatmat.dart';
import 'package:khatma/src/features/khatma/data/local/local_khatma_repository.dart';
import 'package:khatma/src/features/khatma/domain/khatma.dart';
import 'package:uuid/uuid.dart';

class HaveKhatmaRepository extends LocalKhatmaRepository {
  static const String khatmaBox = "KHATMAT_BOX";

  Future<void> save(Khatma khatma) async {
    var box = await Hive.openBox<String>(khatmaBox);
    String jsonString = jsonEncode(khatma.toJson());
    await box.put(khatma.id, jsonString);
    box.close();
  }

  Future<Khatma?> getById(String id) async {
    print(id);
    var box = await Hive.openBox<String>(khatmaBox);
    String? jsonString = box.get(id);
    print(jsonString);

    if (jsonString != null) {
      return Khatma.fromJson(jsonDecode(jsonString));
    }
    box.close();
    return null;
  }

  Future<void> deleteById(String id) async {
    var box = await Hive.openBox<String>(khatmaBox);
    box.delete(id);
    box.close();
  }

  Future<List<Khatma>> fetchAll() async {
    var uuid = Uuid();

    var box = await Hive.openBox<String>(khatmaBox);

    String id;
    kTestKhatmat.forEach(
      (khatma) async => {
        id = uuid.v4(),
        await box.put(id, jsonEncode(khatma.copyWith(id: id).toJson())),
      },
    );

    var list = box.values
        .map((jsonString) => Khatma.fromJson(jsonDecode(jsonString)))
        .toList();

    box.close();
    return list;
  }
}
