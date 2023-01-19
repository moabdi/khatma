
import 'package:khatma_app/src/features/khatma/domain/part.dart';
import 'package:khatma_app/src/features/khatma/domain/sourat.dart';

class QuranMetadata {
  List<Sourat> sourat;
  List<Part> parts;

  QuranMetadata({
    required this.sourat,
    required this.parts,
  });
}
