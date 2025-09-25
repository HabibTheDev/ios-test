import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_color.dart';
import '../../../../shared/widgets/image_placeholder_widget.dart';
import '../../../../shared/widgets/text_widget.dart';
import '../../model/exchange_history_model.dart';
import 'dashed_line_painter.dart';

class ExchangeHistoryStepper extends StatelessWidget {
  const ExchangeHistoryStepper({super.key, required this.steps, this.showCar = false});
  final List<ExchangeHistoryModel> steps;
  final bool showCar;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: showCar ? false : true,
      physics: showCar ? const BouncingScrollPhysics() : const NeverScrollableScrollPhysics(),
      itemCount: steps.length,
      itemBuilder: (context, index) {
        final bool nextStepExists = index < (steps.length - 1);
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Dashed Line and Circle
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // Circle
                Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    color: index == 0 ? Colors.blue : AppColors.lightCurrentUserChatColor,
                    shape: BoxShape.circle,
                  ),
                ),
                if (nextStepExists)
                  SizedBox(
                    height: showCar ? 180 : 70,
                    child: CustomPaint(
                      painter: DashedLinePainter(color: AppColors.lightCurrentUserChatColor),
                    ),
                  ),
              ],
            ).paddingOnly(top: 3, right: 16),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SmallText(
                    text: steps[index].title ?? 'N/A',
                    textColor: index == 0 ? AppColors.lightStartColor : AppColors.lightCurrentUserChatColor,
                    fontWeight: FontWeight.w600,
                  ).paddingOnly(bottom: 8),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CachedNetworkImage(
                        imageUrl: steps[index].imageUrl ?? '',
                        height: 24,
                        width: 24,
                        fit: BoxFit.fitHeight,
                        placeholder: (context, url) => const ImagePlaceholderWidget(height: 24, width: 24),
                        errorWidget: (context, url, error) => const ImagePlaceholderWidget(height: 24, width: 24),
                      ).paddingOnly(right: 10),
                      Expanded(
                        child: BodyText(
                          text: steps[index].contentText ?? 'N/A',
                          fontWeight: FontWeight.w700,
                          maxLine: 2,
                        ),
                      ),
                    ],
                  ),
                  if (showCar)
                    SvgPicture.asset(
                      Assets.assetsSvgDriverSide,
                      height: 60,
                    ).paddingOnly(top: 10)
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  // Simulate content height calculation
  // double _calculateContentHeight(String content) {
  //   int lineCount = '\n'.allMatches(content).length + 1;
  //   return (lineCount * 70.0); // Assume 16 px per line for text height
  // }
}
