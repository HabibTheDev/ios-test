import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_color.dart';
import '../../../../core/constants/app_list.dart';
import '../../../../core/constants/arguments_key.dart';
import '../../../../shared/widgets/appbar_leading_icon.dart';
import '../../../../shared/widgets/empty_content_widget.dart';
import '../../../../shared/widgets/heightbox.dart';
import '../../../../shared/widgets/search_field.dart';
import '../../../../shared/widgets/text_widget.dart';
import '../../../../shared/widgets/widthbox.dart';
import '../../controller/search_financial_history_controller.dart';
import '../tiles/payment_tile.dart';
import '../tiles/refund_tile.dart';

class SearchFinancialHistory extends StatelessWidget {
  const SearchFinancialHistory({super.key});

  @override
  Widget build(BuildContext context) {
    final SearchFinancialHistoryController controller = Get.find();
    final String financeType =
        Get.arguments?[ArgumentsKey.contractDetailsFinanceType] ?? AppList.contractDetailsFinanceType.first;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: const AppBarLeadingIcon(),
        titleSpacing: -8,
        title: SearchField(
          onChanged: (value) {
            controller.searchKey.value = value;
          },
          hintText: 'Search ${financeType.toLowerCase()} by',
        ),
        centerTitle: false,
        actions: const [WidthBox(width: 24)],
      ),
      body: SafeArea(
        child: Obx(
          () => controller.searchKey.value == null || controller.searchKey.value!.isEmpty
              ? EmptyContentWidget(
                  title: 'Search ${financeType.toLowerCase()}',
                  subTitle: 'Enter something to find the specific ${financeType.toLowerCase()}.',
                  svgAsset: Assets.assetsSvgSearch,
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header
                    Container(
                      color: AppColors.lightBgColor,
                      child: const Row(
                        children: [
                          Icon(Icons.search, size: 20, color: AppColors.lightTextColor),
                          TitleText(text: ' 05 items found', textSize: 16),
                        ],
                      ),
                    ).paddingOnly(left: 16, right: 16, top: 20, bottom: 20),

                    // Finance history
                    Expanded(
                      child: financeType == AppList.contractDetailsFinanceType.first
                          ? ListView.separated(
                              padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                              itemCount: 5,
                              separatorBuilder: (context, index) => const HeightBox(height: 12),
                              itemBuilder: (context, index) => PaymentTile(index: index),
                            )
                          : ListView.separated(
                              padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                              itemCount: 5,
                              separatorBuilder: (context, index) => const HeightBox(height: 12),
                              itemBuilder: (context, index) => const RefundTile(),
                            ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
