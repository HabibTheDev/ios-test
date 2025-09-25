import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../../../../shared/widgets/text_widget.dart';
import '../tiles/overview_summery_tile.dart';

class OverviewSummeryWidget extends StatelessWidget {
  const OverviewSummeryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const OverviewSummeryTile(title: 'Subscription fee', value: '\$150'),
        const OverviewSummeryTile(title: 'Damage protection', value: '\$150'),
        const OverviewSummeryTile(
            title: 'Additional drivers: 02', value: '\$30'),
        const OverviewSummeryTile(title: 'Infant seat: 01', value: '\$15'),
        const OverviewSummeryTile(title: 'Toddler seat: 01', value: '\$15'),
        const OverviewSummeryTile(title: 'Booster seat: 01', value: '\$15')
            .paddingOnly(bottom: 20),
        // Total
        const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TitleText(
                text: 'Total',
                textSize: 16,
              ),
              TitleText(
                text: '\$2000',
                textSize: 24,
                fontWeight: FontWeight.w700,
              )
            ]).paddingOnly(bottom: 32),
      ],
    );
  }
}
