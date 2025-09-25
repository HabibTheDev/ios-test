import 'car_info_model.dart';

class CustomerPurchaseCar {
  final String? type;
  final CarInfo? carInfo;

  CustomerPurchaseCar({this.type, this.carInfo});

  factory CustomerPurchaseCar.fromJson(Map<String, dynamic> json) => CustomerPurchaseCar(
        type: json["type"],
        carInfo: json["carInfo"] == null ? null : CarInfo.fromJson(json["carInfo"]),
      );
}
