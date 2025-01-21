import 'package:flutter/material.dart';
import 'package:khatma/src/features/khatma/domain/khatma.dart';

extension ShareIcon on ShareVisibility {
  IconData get icon {
    switch (this) {
      case ShareVisibility.public:
        return Icons.public;
      case ShareVisibility.private:
        return Icons.lock;
      case ShareVisibility.group:
        return Icons.group;
    }
  }
}
