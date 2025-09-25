import 'dart:ui';

import 'package:flutter/material.dart' show FlutterError;

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

import '../../../core/constants/app_string.dart';
import '../../../features/auth/model/jwt_token_model.dart';
import '../../../flavor_config.dart';
import '../../repository/remote/auth_repo.dart';
import '../../repository/remote/crashlytics_repo.dart';
import '../service_locator.dart';

class CrashlyticsService extends CrashlyticsRepo {
  static final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;
  static final FirebaseCrashlytics _crashlytics = FirebaseCrashlytics.instance;

  @override
  Future<void> recordFatalError() async {
    try {
      // Get user email from JWT token
      final JwtTokenModel? jwtTokenModel = await ServiceLocator.get<AuthRepo>().decodeJwtToken();
      final String? email = jwtTokenModel?.email;
      // Set user identifier and custom keys
      if (email != null) {
        _crashlytics.setUserIdentifier(email);
        _crashlytics.setCustomKey('user_email', email);
      }
      _crashlytics.setCustomKey('app_name', AppString.appName);
      _crashlytics.setCustomKey('Env', AppFlavor.envName);

      // Set up error handlers
      FlutterError.onError = _crashlytics.recordFlutterFatalError;
      PlatformDispatcher.instance.onError = (error, stack) {
        _crashlytics.recordError(error, stack, fatal: true);
        return true;
      };
    } catch (e) {
      // If setting user info fails, still set up error handlers
      FlutterError.onError = _crashlytics.recordFlutterFatalError;
      PlatformDispatcher.instance.onError = (error, stack) {
        _crashlytics.recordError(error, stack, fatal: true);
        return true;
      };
    }
  }

  @override
  Future<void> logApiException(
    Exception error,
    dynamic stackTrace, {
    Uri? apiUrl,
    dynamic apiResponse,
    dynamic apiPayload,
  }) async {
    try {
      final JwtTokenModel? jwtTokenModel = await ServiceLocator.get<AuthRepo>().decodeJwtToken();
      final String? email = jwtTokenModel?.email;

      final Map<String, Object> parameters = {
        'app_name': AppString.appName,
        'env': AppFlavor.envName,
        'error_type': error.runtimeType.toString(),
        'error': error.toString(),
        'stack_trace': stackTrace.toString(),
      };

      if (email != null) {
        parameters['user_email'] = email;
      }
      if (apiUrl != null) {
        parameters['api_url'] = apiUrl.toString();
      }
      if (apiPayload != null) {
        parameters['api_payload'] = apiPayload.toString();
      }
      if (apiResponse != null) {
        parameters['api_response'] = apiResponse.toString();
      }

      await _analytics.logEvent(name: 'API ERROR', parameters: parameters);
    } catch (_) {}
  }

  // @override
  // Future<void> logExceptionToSentry(
  //   Exception error,
  //   dynamic stackTrace, {
  //   Uri? apiUrl,
  //   dynamic apiResponse,
  //   dynamic apiPayload,
  // }) async {
  //   if (AppFlavor.env == Env.prod) {
  //     try {
  //       final JwtTokenModel? jwtTokenModel = await ServiceLocator.get<AuthRepo>().decodeJwtToken();
  //       final String? email = jwtTokenModel?.email;
  //       // Set user context before capturing exception
  //       Sentry.configureScope((scope) {
  //         scope.setUser(
  //           SentryUser(
  //             email: email ?? '',
  //             data: {
  //               'app': AppString.appName,
  //               'url': apiUrl ?? '',
  //               'api_payload': apiPayload ?? '',
  //               'api_response': apiResponse ?? '',
  //             },
  //           ),
  //         );
  //       });
  //       await Sentry.captureException(error, stackTrace: stackTrace);
  //       // Optional: Clear user after sending
  //       Sentry.configureScope((scope) => scope.setUser(null));
  //     } catch (e) {
  //       debugPrint('Sentry:- record exception failed: $e');
  //     }
  //   }
  // }
}
