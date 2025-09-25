import '../../model/single_task_model.dart';

abstract class SingleTaskRepo {
  Future<SingleTaskModel?> getSingleTask({required int? taskId});
  Future<bool> completeEntryInspectionStep({
    required int? taskId,
    required int? stepId,
    String? filePath,
    Map<String, dynamic>? body,
  });
  Future<bool> completeMaintenanceStep({required int? taskId, required int? stepId});
  Future<bool> completeHandoverStep({required int? taskId, required int? stepId});
  Future<bool> completeReturnStep({required int? taskId, required int? stepId});
  Future<bool> completeExchangeStep({required int? taskId, required int? stepId});
  Future<bool> completeCommonStep({required int? taskId, required int? stepId});
  Future<bool> startTask({required int? taskId, required int? stepId});
  Future<bool> provideMaintenanceInfo({
    required int carId,
    String? regularMaintenanceType,
    List<String>? filePaths,
    Map<String, dynamic>? body,
  });
}
