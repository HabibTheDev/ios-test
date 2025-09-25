import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constants/app_color.dart';
import '../../../../shared/widgets/text_widget.dart';
import '../../model/contract_overview_model.dart';
import 'contract_overview_grid_tile.dart';

class ContractOverviewTile extends StatelessWidget {
  const ContractOverviewTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TitleText(
          text: r'$31,587',
          textSize: 24,
          fontWeight: FontWeight.w700,
        ),
        const SmallText(
          text: 'Total paid',
          textColor: AppColors.lightSecondaryTextColor,
        ).paddingOnly(bottom: 16),
        Expanded(
          child: GridView.builder(
            padding: const EdgeInsets.only(bottom: 12),
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 5,
                mainAxisSpacing: 5,
                childAspectRatio: 2.7),
            itemCount: ContractOverviewModel.list.length,
            itemBuilder: (context, index) => ContractOverviewGridTile(
              title: ContractOverviewModel.list[index].value,
              subTitle: ContractOverviewModel.list[index].title,
            ),
          ),
        )
      ],
    ).paddingAll(16);
  }
}
