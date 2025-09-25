import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constants/app_string.dart';
import '../../../../core/l10n/app_localizations.dart';
import '../../../../shared/extensions/string_extension.dart';
import '../../../../core/constants/app_color.dart';
import '../../../../shared/enums/enums.dart';
import '../../../../shared/extensions/date_extension.dart';
import '../../../../shared/utils/utils.dart';
import '../../../../shared/widgets/widget_imports.dart';
import '../../model/task_model.dart';
import '../widgets/report_issue_widget.dart';

class TaskTile extends StatelessWidget {
  const TaskTile({super.key, required this.task, required this.onTap, required this.onReportIssue});
  final TaskModel task;
  final Function() onTap;
  final Function(bool? success) onReportIssue;

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context);
    final double progress = task.completionRate != null && task.completionRate != 0 ? (task.completionRate! / 100) : 0;
    return InkWell(
      onTap: onTap,
      borderRadius: const BorderRadius.all(Radius.circular(6)),
      child: CardWidget(
        contentPadding: const EdgeInsets.all(12),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                task.state?.toLowerCase() == TaskStateEnum.defaultType.value
                    // Custom task
                    ? BodyText(
                        text: (task.title ?? '${locale?.notAvailable}').toCapitalized(),
                        fontWeight: FontWeight.w600,
                      ).paddingOnly(bottom: 10)
                    // Other task (Entry, Handover, Return etc.)
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (task.state != null && task.state?.toLowerCase() != TaskStateEnum.defaultType.value)
                            BodyText(
                              text: ((task.state?.replaceAll('-', ' ')) ?? '${locale?.notAvailable}').toCapitalized(),
                              fontWeight: FontWeight.w600,
                            ),
                          if (task.type != null && task.type?.toLowerCase() != TaskStateEnum.defaultType.value)
                            SmallText(
                              text: (task.type ?? '${locale?.notAvailable}').toCapitalized(),
                              textColor: AppColors.lightTextFieldHintColor,
                            ),
                        ],
                      ).paddingOnly(bottom: 10),

                // Date time
                Row(
                  children: [
                    const Icon(
                      Icons.watch_later_rounded,
                      color: AppColors.primaryColor,
                      size: 16,
                    ).paddingOnly(right: 6),
                    SmallText(
                      text: task.date != null
                          ? readableDate(task.date!, pattern: AppString.readableTimeFormat)
                          : locale?.notAvailable ?? '',
                      textSize: 15,
                      maxLine: 1,
                    ),
                  ],
                ).paddingOnly(bottom: 4),

                // Car info
                if (task.state != TaskStateEnum.defaultType.value)
                  Row(
                    children: [
                      const Icon(Icons.directions_car, color: AppColors.primaryColor, size: 16),
                      SmallText(
                        text:
                            ' ${task.carMake ?? '${locale?.notAvailable}'} ${task.carModel ?? '${locale?.notAvailable}'}',
                        textSize: 15,
                        maxLine: 1,
                      ),
                    ],
                  ),

                // Progress bar
                if (task.completionRate != 100 && task.status != TaskFilterType.completed.value)
                  Row(
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: const BorderRadius.all(Radius.circular(6)),
                          child: LinearProgressIndicator(
                            value: progress,
                            minHeight: 5,
                            backgroundColor: AppColors.lightTextFieldFillColor,
                          ),
                        ),
                      ),
                      const WidthBox(width: 4),
                      SmallText(text: '${task.completionRate}%', textColor: AppColors.lightSecondaryTextColor),
                    ],
                  ).paddingOnly(top: 10),

                // Report issue button
                if (task.status == TaskFilterType.inProgress.value && task.issue == null)
                  Center(
                    child: TextButton(
                      onPressed: () {
                        modalBottomSheet(
                          context: context,
                          title: '${locale?.reportIssue}',
                          child: ReportIssueWidget(
                            taskId: task.id ?? 0,
                            onReportComplete: (bool? success) {
                              onReportIssue(success);
                            },
                          ),
                        );
                      },
                      child: ButtonText(text: '${locale?.reportIssue}', textColor: AppColors.primaryColor),
                    ),
                  ),
              ],
            ),

            // Started date & issue reported widgets
            if (task.status != TaskFilterType.pending.value)
              Positioned(
                top: 0,
                right: 0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Starting date
                        if (task.status == TaskFilterType.inProgress.value)
                          ExtraSmallText(
                            text: '${locale?.started} ${task.startTaskDate.timeAgo()}',
                            textColor: AppColors.lightSecondaryTextColor,
                          ),

                        // Issue reported icon
                        if (task.issue != null)
                          Tooltip(
                            margin: EdgeInsets.symmetric(horizontal: 20),
                            preferBelow: false,
                            showDuration: const Duration(seconds: 3),
                            message: locale?.viewReportedIssueTooltip,
                            child: InkWell(
                              onTap: () {
                                modalBottomSheet(
                                  context: context,
                                  title: '${locale?.reportedIssue}',
                                  child: ReportIssueWidget(
                                    taskId: task.id ?? 0,
                                    isEdit: false,
                                    issue: task.issue,
                                    issueReportedDate: task.issueReportedDate,
                                    onReportComplete: (success) {},
                                  ),
                                );
                              },
                              child: Icon(Icons.info, color: AppColors.lightSecondaryTextColor, size: 20),
                            ).paddingOnly(left: 8),
                          ),
                      ],
                    ).paddingOnly(bottom: 8),

                    if (task.status != TaskFilterType.completed.value && task.priority != null)
                      ExtraSmallText(
                        text: '${task.priority?.toCapitalized() ?? ''} ${locale?.priority.toLowerCase()}',
                        textColor: _getPriorityColor(task.priority ?? ''),
                      ),
                  ],
                ),
              ),

            // Complete icon
            if (task.completionRate == 100 && task.status == TaskFilterType.completed.value)
              const Positioned(right: 0, child: Icon(Icons.check_circle, color: AppColors.primaryColor, size: 20)),
          ],
        ),
      ),
    );
  }

  Color _getPriorityColor(String priority) {
    switch (priority.toLowerCase()) {
      case 'high':
        return AppColors.warningColor;
      case 'regular':
        return AppColors.lightProgressColor;
      default:
        return AppColors.lightSecondaryTextColor;
    }
  }
}
