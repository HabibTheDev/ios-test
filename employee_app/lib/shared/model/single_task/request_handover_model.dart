class RequestHandover {
  final String? deliveryAddress;

  RequestHandover({this.deliveryAddress});

  factory RequestHandover.fromJson(Map<String, dynamic> json) => RequestHandover(
        deliveryAddress: json["deliveryAddress"],
      );
}
