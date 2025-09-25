import '../../../features/auth/model/jwt_token_model.dart';
import '../../../features/auth/model/token_model.dart';

abstract class AuthRepo {
  Future<TokenModel?> login({required String userId, required String password, required String? fcmToken});
  Future<TokenModel?> signUp({
    required String userId,
    required String fullName,
    required String phone,
    required int countryId,
    required String password,
  });
  Future<void> biometricAuthentication({
    required String localizedReason,
    required Function() onSuccess,
    required Function() onFailed,
    required Function() biometricNotFound,
  });
  Future<void> logout();
  Future<JwtTokenModel?> decodeJwtToken();
  Future<String?> addOrRemoveBiometric({required bool isBiometric});
}
