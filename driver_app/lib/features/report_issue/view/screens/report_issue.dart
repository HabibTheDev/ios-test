import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/router/router_paths.dart';
import '../../../../shared/widgets/empty_content_widget.dart';
import '../../../../shared/widgets/header_widget.dart';
import '../../../../shared/widgets/heightbox.dart';
import '../../../../shared/widgets/solid_text_button.dart';
import '../../controller/report_issue_controller.dart';
import '../tiles/report_issue_tile.dart';

class ReportIssue extends StatelessWidget {
  const ReportIssue({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ReportIssueController>(
        init: ReportIssueController(),
        builder: (controller) {
          return Scaffold(
            body: 1 != 1
                ? const EmptyContentWidget(
                    title: 'Nothing to show here!',
                    subTitle:
                        'We don\'t have any information to display at the moment. You\'ll be notified if there are any developments',
                    svgAsset: Assets.assetsSvgSearch,
                  )
                : Column(
                    children: [
                      //title
                      const HeaderWidget(title: 'Report issue').paddingOnly(left: 16, right: 16, top: 16),

                      Expanded(
                        child: ListView.separated(
                          padding: const EdgeInsets.all(16),
                          itemCount: 10,
                          separatorBuilder: (context, index) => const HeightBox(height: 10),
                          itemBuilder: (context, index) => const ReportIssueTile(),
                        ),
                      )
                    ],
                  ),
            bottomNavigationBar: SafeArea(
              child: SolidTextButton(
                      onTap: () => Get.toNamed(RouterPaths.reportIssueCarPick), buttonText: 'Create a report')
                  .paddingSymmetric(horizontal: 16),
            ),
          );
        });
  }
}
