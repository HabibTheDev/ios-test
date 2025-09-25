extension DoubleExtensions on double {
  double twoDecimalPlaces() {
    return double.parse(toStringAsFixed(2));
  }
}
