import '../../../features/more/model/country_code_model.dart';
import '../../../features/more/model/employee_model.dart';

abstract class ProfileRepo {
  Future<EmployeeModel?> getEmployeeDetails();
  Future<List<CountryCodeModel>?> getCountries();
  Future<bool> updateEmployeeProfile({String? filePath, required Map<String, dynamic> body});
  Future<bool> getLicenseVerificationLink({required String email});
  Future<bool> getPassportVerificationLink({required String email});
}
