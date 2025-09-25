abstract class CrashlyticsRepo {
  Future<void> recordFatalError();
  Future<void> logApiException(
    Exception error,
    dynamic stackTrace, {
    Uri? apiUrl,
    dynamic apiResponse,
    dynamic apiPayload,
  });
  // Future<void> logApiExceptionToSentry(
  //   Exception error,
  //   dynamic stackTrace, {
  //   Uri? apiUrl,
  //   dynamic apiResponse,
  //   dynamic apiPayload,
  // });
}
