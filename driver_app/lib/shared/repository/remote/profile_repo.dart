import '../../../features/more/model/country_code_model.dart';
import '../../../features/more/model/customer_model.dart';

abstract class ProfileRepo {
  Future<CustomerModel?> getCustomerDetails();
  Future<List<CountryCodeModel>?> getCountries();
  Future<bool> updateCustomerProfile({
    String? filePath,
    required Map<String, dynamic> body,
  });
}
