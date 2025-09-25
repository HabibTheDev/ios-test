import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constants/app_string.dart';
import '../../../../core/l10n/app_localizations.dart';
import '../../../../shared/extensions/date_extension.dart';
import '../../../../core/constants/app_list.dart';
import '../../../../shared/repository/remote/inbox_repo.dart';
import '../../../../shared/repository/remote/my_task_repo.dart';
import '../../../../shared/services/remote/socket_service.dart';
import '../../../../shared/services/service_locator.dart';
import '../../../../shared/utils/utils.dart';
import '../../../../shared/widgets/widget_imports.dart';
import '../../../inbox/controller/inbox_controller.dart';
import '../../controller/my_task_controller.dart';
import '../../model/task_filter_model.dart';
import '../tiles/task_tile.dart';
import '../widgets/widget_imports.dart';

class MyTask extends StatefulWidget {
  const MyTask({super.key});

  @override
  State<MyTask> createState() => _MyTaskState();
}

class _MyTaskState extends State<MyTask> {
  @override
  void initState() {
    Get.put(InboxController(inboxRepo: ServiceLocator.get<InboxRepo>()));
    SocketService.instance.initSocket();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context);
    return GetBuilder<MyTaskController>(
      init: MyTaskController(myTaskRepo: ServiceLocator.get<MyTaskRepo>()),
      autoRemove: false,
      builder: (controller) {
        return Obx(
          () => ListRefreshIndicator(
            onRefresh: () async => await controller.refreshMyTask(),
            child: SafeArea(
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  children: [
                    // Header Section
                    Stack(
                      alignment: Alignment.topLeft,
                      children: [
                        HomeEventCalenderWidget(
                          onTimeSelected: (DateTime selectedDate) => controller.changeTaskDate(selectedDate),
                          eventList: controller.taskDates.toList(),
                        ),

                        // HomeCalenderWidget(
                        //   onTimeSelected: (DateTime selectedDate) => controller.changeTaskDate(selectedDate),
                        // ),
                        HomeHeaderWidget(
                          taskOverviewModel: controller.taskOverview.value,
                          myTaskController: controller,
                        ),
                      ],
                    ),

                    HeaderWidget(
                      title: controller.selectedTaskFilterDate.value.isToday()
                          ? '${locale?.today}'
                          : readableDate(
                              controller.selectedTaskFilterDate.value,
                              pattern: AppString.readableDateFormat,
                            ),
                      trailing: TaskFilterDropdown(
                        items: AppList.taskFilterList,
                        selectedValue: controller.selectedTaskFilter.value,
                        hintText: '${locale?.select}',
                        itemToString: (TaskFilterModel item) => item.name,
                        buttonWidth: 156,
                        onChanged: (value) => controller.changeTaskStatus(value),
                      ),
                    ).paddingAll(16),

                    controller.isLoading.value
                        ? const CenterLoadingWidget()
                        : controller.taskList.isEmpty
                        ? const NoDataFound()
                        : ListView.separated(
                            padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: controller.taskList.length,
                            separatorBuilder: (context, index) => const HeightBox(height: 10),
                            itemBuilder: (context, index) => TaskTile(
                              task: controller.taskList[index],
                              onTap: () => controller.handleTaskNavigation(controller.taskList[index]),
                              onReportIssue: (bool? success) {
                                if (success == true) {
                                  controller.fetchTask();
                                }
                              },
                            ),
                          ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
