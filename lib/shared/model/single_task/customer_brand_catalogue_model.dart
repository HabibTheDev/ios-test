import 'customer_model.dart';
import 'customer_purchase_car_model.dart';

class CusotmerBrandCatalogue {
  final int? contactId;
  final String? usersId;
  final DateTime? purchaseDate;
  final String? status;
  final int? currentActiveCar;
  final int? currentRequestCar;
  final String? contactStatus;
  final Customer? customer;
  final CustomerPurchaseCar? customerPurchaseCar;

  CusotmerBrandCatalogue({
    this.contactId,
    this.usersId,
    this.purchaseDate,
    this.status,
    this.currentActiveCar,
    this.currentRequestCar,
    this.contactStatus,
    this.customer,
    this.customerPurchaseCar,
  });

  factory CusotmerBrandCatalogue.fromJson(Map<String, dynamic> json) => CusotmerBrandCatalogue(
        contactId: json["ContactID"],
        usersId: json["usersID"],
        purchaseDate: json["purchaseDate"] == null ? null : DateTime.parse(json["purchaseDate"]),
        status: json["status"],
        currentActiveCar: json["currentActiveCar"],
        currentRequestCar: json["currentRequestCar"],
        contactStatus: json["contactStatus"],
        customer: json["customer"] == null ? null : Customer.fromJson(json["customer"]),
        customerPurchaseCar:
            json["customerPurchaseCar"] == null ? null : CustomerPurchaseCar.fromJson(json["customerPurchaseCar"]),
      );
}
