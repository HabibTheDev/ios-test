import 'package:employee_app/shared/extensions/string_extension.dart';

class AssignedBy {
  final String? fullName;
  final String? email;
  final String? phone;
  final String? profilePicture;
  final String? designation;

  AssignedBy({this.fullName, this.email, this.phone, this.profilePicture, this.designation});

  factory AssignedBy.fromJson(Map<String, dynamic> json) => AssignedBy(
    fullName: json["fullName"],
    email: json["email"],
    phone: json["phone"],
    profilePicture: json["profilePicture"],
    designation: json["designation"]?.toString().replaceAll('_', ' ').replaceAll('-', ' ').trim().toCapitalized(),
  );
}
