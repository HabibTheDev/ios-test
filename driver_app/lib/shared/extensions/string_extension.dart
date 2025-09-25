extension NullableStringExtensions on String? {
  bool isNotNull() {
    return this != null;
  }

  String capitalizeFirstLetter() {
    if (this == null || this!.isEmpty) {
      return '';
    }
    return this![0].toUpperCase() + this!.substring(1);
  }
}
