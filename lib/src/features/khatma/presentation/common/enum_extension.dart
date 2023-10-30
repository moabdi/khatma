import 'package:flutter/material.dart';
import 'package:khatma/src/features/khatma/domain/khatma.dart';

extension ShareIcon on KhatmaShareType {
  IconData get icon {
    switch (this) {
      case KhatmaShareType.public:
        return Icons.public;
      case KhatmaShareType.private:
        return Icons.lock;
      case KhatmaShareType.group:
        return Icons.group;
      default:
        return Icons.error;
    }
  }
}
