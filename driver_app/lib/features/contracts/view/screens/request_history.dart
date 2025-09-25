import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constants/app_color.dart';
import '../../../../core/constants/app_list.dart';
import '../../../../shared/widgets/appbar_leading_icon.dart';
import '../../../../shared/widgets/header_widget.dart';
import '../../../../shared/widgets/heightbox.dart';
import '../../../../shared/widgets/text_widget.dart';
import '../../model/exchange_history_model.dart';
import '../tiles/maintenance_history_tile.dart';
import '../widgets/exchange_history_stepper.dart';

class RequestHistory extends StatefulWidget {
  const RequestHistory({super.key});

  @override
  State<RequestHistory> createState() => _RequestHistoryState();
}

class _RequestHistoryState extends State<RequestHistory>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(
      length: AppList.requestTypeTabs.length,
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const AppBarLeadingIcon(),
        centerTitle: false,
        title: const ButtonText(
          text: 'Request history',
          textColor: AppColors.lightAppBarIconColor,
        ),
        titleSpacing: 0.0,
        // Tab Bar
        bottom: PreferredSize(
            preferredSize: const Size.fromHeight(44),
            child: TabBar(
              controller: tabController,
              tabs: AppList.requestTypeTabs
                  .map((item) => Tab(
                          child: SmallText(
                        text: item,
                        textColor: AppColors.lightAppBarIconColor,
                        fontWeight: FontWeight.w600,
                      )))
                  .toList(),
              padding: EdgeInsets.zero,
              indicatorSize: TabBarIndicatorSize.tab,
              dividerHeight: 0,
              indicatorColor: AppColors.lightAppBarIconColor,
              dividerColor: Colors.transparent,
            ).paddingOnly(bottom: 4, left: 16, right: 16)),
      ),
      body: SafeArea(
        child: TabBarView(
          controller: tabController,
          children: [_maintenanceWidget(), _exchangeWidget()],
        ),
      ),
    );
  }

  Widget _maintenanceWidget() => Column(
        children: [
          const HeaderWidget(title: 'All maintenances')
              .paddingOnly(left: 16, right: 16, top: 16),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: 3,
              separatorBuilder: (context, index) => const HeightBox(height: 10),
              itemBuilder: (context, index) => const MaintenanceHistoryTile(),
            ),
          ),
        ],
      );

  Widget _exchangeWidget() => Container(
        color: AppColors.lightCardColor,
        child: Column(
          children: [
            const HeaderWidget(title: 'All exchanges')
                .paddingOnly(left: 16, right: 16, top: 16),
            Expanded(
              child: ExchangeHistoryStepper(
                steps: ExchangeHistoryModel.list,
                showCar: true,
              ).paddingAll(16),
            ),
          ],
        ),
      );
}
