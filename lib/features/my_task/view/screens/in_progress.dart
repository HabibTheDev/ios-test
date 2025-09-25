import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constants/app_color.dart';
import '../../../../core/constants/app_list.dart';
import '../../../../core/l10n/app_localizations.dart';
import '../../../../core/router/router_paths.dart';
import '../../../../shared/widgets/widget_imports.dart';
import '../../controller/in_progress_controller.dart';
import '../../model/in_progress_task_filter_model.dart';
import '../tiles/task_tile.dart';
import '../widgets/widget_imports.dart';

class InProgress extends StatelessWidget {
  const InProgress({super.key});

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context);
    final InProgressController controller = Get.find();
    return Scaffold(
      appBar: AppBar(
        leading: const AppBarLeadingIcon(),
        centerTitle: false,
        titleSpacing: -8,
        title: ButtonText(text: '${locale?.inProgress}', textColor: AppColors.lightAppBarIconColor),
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
              () => TaskFilterDropdown(
                items: AppList.inProgressTaskFilterList,
                selectedValue: controller.selectedTaskFilter.value,
                hintText: '${locale?.select}',
                itemToString: (InProgressTaskFilterModel item) => item.name,
                onChanged: (value) => controller.changeTaskStatus(value),
              ),
            ),
          ).paddingAll(16),
          Expanded(
            child: Obx(
              () => controller.isLoading.value
                  ? const CenterLoadingWidget()
                  : ListRefreshIndicator(
                      onRefresh: () async => await controller.fetchInProgressTask(),
                      child: ListView.separated(
                        padding: const EdgeInsets.only(left: 16, right: 16, bottom: 64),
                        physics: const AlwaysScrollableScrollPhysics(),
                        itemCount: controller.taskList.length,
                        separatorBuilder: (context, index) => const HeightBox(height: 10),
                        itemBuilder: (context, index) => TaskTile(
                          task: controller.taskList[index],
                          onTap: () => controller.handleTaskNavigation(controller.taskList[index]),
                          onReportIssue: (bool? success) {
                            if (success == true) {
                              controller.fetchInProgressTask();
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
