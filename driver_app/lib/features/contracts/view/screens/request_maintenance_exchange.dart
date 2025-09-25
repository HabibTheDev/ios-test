import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constants/app_color.dart';
import '../../../../core/constants/app_list.dart';
import '../../../../core/constants/arguments_key.dart';
import '../../../../core/router/router_paths.dart';
import '../../../../shared/widgets/appbar_leading_icon.dart';
import '../../../../shared/widgets/text_widget.dart';
import '../widgets/exchange_request_widget.dart';
import '../widgets/maintenance_request_widget.dart';

class RequestMaintenanceExchange extends StatefulWidget {
  const RequestMaintenanceExchange({super.key});

  @override
  State<RequestMaintenanceExchange> createState() =>
      _RequestMaintenanceExchangeState();
}

class _RequestMaintenanceExchangeState extends State<RequestMaintenanceExchange>
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
    final returnScreen = Get.arguments?[ArgumentsKey.returnScreen];
    return Scaffold(
      appBar: AppBar(
        leading: AppBarLeadingIcon(
          onTap: () {
            if (returnScreen != null) {
              Get.until((route) => route.settings.name == returnScreen);
            } else {
              Get.until((route) =>
                  route.settings.name == RouterPaths.contractDetails);
            }
          },
        ),
        centerTitle: false,
        title: const ButtonText(
          text: 'Request',
          textColor: AppColors.lightAppBarIconColor,
        ),
        titleSpacing: 0,
        actions: [
          IconButton(
            onPressed: () => Get.toNamed(RouterPaths.requestHistory),
            icon: const Icon(
              Icons.history,
              color: AppColors.lightAppBarIconColor,
            ),
          )
        ],
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
          children: const [
            MaintenanceRequestWidget(),
            ExchangeRequestWidget(),
          ],
        ),
      ),
    );
  }
}
