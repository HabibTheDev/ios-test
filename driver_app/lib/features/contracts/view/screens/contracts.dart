import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../core/constants/app_color.dart';
import '../../../../core/constants/app_list.dart';
import '../../../../core/constants/arguments_key.dart';
import '../../../../core/router/router_paths.dart';
import '../../../../shared/widgets/app_bottom_sheet.dart';
import '../../../../shared/widgets/card_widget.dart';
import '../../../../shared/widgets/header_widget.dart';
import '../../../../shared/widgets/heightbox.dart';
import '../../../../shared/widgets/loading_widget.dart';
import '../../../../shared/widgets/text_widget.dart';
import '../../controller/contracts_controller.dart';
import '../tiles/active_contract_tile.dart';
import '../tiles/canceled_contract_tile.dart';
import '../tiles/contract_overview_tile.dart';
import '../tiles/total_driven_tile.dart';
import '../tiles/total_extra_mileage_tile.dart';
import '../widgets/contract_filter_widget.dart';

class Contracts extends StatefulWidget {
  const Contracts({super.key});

  @override
  State<Contracts> createState() => _ContractsState();
}

class _ContractsState extends State<Contracts> with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(
      length: AppList.contractType.length,
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    final contractPageController = PageController(viewportFraction: 1);
    return GetBuilder<ContractsController>(
      init: ContractsController(),
      autoRemove: false,
      builder: (controller) {
        return Obx(
          () => controller.isLoading.value
              ? const CenterLoadingWidget()
              : ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    // title
                    const HeaderWidget(title: 'Contract').paddingOnly(bottom: 16),

                    // Header
                    CardWidget(
                      height: 296.h,
                      child: Column(
                        children: [
                          Expanded(
                            child: PageView(
                              controller: contractPageController,
                              scrollDirection: Axis.horizontal,
                              pageSnapping: true,
                              children: const [ContractOverviewTile(), TotalDrivenTile(), TotalExtraMileageTile()],
                            ),
                          ),
                          // Dot indicator
                          Center(
                            child: SmoothPageIndicator(
                              controller: contractPageController,
                              count: 3,
                              effect: const WormEffect(
                                spacing: 6,
                                radius: 3,
                                dotWidth: 6,
                                dotHeight: 6,
                                paintStyle: PaintingStyle.fill,
                                dotColor: AppColors.lightCurrentUserChatColor,
                                activeDotColor: AppColors.primaryColor,
                              ),
                            ),
                          ).paddingOnly(bottom: 16),
                        ],
                      ),
                    ).paddingOnly(bottom: 12),

                    // Active Canceled contract
                    CardWidget(
                      contentPadding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          // Tab bar
                          TabBar(
                            controller: tabController,
                            tabs: AppList.contractType.map((item) => Tab(text: item)).toList(),
                            padding: EdgeInsets.zero,
                            indicatorSize: TabBarIndicatorSize.tab,
                            dividerHeight: 1,
                            onTap: (value) {
                              setState(() {});
                            },
                            indicatorColor: AppColors.primaryColor,
                            dividerColor: AppColors.lightCurrentUserChatColor,
                          ).paddingOnly(bottom: 20),

                          // Search & Filter Widget
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                  child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  BodyText(
                                    text: '${AppList.contractType[tabController.index]} contracts',
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
                                        RouterPaths.searchContract,
                                        arguments: {
                                          ArgumentsKey.contractType: AppList.contractType[tabController.index]
                                        },
                                      ),
                                  icon: const Icon(
                                    Icons.search,
                                    color: AppColors.lightSecondaryTextColor,
                                    size: 20,
                                  )),
                              // Filter button
                              IconButton(
                                  onPressed: () {
                                    modalBottomSheet(
                                      context: context,
                                      title: 'Filter Contracts',
                                      child: ContractFilterWidget(controller: controller),
                                    );
                                  },
                                  icon: const Icon(
                                    Icons.filter_list_rounded,
                                    color: AppColors.lightSecondaryTextColor,
                                    size: 20,
                                  )),
                            ],
                          ).paddingOnly(bottom: 24),

                          // Contract List
                          tabController.index == 0
                              ? ListView.separated(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: 5,
                                  separatorBuilder: (context, index) => const HeightBox(height: 12),
                                  itemBuilder: (context, index) => const ActiveContractTile(),
                                )
                              : ListView.separated(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: 5,
                                  separatorBuilder: (context, index) => const HeightBox(height: 12),
                                  itemBuilder: (context, index) => const CanceledContractTile(),
                                ),
                        ],
                      ),
                    )
                  ],
                ),
        );
      },
    );
  }
}
