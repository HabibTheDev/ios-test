class ApiException implements Exception {
  final String? message;
  final bool? success;
  final int? statusCode;
  ApiException(
      {required this.success, required this.statusCode, required this.message});
}
