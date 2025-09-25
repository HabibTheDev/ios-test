extension IntExtension on int? {
  bool isNotNullNotZero() {
    return this != null && this != 0;
  }

  bool isNotNull() {
    return this != null;
  }
}
