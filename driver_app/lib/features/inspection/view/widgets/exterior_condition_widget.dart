import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_color.dart';
import '../../../../shared/widgets/app_divider.dart';
import '../../../../shared/widgets/text_widget.dart';

class ExteriorConditionWidget extends StatelessWidget {
  const ExteriorConditionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Overview
        Row(
          children: [
            // Circle bar
            Stack(
              alignment: Alignment.center,
              children: [
                const SizedBox(
                  height: 124,
                  width: 124,
                  child: CircularProgressIndicator(
                    color: AppColors.contractColor,
                    value: 0.8,
                    strokeWidth: 10,
                    strokeCap: StrokeCap.round,
                    backgroundColor: Colors.black12,
                  ),
                ),

                // Overall
                Column(
                  children: [
                    RichText(
                      text: const TextSpan(
                        style: TextStyle(color: AppColors.lightTextColor, fontSize: 14),
                        children: [
                          TextSpan(
                            text: '8',
                            style: TextStyle(fontSize: 32, fontWeight: FontWeight.w600),
                          ),
                          TextSpan(text: '/0'),
                        ],
                      ),
                    ),
                    const SmallText(text: 'Overall')
                  ],
                ),
              ],
            ).paddingOnly(right: 20),

            // Details
            Expanded(
              child: Column(
                children: [
                  _itemTile(title: 'Total parts detected', value: '63'),
                  const AppDivider(height: 10),
                  _itemTile(title: 'Damages found', value: '30', subTitle: '10 New'),
                  const AppDivider(height: 10),
                  _itemTile(title: 'MIssing parts', value: '0'),
                ],
              ),
            )
          ],
        ).paddingOnly(right: 20),

        // Damage indication
        SvgPicture.asset(
          Assets.assetsSvgCarDamageDiagram,
          fit: BoxFit.fitWidth,
        )
      ],
    );
  }

  _itemTile({required String title, required String value, String? subTitle}) => Row(children: [
        SmallText(
          text: title,
          textColor: AppColors.lightSecondaryTextColor,
          fontWeight: FontWeight.w600,
        ),
        Expanded(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SmallText(
              text: value,
              fontWeight: FontWeight.w700,
            ),
            if (subTitle != null)
              SmallText(
                text: "\u2191 $subTitle",
                textColor: Colors.red,
              )
          ],
        ))
      ]);
}
