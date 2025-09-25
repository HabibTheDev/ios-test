import 'dart:ui';

import '../../features/drawer/model/drawer_model.dart';
import '../../features/my_task/model/in_progress_task_filter_model.dart';
import '../../features/my_task/model/pending_task_filter_model.dart';
import '../../features/my_task/model/task_filter_model.dart';
import '../../features/my_task/model/time_slot_model.dart';
import '../../shared/enums/enums.dart';
import '../../shared/enums/locale.enum.dart';
import 'app_assets.dart';

class AppList {
  AppList._();

  static final localeList = [Locale(LocaleEnum.english.value), Locale(LocaleEnum.bengali.value)];

  static const genderList = ['Male', 'Female', 'Others'];

  static final List<DrawerModel> drawerItemList = [
    DrawerModel(asset: Assets.assetsSvgTask, title: 'My Task', drawerItemEnum: DrawerItemEnum.myTask),
    DrawerModel(asset: Assets.assetsSvgInbox, title: 'Inbox', drawerItemEnum: DrawerItemEnum.inbox),
    DrawerModel(asset: Assets.assetsSvgMore, title: 'More', drawerItemEnum: DrawerItemEnum.more),
  ];

  static final List<TaskFilterModel> taskFilterList = [
    TaskFilterModel(name: 'All task', taskFilterType: TaskFilterType.allTask),
    TaskFilterModel(name: 'Pending', taskFilterType: TaskFilterType.pending),
    TaskFilterModel(name: 'In progress', taskFilterType: TaskFilterType.inProgress),
    TaskFilterModel(name: 'Competed', taskFilterType: TaskFilterType.completed),
    TaskFilterModel(name: 'Reported issue', taskFilterType: TaskFilterType.reportedIssue),
  ];

  static final List<PendingTaskFilterModel> pendingTaskFilterList = [
    PendingTaskFilterModel(name: 'All', taskFilterType: PendingTaskFilterType.all),
    PendingTaskFilterModel(name: 'Upcoming', taskFilterType: PendingTaskFilterType.upcoming),
    PendingTaskFilterModel(name: 'Due', taskFilterType: PendingTaskFilterType.due),
  ];

  static final List<InProgressTaskFilterModel> inProgressTaskFilterList = [
    InProgressTaskFilterModel(name: 'All', taskFilterType: InProgressTaskFilterType.all),
    InProgressTaskFilterModel(name: 'High priority', taskFilterType: InProgressTaskFilterType.highPriority),
    InProgressTaskFilterModel(name: 'Regular', taskFilterType: InProgressTaskFilterType.regular),
  ];

  static final List<TimeSlotModel> timeSlotList = [
    TimeSlotModel(name: 'All Time', timeSlotEnum: TimeSlotEnum.allTime),
    TimeSlotModel(name: 'This Week', timeSlotEnum: TimeSlotEnum.thisWeek),
    TimeSlotModel(name: 'Last Week', timeSlotEnum: TimeSlotEnum.lastWeek),
    TimeSlotModel(name: 'This Month', timeSlotEnum: TimeSlotEnum.thisMonth),
  ];

  static const List<String> carHealthTabList = ['Exterior', 'Condition', 'Performance'];

  static const List<String> inspectionInstructionList = [
    'Place the car in a well lit environment.',
    'Position yourself so that the entire car always stays within the camera frame.',
    'Start at the driver\'s side and move left around the car to the rear side, as guided in the process.',
    'After the process is complete, press the arrow to continue.',
    'If you want to retake the video, press repeat.',
  ];

  static const List<String> damageSeverityList = ['High', 'Medium', 'Low'];

  static const List<String> recommendationList = ['Repair', 'Replace'];

  static const List<String> damageTypeList = [
    'Bent',
    'Broken-Light',
    'Broken-Mirror',
    'Broken-Part',
    'Broken-Window',
    'Corrosion-Rust',
    'Cracked',
    'Curbing',
    'Dent',
    'Detachment',
    'Missing-Part',
    'Paint-Peeling',
    'Scratch',
  ];
}
