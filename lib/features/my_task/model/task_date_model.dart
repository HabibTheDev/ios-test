import 'dart:convert';

List<DateTime> taskDateModelFromJson(String str) => List<DateTime>.from(json.decode(str).map((x) => DateTime.parse(x)));
