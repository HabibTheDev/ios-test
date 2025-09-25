abstract class CrashlyticsRepo {
  Future<void> recordExceptionToSentry(
    Exception error,
    dynamic stackTrace, {
    Uri? apiUrl,
    dynamic apiResponse,
    dynamic apiPayload,
  });
}
