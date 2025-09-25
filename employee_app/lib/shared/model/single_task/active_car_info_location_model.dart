class ActiveCarInfoLocation {
  final String? locationName;

  ActiveCarInfoLocation({this.locationName});

  factory ActiveCarInfoLocation.fromJson(Map<String, dynamic> json) => ActiveCarInfoLocation(
        locationName: json["locationName"],
      );
}
