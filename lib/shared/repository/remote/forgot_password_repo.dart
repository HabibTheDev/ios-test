abstract class ForgotPasswordRepo {
  Future<bool> sendOtp({required String email});
  Future<bool> verifyOtp({required String email, required int otpCode});
  Future<bool> updatePassword(
      {required String email, required String password});
  Future<bool> resendOtp({required String email, required String otpType});
}
