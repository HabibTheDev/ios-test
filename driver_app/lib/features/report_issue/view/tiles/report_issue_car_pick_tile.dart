import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_utils/get_utils.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_color.dart';
import '../../../../shared/widgets/text_widget.dart';

class ReportIssueCarPickTile extends StatelessWidget {
  const ReportIssueCarPickTile({super.key, required this.index});
  final int index;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          decoration: BoxDecoration(
              color: AppColors.lightCardColor,
              borderRadius: const BorderRadius.all(Radius.circular(6)),
              border: index == 1 ? Border.all(color: AppColors.primaryColor) : null,
              boxShadow: [BoxShadow(color: Colors.grey.shade200, blurRadius: 8, offset: const Offset(1, 4))]),
          child: Row(
            children: [
              Expanded(
                  flex: 3,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 20,
                        child: Icon(
                          Icons.fire_truck_rounded,
                          color: AppColors.lightSecondaryTextColor.withOpacity(0.5),
                          size: 30,
                        ),
                      ),
                      Expanded(
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            BodyText(
                              text: 'Lemborghini',
                              fontWeight: FontWeight.bold,
                            ),
                            SmallText(
                              text: 'Gallardo 2022',
                              textColor: AppColors.lightSecondaryTextColor,
                              textSize: 10,
                            ),
                          ],
                        ).paddingOnly(left: 8),
                      )
                    ],
                  ).paddingOnly(left: 12, top: 12, bottom: 12)),
              Expanded(
                flex: 2,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Positioned(
                      right: -80,
                      top: 0,
                      bottom: 0,
                      child: SvgPicture.asset(
                        Assets.assetsSvgDriverSide,
                        height: 72,
                      ),
                    ),
                    const SizedBox(height: 96)
                  ],
                ),
              )
            ],
          ),
        ),
        if (index == 1)
          const Positioned(
              top: -5,
              right: -5,
              child: CircleAvatar(
                radius: 9,
                backgroundColor: AppColors.primaryColor,
                child: Icon(
                  Icons.check,
                  size: 14,
                  color: Colors.white,
                ),
              ))
      ],
    );
  }
}
