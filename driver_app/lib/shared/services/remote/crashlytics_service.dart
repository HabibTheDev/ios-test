import 'package:flutter/foundation.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import '../../../features/auth/model/jwt_token_model.dart';
import '../../../flavor_config.dart';
import '../../repository/remote/auth_repo.dart';
import '../../repository/remote/crashlytics_repo.dart';
import '../service_locator.dart';

class CrashlyticsService extends CrashlyticsRepo {
  @override
  Future<void> recordExceptionToSentry(
    Exception error,
    dynamic stackTrace, {
    Uri? apiUrl,
    dynamic apiResponse,
    dynamic apiPayload,
  }) async {
    if (AppFlavor.env == Env.prod) {
      try {
        final JwtTokenModel? jwtTokenModel = await ServiceLocator.get<AuthRepo>().decodeJwtToken();
        final String? email = jwtTokenModel?.email;

        // Set user context before capturing exception
        Sentry.configureScope((scope) {
          scope.setUser(
            SentryUser(
              email: email ?? '',
              data: {'url': apiUrl ?? '', 'api_payload': apiPayload ?? '', 'api_response': apiResponse ?? ''},
            ),
          );
        });

        await Sentry.captureException(error, stackTrace: stackTrace);
        // Optional: Clear user after sending
        Sentry.configureScope((scope) => scope.setUser(null));
      } catch (e) {
        debugPrint('Sentry:- record exception failed: $e');
      }
    }
  }
}
