class CollectionUtils {
  static bool isEmpty(Iterable<int>? collection) {
    return collection == null || collection.isEmpty;
  }

  static bool isNotEmpty(Iterable<int>? collection) {
    return collection != null && collection.isNotEmpty;
  }
}
