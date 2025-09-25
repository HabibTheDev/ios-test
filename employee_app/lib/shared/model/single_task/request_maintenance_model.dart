import '../../../features/maintenance/model/maintenance_repair_damage_model.dart';

import 'regular_servicing_checklist_model.dart';

class RequestMaintenance {
  final dynamic deliveryAddress;
  final dynamic retriveAddress;
  final String? maintanainanceType;
  final List<RegularServicingChecklistModel>? regularRepairCheck;
  final List<MaintenanceRepairDamageModel>? repairDamage;

  RequestMaintenance({
    this.deliveryAddress,
    this.retriveAddress,
    this.regularRepairCheck,
    this.repairDamage,
    this.maintanainanceType,
  });

  factory RequestMaintenance.fromJson(Map<String, dynamic> json) => RequestMaintenance(
        deliveryAddress: json["deliveryAddress"],
        retriveAddress: json["retriveAddress"],
        maintanainanceType: json["maintanainanceType"],
        regularRepairCheck: json["regularRepairCheck"] == null
            ? null
            : RegularServicingChecklistModel.parseRegularRepairCheck(json["regularRepairCheck"]),
        repairDamage: json["repairDamage"] == null
            ? null
            : MaintenanceRepairDamageModel.parseMaintenanceDamage(damageDataList: json["repairDamage"]),
      );
}
