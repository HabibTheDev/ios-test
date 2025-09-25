class TaskLocation {
  final String? locationName;
  final String? latitude;
  final String? longitude;

  TaskLocation({this.locationName, this.latitude, this.longitude});

  factory TaskLocation.fromJson(Map<String, dynamic> json) => TaskLocation(
        locationName: json["locationName"],
        latitude: json["latitude"],
        longitude: json["longitude"],
      );
}
