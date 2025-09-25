import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import '../../core/constants/app_color.dart';
import 'appbar_leading_icon.dart';
import 'progress_bar_widget.dart';
import 'text_widget.dart';

class ProgressBarScaffold extends StatelessWidget {
  const ProgressBarScaffold(
      {super.key,
      required this.title,
      this.subTitle,
      required this.progressValue,
      required this.body});
  final String title;
  final String? subTitle;
  final double progressValue;
  final Widget body;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const AppBarLeadingIcon(),
        titleSpacing: -8,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ButtonText(
              text: title,
              textColor: AppColors.lightAppBarIconColor,
              maxLines: 1,
            ),
            if (subTitle != null)
              SmallText(
                text: subTitle!,
                textColor: AppColors.lightAppBarIconColor,
                maxLine: 1,
              )
          ],
        ),
        actions: [
          ProgressBarWidget(
            progressValue: progressValue,
            width: 132,
            height: 8,
            color: AppColors.lightProgressColor,
            trackColor: AppColors.lightAppBarProgressTrackColor,
          ).paddingOnly(right: 4),
          BodyText(
            text: '${(progressValue * 100).round()}%',
            textColor: AppColors.lightAppBarIconColor,
          ).paddingOnly(right: 16)
        ],
      ),

      // PreferredSize(
      //   preferredSize: const Size.fromHeight(56),
      //   child: SafeArea(
      //     child: Container(
      //       color: AppColors.primaryColor,
      //       child: Row(
      //         crossAxisAlignment: CrossAxisAlignment.center,
      //         children: [
      //           AppbarLeadingIcon(),
      //           Expanded(
      //               child: Column(
      //             crossAxisAlignment: CrossAxisAlignment.start,
      //             mainAxisAlignment: MainAxisAlignment.center,
      //             children: [
      //               ButtonText(
      //                 text: title,
      //                 textColor: AppColors.lightAppbarIconColor,
      //                 maxLines: 1,
      //               ),
      //               if (subTitle != null)
      //                 SmallText(
      //                   text: subTitle!,
      //                   textColor: AppColors.lightAppbarIconColor,
      //                   maxLine: 1,
      //                 )
      //             ],
      //           )),
      //           SizedBox(
      //             width: 140,
      //             child: ClipRRect(
      //               borderRadius: BorderRadius.all(Radius.circular(6)),
      //               child: LinearProgressIndicator(
      //                 value: progressValue,
      //                 color: AppColors.lightProgressColor,
      //                 minHeight: 8,
      //                 backgroundColor: AppColors.lightProgressTrackColor,
      //               ),
      //             ),
      //           ).paddingOnly(right: 4),
      //           BodyText(
      //             text: '${(progressValue * 100).round()}%',
      //             textColor: AppColors.lightAppbarIconColor,
      //           ).paddingOnly(right: 16)
      //         ],
      //       ),
      //     ),
      //   ),
      // ),
      body: body,
    );
  }
}
