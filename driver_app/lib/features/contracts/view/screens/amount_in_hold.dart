import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constants/app_color.dart';
import '../../../../shared/tiles/secondary_info_tile.dart';
import '../../../../shared/widgets/appbar_leading_icon.dart';
import '../../../../shared/widgets/card_widget.dart';
import '../../../../shared/widgets/heightbox.dart';
import '../../../../shared/widgets/text_widget.dart';

class AmountInHold extends StatelessWidget {
  const AmountInHold({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const AppBarLeadingIcon(),
        centerTitle: false,
        title: const ButtonText(
          text: 'Amount in hold',
          textColor: AppColors.lightAppBarIconColor,
        ),
        titleSpacing: 0.0,
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SmallText(
              text: 'Total in hold',
              textColor: AppColors.lightSecondaryTextColor,
            ).paddingOnly(left: 16, right: 16, top: 16),
            const TitleText(
              text: r'$1,000',
              textColor: AppColors.lightSecondaryTextColor,
            ).paddingOnly(left: 16, right: 16, bottom: 20),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: 5,
                separatorBuilder: (context, index) =>
                    const HeightBox(height: 16),
                itemBuilder: (context, index) => CardWidget(
                    contentPadding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const TitleText(text: 'Security deposit')
                            .paddingOnly(bottom: 10),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SecondaryInfoTile(
                                    leadingIcon: Icons.local_atm,
                                    title: 'Bank transfer',
                                    iconSize: 18,
                                  ).paddingOnly(bottom: 4),
                                  const SecondaryInfoTile(
                                    leadingIcon: Icons.calendar_month_outlined,
                                    title: '11 Mar 2023',
                                    iconSize: 18,
                                  ),
                                ],
                              ),
                            ),
                            RichText(
                              textAlign: TextAlign.start,
                              text: const TextSpan(
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.lightSecondaryTextColor),
                                children: [
                                  TextSpan(text: '1000'),
                                  TextSpan(
                                      text: r'$',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 10,
                                      )),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
