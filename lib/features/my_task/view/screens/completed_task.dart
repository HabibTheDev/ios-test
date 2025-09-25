import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constants/app_color.dart';
import '../../../../core/constants/app_list.dart';
import '../../../../core/l10n/app_localizations.dart';
import '../../../../core/router/router_paths.dart';
import '../../../../shared/widgets/widget_imports.dart';
import '../../controller/completed_tasks_controller.dart';
import '../tiles/task_tile.dart';
import '../widgets/widget_imports.dart';

class CompletedTask extends StatelessWidget {
  const CompletedTask({super.key});

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context);
    final CompletedTasksController controller = Get.find();
    return Scaffold(
      appBar: AppBar(
        leading: const AppBarLeadingIcon(),
        centerTitle: false,
        titleSpacing: -8,
        title: ButtonText(text: '${locale?.completeTask}', textColor: AppColors.lightAppBarIconColor),
        actions: [
          IconButton(
            onPressed: () => Get.toNamed(RouterPaths.search),
            icon: const Icon(Icons.search, color: AppColors.lightAppBarIconColor),
          ),
        ],
      ),
      body: Column(
        children: [
          HeaderWidget(
            title: '${locale?.tasks}',
            backgroundColor: AppColors.lightBgColor,
            trailing: Obx(
              () => TimeSlotDropdown(
                items: AppList.timeSlotList,
                selectedValue: controller.selectedTimeSlot.value,
                hintText: '${locale?.select}',
                onChanged: (value) => controller.changeTimeSlot(value),
              ),
            ),
          ).paddingAll(16),
          Expanded(
            child: Obx(
              () => controller.isLoading.value
                  ? const CenterLoadingWidget()
                  : ListRefreshIndicator(
                      onRefresh: () async => await controller.fetchCompletedTask(),
                      child: ListView.separated(
                        padding: const EdgeInsets.only(left: 16, top: 16, right: 16, bottom: 64),
                        physics: const AlwaysScrollableScrollPhysics(),
                        itemCount: controller.completedTasks.length,
                        separatorBuilder: (context, index) => const HeightBox(height: 10),
                        itemBuilder: (context, index) => TaskTile(
                          task: controller.completedTasks[index],
                          onTap: () => controller.handleTaskNavigation(controller.completedTasks[index]),
                          onReportIssue: (bool? success) {
                            if (success == true) {
                              controller.fetchCompletedTask();
                            }
                          },
                        ),
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
