abstract class ChangePasswordRepo {
  Future<bool> changePassword({
    required String email,
    required String password,
    required String newPassword,
  });
  Future<bool> verifyOtp({required String email, required int otpCode});
  Future<bool> resendOtp({required String email, required String otpType});
}
