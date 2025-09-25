import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:employee_app/core/l10n/app_localizations.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_color.dart';
import '../../../shared/utils/utils.dart';
import '../../../shared/widgets/widget_imports.dart';
import '../../my_task/view/tiles/task_tile.dart';
import '../controller/search_controller.dart';
import '../widgets/search_field.dart';

class SearchTask extends StatelessWidget {
  const SearchTask({super.key});

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context);
    final TaskSearchController controller = Get.find();
    return GestureDetector(
      onTap: hideKeyboard,
      child: Scaffold(
        appBar: AppBar(
          leading: const AppBarLeadingIcon(),
          titleSpacing: -8,
          title: SearchField(
            focusNode: controller.searchFocusNode,
            onChanged: (value) {
              controller.searchKey = value;
              controller.searchTask();
            },
          ),
          actions: const [WidthBox(width: 24)],
        ),
        body: Obx(
          () => controller.isLoading.value
              ? const CenterLoadingWidget()
              : controller.taskList.isNotEmpty
              ? Column(
                  children: [
                    Container(
                      color: AppColors.lightBgColor,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Icon(CupertinoIcons.search, color: AppColors.lightTextColor),
                          TitleText(text: ' ${controller.taskList.length} ${locale?.itemFound.toLowerCase()}'),
                        ],
                      ).paddingAll(16),
                    ),
                    Expanded(
                      child: ListView.separated(
                        padding: const EdgeInsets.only(left: 16, right: 16, bottom: 64),
                        shrinkWrap: true,
                        itemCount: controller.taskList.length,
                        separatorBuilder: (context, index) => const HeightBox(height: 10),
                        itemBuilder: (context, index) => TaskTile(
                          task: controller.taskList[index],
                          onTap: () => controller.handleTaskNavigation(controller.taskList[index]),
                          onReportIssue: (bool? success) {
                            if (success == true) {
                              controller.searchTask();
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                )
              : EmptyContentWidget(
                  svgAsset: Assets.assetsSvgSearch,
                  title: '${locale?.searchYourTasks}',
                  subTitle: '${locale?.searchTaskMgs}',
                ).paddingSymmetric(horizontal: 16),
        ),
      ),
    );
  }
}
