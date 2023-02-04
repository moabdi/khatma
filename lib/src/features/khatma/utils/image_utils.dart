import 'package:khatma/src/features/khatma/enums/khatma_enums.dart';

class ImageUtils {
  static String getAssetImage(String? type) {
    if (type == null || KhatmaType.custom.name == type) {
      return "assets/images/khatma/khatma.png";
    }
    return "assets/images/khatma/$type.png";
  }
}
