import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import '../../../../core/constants/app_color.dart';
import '../../../../shared/widgets/text_widget.dart';
import '../tiles/collision_report_item_tile.dart';

class InspectionDetailsWidget extends StatelessWidget {
  const InspectionDetailsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const BodyText(
          text: 'Inspection details',
          fontWeight: FontWeight.w700,
          textColor: AppColors.lightSecondaryTextColor,
        ).paddingOnly(bottom: 16),

        //Date
        const CollisionReportItemTile(
            title: 'Date:',
            child: SmallText(
              text: '12 Sep 2023',
              fontWeight: FontWeight.w500,
            )),
        //Time
        const CollisionReportItemTile(
            title: 'Time:',
            child: SmallText(
              text: '12:30 PM',
              fontWeight: FontWeight.w500,
            )),

        //Inspected by
        CollisionReportItemTile(
            title: 'Inspected by:',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SmallText(
                  text: 'Danish Ali',
                  fontWeight: FontWeight.w600,
                ).paddingOnly(bottom: 6),
                const ExtraSmallText(
                  text: '(219)63854-0965',
                  textColor: AppColors.lightSecondaryTextColor,
                ),
                const ExtraSmallText(
                  text: 'dasnish@gmail.com',
                  textColor: AppColors.lightSecondaryTextColor,
                ),
                const ExtraSmallText(
                  text: '23/6 Dire streets, Vancuber, CA',
                  textColor: AppColors.lightSecondaryTextColor,
                ),
              ],
            )),
      ],
    );
  }
}
