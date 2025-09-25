import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constants/app_color.dart';
import '../../../../core/l10n/app_localizations.dart';
import '../../../../shared/enums/enums.dart';
import '../../../../shared/model/single_task_model.dart';
import '../../../../shared/widgets/widget_imports.dart';
import 'report_issue_widget.dart';

class ReportIssueButtonWidget extends StatelessWidget {
  const ReportIssueButtonWidget({super.key, required this.taskModel, required this.onReportComplete});
  final SingleTaskModel? taskModel;
  final Function() onReportComplete;

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context);
    return taskModel?.task?.status != TaskFilterType.pending.value
        ? taskModel?.task?.isIssueReported == true
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        if (taskModel?.task?.id != null) {
                          modalBottomSheet(
                            context: context,
                            title: '${locale?.reportedIssue}',
                            child: ReportIssueWidget(
                              taskId: taskModel!.task!.id!,
                              isEdit: false,
                              issue: taskModel?.task?.issue,
                              issueReportedDate: taskModel?.task?.issueReportedDate,
                              onReportComplete: (bool? success) {},
                            ),
                          );
                        }
                      },
                      child: ButtonText(text: '${locale?.viewIssue}', textColor: AppColors.primaryColor),
                    ),
                    Tooltip(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      preferBelow: false,
                      showDuration: const Duration(seconds: 3),
                      message: locale?.viewReportedIssueTooltip,
                      child: Icon(Icons.info, color: AppColors.lightSecondaryTextColor, size: 20),
                    ).paddingOnly(left: 8),
                  ],
                )
              : taskModel?.task?.status == TaskFilterType.inProgress.value
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        if (taskModel?.task?.id != null) {
                          modalBottomSheet(
                            context: context,
                            title: '${locale?.reportIssue}',
                            child: ReportIssueWidget(
                              taskId: taskModel!.task!.id!,
                              onReportComplete: (bool? success) {
                                if (success == true) {
                                  onReportComplete();
                                }
                              },
                            ),
                          );
                        }
                      },
                      child: ButtonText(text: '${locale?.reportIssue}', textColor: AppColors.primaryColor),
                    ),
                    Tooltip(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      preferBelow: false,
                      showDuration: const Duration(seconds: 5),
                      message: locale?.reportIssueTooltip,
                      child: Icon(Icons.info, color: AppColors.lightSecondaryTextColor, size: 20),
                    ).paddingOnly(left: 8),
                  ],
                )
              : SizedBox.shrink()
        : SizedBox.shrink();
  }
}
