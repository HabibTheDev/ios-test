extension StringExtensions on String {
  String toCapitalized() {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1).toLowerCase()}';
  }
}

extension NullableStringExtensions on String? {
  bool isNotNull() {
    return this != null;
  }

  bool isValidUrl() {
    if (this == null) return false;
    final uri = Uri.tryParse(this!);
    return uri != null && uri.hasAbsolutePath && (uri.hasScheme && (uri.scheme == 'http' || uri.scheme == 'https'));
  }
}
