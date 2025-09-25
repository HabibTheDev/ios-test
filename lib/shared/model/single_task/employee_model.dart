import 'active_car_info_location_model.dart';

class Employee {
  final String? fullName;
  final bool? isActive;
  final String? phone;
  final bool? verified;
  final String? email;
  final ActiveCarInfoLocation? location;

  Employee({this.fullName, this.isActive, this.phone, this.verified, this.email, this.location});

  factory Employee.fromJson(Map<String, dynamic> json) => Employee(
        fullName: json["fullName"],
        isActive: json["isActive"],
        phone: json["phone"],
        verified: json["verified"],
        email: json["email"],
        location: json["location"] == null ? null : ActiveCarInfoLocation.fromJson(json["location"]),
      );
}
