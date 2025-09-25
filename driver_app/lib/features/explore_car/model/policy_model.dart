import 'dart:convert';

List<PolicyModel> policyModelFromJson(String str) =>
    List<PolicyModel>.from(json.decode(str).map((x) => PolicyModel.fromJson(x)));

class PolicyModel {
  final int? id;
  final String? policyName;
  final bool? isActive;
  final int? pid;
  final String? typePolicy;
  final int? policyId;

  PolicyModel({
    this.id,
    this.policyName,
    this.isActive,
    this.pid,
    this.typePolicy,
    this.policyId,
  });

  factory PolicyModel.fromJson(Map<String, dynamic> json) => PolicyModel(
        id: json["id"],
        policyName: json["policyName"],
        isActive: json["isActive"],
        pid: json["pid"],
        typePolicy: json["typePolicy"],
        policyId: json["policyId"],
      );
}
