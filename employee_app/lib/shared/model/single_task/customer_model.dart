class Customer {
  final int? id;
  final String? name;
  final String? email;
  final String? phone;
  final String? address;
  final String? images;
  final User? user;

  Customer({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.address,
    this.images,
    this.user,
  });

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        address: json["address"],
        images: json["images"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
      );
}

class User {
  final bool? isConfirmed;

  User({this.isConfirmed});

  factory User.fromJson(Map<String, dynamic> json) => User(
        isConfirmed: json["isConfirmed"],
      );
}
