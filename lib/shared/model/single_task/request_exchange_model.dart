import 'request_handover_model.dart';

class RequestExchange {
  final RequestHandover? handoverRequest;
  final RequestHandover? returnRequest;

  RequestExchange({this.handoverRequest, this.returnRequest});

  factory RequestExchange.fromJson(Map<String, dynamic> json) => RequestExchange(
        handoverRequest: json["handoverRequest"] == null ? null : RequestHandover.fromJson(json["handoverRequest"]),
        returnRequest: json["returnRequest"] == null ? null : RequestHandover.fromJson(json["returnRequest"]),
      );
}
