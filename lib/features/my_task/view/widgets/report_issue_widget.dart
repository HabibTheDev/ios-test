import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constants/app_color.dart';
import '../../../../core/constants/app_string.dart';
import '../../../../core/l10n/app_localizations.dart';
import '../../../../shared/repository/remote/my_task_repo.dart';
import '../../../../shared/services/service_locator.dart';
import '../../../../shared/utils/utils.dart';
import '../../../../shared/widgets/widget_imports.dart';
import '../../controller/pending_tasks_controller.dart';

class ReportIssueWidget extends StatefulWidget {
  const ReportIssueWidget({
    super.key,
    required this.taskId,
    this.isEdit = true,
    this.issue,
    this.issueReportedDate,
    required this.onReportComplete,
  });
  final int taskId;
  final bool isEdit;
  final String? issue;
  final DateTime? issueReportedDate;
  final Function(bool? success) onReportComplete;

  @override
  State<ReportIssueWidget> createState() => _ReportIssueWidgetState();
}

class _ReportIssueWidgetState extends State<ReportIssueWidget> {
  late PendingTasksController controller;
  late FocusNode issueFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    if (Get.isRegistered<PendingTasksController>()) {
      controller = Get.find();
    } else {
      controller = Get.put(PendingTasksController(myTaskRepo: ServiceLocator.get<MyTaskRepo>()));
    }
    issueFocusNode.requestFocus();
  }

  @override
  void dispose() {
    issueFocusNode.dispose();
    Get.delete<PendingTasksController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context);
    return GestureDetector(
      onTap: hideKeyboard,
      child: SafeArea(
        child: Form(
          key: controller.reportIssueFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (widget.isEdit == true)
                TextFormFieldWithLabel(
                  controller: controller.reportIssueController,
                  focusNode: issueFocusNode,
                  required: true,
                  hintText: '${locale?.writeHere}',
                  labelText: '${locale?.issue}',
                  minLine: 5,
                  maxLine: 15,
                  textCapitalization: TextCapitalization.sentences,
                ).paddingAll(16),

              // Issue reported date
              if (widget.isEdit == false && widget.issueReportedDate != null)
                ExtraSmallText(
                  text: readableDate(widget.issueReportedDate!, pattern: AppString.readableDateFormat),
                  textColor: AppColors.lightSecondaryTextColor,
                ).paddingOnly(bottom: 10, left: 16, right: 16),

              // Issue
              if (widget.isEdit == false && widget.issue != null)
                Expanded(
                  child: SingleChildScrollView(
                    child: CardWidget(
                      width: double.infinity,
                      contentPadding: EdgeInsets.all(10),
                      bgColor: AppColors.lightOtherUserChatColor,
                      showShadow: false,
                      child: BodyText(text: widget.issue ?? ''),
                    ).paddingSymmetric(horizontal: 16),
                  ),
                ),

              if (widget.isEdit) const Spacer(),
              const AppDivider(height: 10.0),

              // Cancel & Done button
              widget.isEdit
                  ? Row(
                      children: [
                        Expanded(
                          child: OutlineTextButton(
                            buttonText: '${locale?.cancel}',
                            onTap: () {
                              controller.reportIssueController.clear();
                              Get.back();
                            },
                          ),
                        ),
                        const WidthBox(width: 8),
                        Expanded(
                          child: Obx(
                            () => SolidTextButton(
                              buttonText: '${locale?.done}',
                              isLoading: controller.issueReportLoading.value,
                              onTap: () async {
                                final bool success = await controller.reportTaskIssue(
                                  taskId: widget.taskId,
                                  locale: locale,
                                );
                                if (success) {
                                  widget.onReportComplete(success);
                                  Get.back();
                                }
                              },
                            ),
                          ),
                        ),
                      ],
                    ).paddingAll(16)
                  // Close button
                  : SolidTextButton(buttonText: '${locale?.close}', onTap: () => Get.back()).paddingAll(16),
            ],
          ),
        ),
      ),
    );
  }
}
