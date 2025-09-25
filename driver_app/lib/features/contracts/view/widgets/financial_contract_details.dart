import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constants/app_color.dart';
import '../../../../core/constants/app_list.dart';
import '../../../../core/constants/arguments_key.dart';
import '../../../../core/router/router_paths.dart';
import '../../../../shared/tiles/three_item_info_tile.dart';
import '../../../../shared/widgets/card_widget.dart';
import '../../../../shared/widgets/header_widget.dart';
import '../../../../shared/widgets/heightbox.dart';
import '../../../../shared/widgets/text_widget.dart';
import '../../model/financial_details_model.dart';
import '../tiles/contract_overview_grid_tile.dart';
import '../tiles/payment_tile.dart';
import '../tiles/refund_tile.dart';

class FinancialContractDetails extends StatefulWidget {
  const FinancialContractDetails({super.key});

  @override
  State<FinancialContractDetails> createState() =>
      _FinancialContractDetailsState();
}

class _FinancialContractDetailsState extends State<FinancialContractDetails>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(
      length: AppList.contractDetailsFinanceType.length,
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // Financial
        const HeaderWidget(title: 'Financial').paddingOnly(bottom: 16),

        CardWidget(
          contentPadding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
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

              // Financial Grid
              GridView.builder(
                padding: const EdgeInsets.only(bottom: 16),
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 5,
                    childAspectRatio: 2.7),
                itemCount: FinancialDetailsModel.list.length,
                itemBuilder: (context, index) => ContractOverviewGridTile(
                  title: FinancialDetailsModel.list[index].value,
                  subTitle: FinancialDetailsModel.list[index].title,
                ),
              ),
              const ThreeItemInfoTile(
                leadingText: 'Billing cycle',
                titleText: 'Monthly',
              ).paddingOnly(bottom: 5),
              const ThreeItemInfoTile(
                leadingText: 'Next billing date',
                titleText: '11 Mar 2023',
                trailingText: '(21 days left)',
              ).paddingOnly(bottom: 10),

              // View in hold
              TextButton(
                onPressed: () => Get.toNamed(RouterPaths.amountInHold),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ButtonText(
                      text: 'View in hold ',
                      textColor: AppColors.primaryColor,
                    ),
                    Icon(Icons.arrow_forward_outlined, size: 18),
                  ],
                ),
              )
            ],
          ),
        ).paddingOnly(bottom: 12),

        CardWidget(
            contentPadding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // Tab bar
                TabBar(
                  controller: tabController,
                  tabs: AppList.contractDetailsFinanceType
                      .map((item) => Tab(text: item))
                      .toList(),
                  padding: EdgeInsets.zero,
                  indicatorSize: TabBarIndicatorSize.tab,
                  dividerHeight: 1,
                  onTap: (value) {
                    setState(() {});
                  },
                  indicatorColor: AppColors.primaryColor,
                  dividerColor: AppColors.lightCurrentUserChatColor,
                ).paddingOnly(bottom: 20),

                // Search Widget
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        BodyText(
                          text:
                              'All ${AppList.contractDetailsFinanceType[tabController.index]}',
                          textColor: AppColors.lightSecondaryTextColor,
                          fontWeight: FontWeight.w700,
                        ),
                        const ExtraSmallText(
                          text: '03 items',
                          textColor: AppColors.lightSecondaryTextColor,
                        )
                      ],
                    )),
                    // Search button
                    IconButton(
                        onPressed: () => Get.toNamed(
                              RouterPaths.searchFinancialHistory,
                              arguments: {
                                ArgumentsKey.contractDetailsFinanceType:
                                    AppList.contractDetailsFinanceType[
                                        tabController.index]
                              },
                            ),
                        icon: const Icon(
                          Icons.search,
                          color: AppColors.lightSecondaryTextColor,
                          size: 20,
                        )),
                  ],
                ).paddingOnly(bottom: 24),

                tabController.index == 0
                    ? ListView.separated(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: 5,
                        separatorBuilder: (context, index) =>
                            const HeightBox(height: 12),
                        itemBuilder: (context, index) =>
                            PaymentTile(index: index),
                      )
                    : ListView.separated(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: 5,
                        separatorBuilder: (context, index) =>
                            const HeightBox(height: 12),
                        itemBuilder: (context, index) => const RefundTile(),
                      ),
              ],
            ))
      ],
    );
  }
}
