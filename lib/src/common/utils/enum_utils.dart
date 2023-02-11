String getEnumName(String type) {
  return type.toLowerCase().split(".").last;
}

T enumFromString<T>(Iterable<T> values, String value) {
  return values.firstWhere((type) => equqls(type, value));
}

bool equqls(type, String value) =>
    type.toString().split(".").last == value.split(".").last;
