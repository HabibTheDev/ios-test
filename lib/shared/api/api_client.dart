part of 'api_imports.dart';

class ApiClient {
  late BaseOptions baseOptions;
  late Dio dio;
  late BaseOptions aiBaseOptions;
  late Dio aiDio;

  ApiClient() {
    // Dio initialization
    baseOptions = BaseOptions(
      baseUrl: AppFlavor.apiBaseUrl,
      headers: {'Content-Type': 'application/json'},
      connectTimeout: const Duration(seconds: 60),
      receiveTimeout: const Duration(seconds: 60),
    );
    dio = Dio(baseOptions);
    // Add the AuthInterceptor
    dio.interceptors.add(AuthInterceptor(dio));

    // AI Dio initialization
    final aiBaseOptions = BaseOptions(
      baseUrl: AppFlavor.aiBaseUrl,
      headers: {'Authorization': 'Bearer ${AppFlavor.aiJWT}'},
      connectTimeout: const Duration(minutes: 5),
      sendTimeout: const Duration(minutes: 5),
      receiveTimeout: const Duration(minutes: 5),
    );
    aiDio = Dio(aiBaseOptions);
  }

  // GET request
  Future<Response> getRequest({required String path, Map<String, dynamic>? queryParameters}) async {
    final online = await ConnectivityService.instance.isOnline();
    if (!online) {
      throw ApiException(message: AppString.notInternet, success: false, statusCode: null);
    }
    try {
      final Response response = await dio.get(path, queryParameters: queryParameters);
      return _processResponse(response);
    } on DioException catch (e, s) {
      throw _handleDioException(e, s);
    }
  }

  // POST request
  Future<Response> postRequest({
    required String path,
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParameters,
  }) async {
    final online = await ConnectivityService.instance.isOnline();
    if (!online) {
      throw ApiException(message: AppString.notInternet, success: false, statusCode: null);
    }
    try {
      final Response response = await dio.post(
        path,
        data: body != null ? jsonEncode(body) : body,
        queryParameters: queryParameters,
      );
      return _processResponse(response);
    } on DioException catch (e, s) {
      throw _handleDioException(e, s);
    }
  }

  // PUT request
  Future<Response> putRequest({
    required String path,
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParameters,
  }) async {
    final online = await ConnectivityService.instance.isOnline();
    if (!online) {
      throw ApiException(message: AppString.notInternet, success: false, statusCode: null);
    }
    try {
      final Response response = await dio.put(
        path,
        data: body != null ? jsonEncode(body) : body,
        queryParameters: queryParameters,
      );
      return _processResponse(response);
    } on DioException catch (e, s) {
      throw _handleDioException(e, s);
    }
  }

  // PATCH request
  Future<Response> patchRequest({
    required String path,
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParameters,
  }) async {
    final online = await ConnectivityService.instance.isOnline();
    if (!online) {
      throw ApiException(message: AppString.notInternet, success: false, statusCode: null);
    }
    try {
      final Response response = await dio.patch(
        path,
        data: body != null ? jsonEncode(body) : body,
        queryParameters: queryParameters,
      );
      return _processResponse(response);
    } on DioException catch (e, s) {
      throw _handleDioException(e, s);
    }
  }

  // DELETE request
  Future<Response> deleteRequest({required String path, Map<String, dynamic>? body}) async {
    final online = await ConnectivityService.instance.isOnline();
    if (!online) {
      throw ApiException(message: AppString.notInternet, success: false, statusCode: null);
    }
    try {
      final Response response = await dio.delete(path, data: body != null ? jsonEncode(body) : body);
      return _processResponse(response);
    } on DioException catch (e, s) {
      throw _handleDioException(e, s);
    }
  }

  // Multipart PUT request
  Future<Response> multipartPutRequest({
    required String path,
    required String? filePath,
    Map<String, dynamic>? body,
  }) async {
    final online = await ConnectivityService.instance.isOnline();
    if (!online) {
      throw ApiException(message: AppString.notInternet, success: false, statusCode: null);
    }

    // Dynamically build the form data map
    final Map<String, dynamic> formMap = {'data': jsonEncode(body)};

    if (filePath != null && filePath.isNotEmpty) {
      formMap['file'] = await MultipartFile.fromFile(filePath, filename: filePath.split('/').last);
    }
    final FormData formData = FormData.fromMap(formMap);

    try {
      final Response response = await dio.put(path, data: formData);
      return _processResponse(response);
    } on DioException catch (e, s) {
      throw _handleDioException(e, s);
    }
  }

  // Multipart PATCH request
  Future<Response> multipartPatchRequest({required String path, String? filePath, Map<String, dynamic>? body}) async {
    final online = await ConnectivityService.instance.isOnline();
    if (!online) {
      throw ApiException(message: AppString.notInternet, success: false, statusCode: null);
    }

    // Dynamically build the form data map
    final Map<String, dynamic> formMap = {'data': jsonEncode(body)};

    if (filePath != null && filePath.isNotEmpty) {
      formMap['file'] = await MultipartFile.fromFile(filePath, filename: filePath.split('/').last);
    }
    final FormData formData = FormData.fromMap(formMap);

    try {
      final Response response = await dio.patch(path, data: formData);
      return _processResponse(response);
    } on DioException catch (e, s) {
      throw _handleDioException(e, s);
    }
  }

  // Multipart POST request
  Future<Response> multipartPostRequest({
    required String path,
    List<String>? filePaths,
    Map<String, dynamic>? body,
  }) async {
    final online = await ConnectivityService.instance.isOnline();
    if (!online) {
      throw ApiException(message: AppString.notInternet, success: false, statusCode: null);
    }

    final FormData formData = FormData();
    if (filePaths != null && filePaths.isNotEmpty) {
      for (String filePath in filePaths) {
        final MultipartFile multipartFile = await MultipartFile.fromFile(filePath, filename: filePath.split('/').last);
        formData.files.add(MapEntry('file', multipartFile));
      }
    }

    formData.fields.add(MapEntry('data', jsonEncode(body)));
    try {
      final Response response = await dio.post(path, data: formData);
      return _processResponse(response);
    } on DioException catch (e, s) {
      throw _handleDioException(e, s);
    }
  }

  // AI Multipart POST request
  Future<Response> aiMultipartPostRequest({required String path, required Map<String, String?> filePathsMap}) async {
    final online = await ConnectivityService.instance.isOnline();
    if (!online) {
      throw ApiException(message: AppString.notInternet, success: false, statusCode: null);
    }

    // Prepare form data
    final FormData formData = FormData();
    filePathsMap.forEach((key, filePath) async {
      final MultipartFile multipartFile = await MultipartFile.fromFile(filePath!, filename: filePath.split('/').last);
      formData.files.add(MapEntry(key, multipartFile));
    });

    try {
      final Response response = await aiDio.post(path, data: formData);
      return _processResponse(response);
    } on DioException catch (e, s) {
      throw _handleDioException(e, s);
    }
  }

  // AI Multipart PUT request
  Future<Response> aiMultipartPutRequest({
    required String path,
    required Map<String, String?> filePathsMap,
    String? data,
  }) async {
    final online = await ConnectivityService.instance.isOnline();
    if (!online) {
      throw ApiException(message: AppString.notInternet, success: false, statusCode: null);
    }

    final FormData formData = FormData();
    filePathsMap.forEach((key, filePath) async {
      final MultipartFile multipartFile = await MultipartFile.fromFile(filePath!, filename: filePath.split('/').last);
      formData.files.add(MapEntry(key, multipartFile));
    });

    if (data != null) formData.fields.add(MapEntry('data', data));

    try {
      final Response response = await dio.put(path, data: formData);
      return _processResponse(response);
    } on DioException catch (e, s) {
      throw _handleDioException(e, s);
    }
  }

  Response _processResponse(Response response) {
    _logResponse(response);
    if (response.statusCode != null && response.statusCode! >= 200 && response.statusCode! <= 300) {
      return response;
    } else {
      throw ApiException(success: false, statusCode: response.statusCode, message: response.statusMessage);
    }
  }

  ApiException _handleDioException(DioException e, dynamic stackTrace) {
    final payload = _getPayload(e.response);
    _logResponse(e.response);

    // Record error to crashlytics
    ServiceLocator.get<CrashlyticsRepo>().logApiException(
      e,
      stackTrace,
      apiUrl: e.response?.requestOptions.uri,
      apiPayload: payload,
      apiResponse: e.response?.data,
    );

    final statusCode = e.response?.statusCode;
    final responseData = e.response?.data;

    // Explicitly handle 500 internal server error
    if (statusCode == HttpStatus.internalServerError) {
      throw ApiException(
        success: false,
        statusCode: HttpStatus.internalServerError,
        message: '$statusCode, Internal server error!',
      );
    }
    // Handle case where there's no response
    if (e.response == null) {
      throw ApiException(
        success: false,
        message: '$statusCode, Network Error! Try again later.',
        statusCode: statusCode,
      );
    }
    // Handle case where there's no response data
    if (responseData == null) {
      throw ApiException(
        success: false,
        message: '$statusCode, Data not found! Try again later.',
        statusCode: statusCode,
      );
    }
    // Check if responseData is a valid Map<String, dynamic>
    if (responseData is Map<String, dynamic>) {
      throw ApiException(
        success: responseData['success'] ?? false,
        statusCode: responseData['statusCode'] ?? statusCode,
        message:
            responseData['message'] ?? responseData['error']?['message'] ?? '$statusCode ${e.response?.statusMessage}',
      );
    } else {
      // Handle non-JSON response (e.g. plain text, HTML, or null response)
      throw ApiException(success: false, statusCode: statusCode, message: '${e.response?.statusMessage}');
    }
  }

  dynamic _getPayload(Response? response) {
    dynamic payload;
    if (response?.requestOptions.data != null) {
      if (response?.requestOptions.data is FormData) {
        payload = response?.requestOptions.data.fields;
      } else {
        payload = response?.requestOptions.data;
      }
    }
    return payload;
  }

  void _logResponse(Response? response) {
    final payload = _getPayload(response);

    debugPrint('\n👉------------------------------<API Response>------------------------------');
    debugPrint('TOKEN           : ${response?.requestOptions.headers['Authorization']}', wrapWidth: 1024);
    debugPrint('METHOD          : ${response?.requestOptions.method}');
    debugPrint('URL             : ${response?.requestOptions.uri}');
    debugPrint('STATUS CODE     : ${response?.statusCode}');
    debugPrint('PAYLOAD         : $payload', wrapWidth: 1024);
    debugPrint('RESPONSE        : ${response?.data}', wrapWidth: 1024);
    debugPrint('------------------------------------<End>---------------------------------👈\n');
  }
}
