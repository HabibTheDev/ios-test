import '../../../features/inspection/model/inspection_report_model.dart';
import '../../../features/maintenance/model/maintenance_repair_damage_model.dart';

abstract class InspectionRepo {
  Future<String?> detectDamage({required Map<String, String?> filePathsMap});
  Future<InspectionReportModel?> putExteriorDamageReport({
    required String endPoint,
    required int carID,
    required Map<String, String?> filePathsMap,
    required String data,
  });
  Future<InspectionReportModel?> getExteriorInspectionReport({
    required String endPoint,
    required int carID,
    required String inspectionStatus,
  });
  List<MaintenanceRepairDamageModel> parseMaintenanceDamage({required List<dynamic> damageDataList});
  Future<InspectionReportModel?> getCurrentDamageReport({required int carID});
  Future<InspectionReportModel?> getFinalReport({required int carID, required int contractID});
  Future<String?> extractVin({required String filePath});
  Future<bool> completeInspection({required Map<String, dynamic> payload});
}
