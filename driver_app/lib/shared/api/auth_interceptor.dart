import 'dart:convert';
import 'package:dio/dio.dart';

import '../../flavor_config.dart';
import '../repository/local/local_storage_repo.dart';
import '../../core/constants/api_endpoint.dart';
import '../repository/remote/auth_repo.dart';
import '../services/service_locator.dart';

class AuthInterceptor extends Interceptor {
  const AuthInterceptor(this.dio);
  final Dio dio;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    // Add Authorization header if token exists
    final String? token = await ServiceLocator.get<LocalStorageRepo>().getAccessToken();
    if (token != null) options.headers['Authorization'] = token;

    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    final errorHandlerDio = _getDio();

    // Handle 401 errors (Unauthorized)
    if (err.response?.statusCode == 401) {
      final bool tokenRefreshed = await _refreshToken();

      if (tokenRefreshed) {
        // Retry the original request with the new token
        final RequestOptions requestOptions = err.requestOptions;
        final String? newToken = await ServiceLocator.get<LocalStorageRepo>().getAccessToken();
        if (newToken != null) requestOptions.headers['Authorization'] = newToken;

        try {
          final Response retryResponse = await errorHandlerDio.fetch(requestOptions);
          return handler.resolve(retryResponse);
        } on DioException catch (retryError) {
          // Token refresh failed; logout user
          ServiceLocator.get<AuthRepo>().logout();
          return handler.reject(retryError);
        }
      } else {
        // Token refresh failed; logout user
        ServiceLocator.get<AuthRepo>().logout();
        return handler.reject(err);
      }
    } else {
      super.onError(err, handler);
    }
  }

  Future<bool> _refreshToken() async {
    final refreshDio = _getDio();

    try {
      final String? refreshToken = await ServiceLocator.get<LocalStorageRepo>().getRefreshToken();
      if (refreshToken == null) return false;

      final Response response = await refreshDio.post(
        ApiEndpoint.refreshToken,
        data: jsonEncode({'refreshToken': refreshToken}),
      );

      if (response.statusCode == 200 && response.data['data']['accessToken'] != null) {
        await ServiceLocator.get<LocalStorageRepo>().saveAccessToken(token: response.data['data']['accessToken']);
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  Dio _getDio() {
    final BaseOptions baseOptions = BaseOptions(
      baseUrl: AppFlavor.apiBaseUrl,
      headers: {'Content-Type': 'application/json'},
      connectTimeout: const Duration(seconds: 60),
      receiveTimeout: const Duration(seconds: 60),
    );
    return Dio(baseOptions);
  }
}
