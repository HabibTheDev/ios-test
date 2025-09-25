import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import '../../../../core/constants/app_color.dart';
import '../../../../shared/widgets/text_widget.dart';
import '../tiles/collision_report_item_tile.dart';

class AccidentInformationWidget extends StatelessWidget {
  const AccidentInformationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const BodyText(
          text: 'Accident information',
          fontWeight: FontWeight.w700,
          textColor: AppColors.lightSecondaryTextColor,
        ).paddingOnly(bottom: 16),

        //Location
        CollisionReportItemTile(
            title: 'Location:',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SmallText(
                  text: '22/7 Dire streets, Vancuber, CA',
                  fontWeight: FontWeight.w600,
                ).paddingOnly(bottom: 8),
                const Row(
                  children: [
                    Expanded(
                      child: ExtraSmallText(
                        text: '39.63854845965',
                        fontWeight: FontWeight.w600,
                        textColor: AppColors.lightSecondaryTextColor,
                      ),
                    ),
                    ExtraSmallText(
                      text: ' (Latitude)',
                      textColor: AppColors.lightTextFieldHintColor,
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
                const Row(
                  children: [
                    Expanded(
                      child: ExtraSmallText(
                        text: '-106.93836583729',
                        fontWeight: FontWeight.w600,
                        textColor: AppColors.lightSecondaryTextColor,
                      ),
                    ),
                    ExtraSmallText(
                      text: '(Longitude)',
                      textColor: AppColors.lightTextFieldHintColor,
                    ),
                  ],
                ),
              ],
            )),

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
        //Party
        const CollisionReportItemTile(
            title: 'Is there any other party involved?',
            child: SmallText(
              text: 'NO',
              fontWeight: FontWeight.w500,
            )),
        //Descrtiption
        const CollisionReportItemTile(
            title: 'Descrtiption',
            child: SmallText(
              text: 'This is a dummy text to show how it will look like.',
              fontWeight: FontWeight.w500,
            )),
      ],
    );
  }
}
