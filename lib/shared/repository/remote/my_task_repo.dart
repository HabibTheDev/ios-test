import '../../../features/my_task/model/task_model.dart';
import '../../../features/my_task/model/task_overview_model.dart';

abstract class MyTaskRepo {
  Future<TaskOverviewModel?> getTaskOverview();
  Future<List<DateTime>> getTaskDates();
  Future<List<TaskModel>?> getTask({required Map<String, dynamic>? queryParameters});
  Future<bool> reportTaskIssue({required int taskId, required String issue});
}
