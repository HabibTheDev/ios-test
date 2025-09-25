import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constants/app_color.dart';
import '../../../../core/constants/app_list.dart';
import '../../../../shared/widgets/appbar_leading_icon.dart';
import '../../../../shared/widgets/header_widget.dart';
import '../../../../shared/widgets/heightbox.dart';
import '../../../../shared/widgets/text_widget.dart';
import '../tiles/inspection_car_tile.dart';

class AllInspections extends StatefulWidget {
  const AllInspections({super.key});

  @override
  State<AllInspections> createState() => _AllInspectionsState();
}

class _AllInspectionsState extends State<AllInspections>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(
      length: AppList.inspectionTypeTabs.length,
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
          text: 'All inspections',
          textColor: AppColors.lightAppBarIconColor,
        ),
        titleSpacing: 0.0,
        // Tab Bar
        bottom: PreferredSize(
            preferredSize: const Size.fromHeight(44),
            child: TabBar(
              controller: tabController,
              tabs: AppList.inspectionTypeTabs
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
          children: [
            _departureList(),
            _returnList(),
          ],
        ),
      ),
    );
  }

  Widget _departureList() => Column(
        children: [
          const HeaderWidget(title: 'Departure inspections').paddingAll(16),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
              itemCount: 5,
              separatorBuilder: (context, index) => const HeightBox(height: 12),
              itemBuilder: (context, index) => const InspectionCarTile(),
            ),
          ),
        ],
      );
  Widget _returnList() => Column(
        children: [
          const HeaderWidget(title: 'Return inspections').paddingAll(16),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
              itemCount: 5,
              separatorBuilder: (context, index) => const HeightBox(height: 12),
              itemBuilder: (context, index) => const InspectionCarTile(),
            ),
          ),
        ],
      );
}
