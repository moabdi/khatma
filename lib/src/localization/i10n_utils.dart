extension EnumTranslate on Enum {
  String get value => toString().split('.').last;
}
