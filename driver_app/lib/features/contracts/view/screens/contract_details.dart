import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../core/constants/app_color.dart';
import '../../../../core/constants/app_list.dart';
import '../../../../core/constants/arguments_key.dart';
import '../../../../shared/widgets/app_bottom_sheet.dart';
import '../../../../shared/widgets/appbar_leading_icon.dart';
import '../../../../shared/widgets/loading_widget.dart';
import '../../../../shared/widgets/solid_text_button.dart';
import '../../../../shared/widgets/text_widget.dart';
import '../../controller/contract_details_controller.dart';
import '../widgets/contract_action_widget.dart';
import '../widgets/financial_contract_details.dart';
import '../widgets/overview_contract_details.dart';
import '../widgets/vehicle_contract_details.dart';

class ContractDetails extends StatefulWidget {
  const ContractDetails({super.key});

  @override
  State<ContractDetails> createState() => _ContractDetailsState();
}

class _ContractDetailsState extends State<ContractDetails> with SingleTickerProviderStateMixin {
  late TabController tabController;
  late ContractDetailsController controller;
  late int? contractId;

  @override
  void initState() {
    super.initState();
    tabController = TabController(
      length: AppList.contractDetailsTabs.length,
      vsync: this,
    );
    controller = Get.find();
    contractId = Get.arguments?[ArgumentsKey.contractId];
    // Get Contract Details
    WidgetsBinding.instance.addPostFrameCallback((value) => controller.getContractDetails(contractId: contractId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const AppBarLeadingIcon(),
        centerTitle: false,
        title: const ButtonText(
          text: 'Contract details',
          textColor: AppColors.lightAppBarIconColor,
        ),
        titleSpacing: 0.0,
        // Tab Bar
        bottom: PreferredSize(
            preferredSize: const Size.fromHeight(44),
            child: TabBar(
              controller: tabController,
              tabs: AppList.contractDetailsTabs
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
      body: Obx(
        () => controller.isLoading.value
            ? const CenterLoadingWidget()
            : TabBarView(
                controller: tabController,
                children: const [OverviewContractDetails(), VehicleContractDetails(), FinancialContractDetails()],
              ),
      ),
      bottomNavigationBar: SafeArea(
        child: SolidTextButton(
                onTap: () {
                  modalBottomSheet(
                    height: 288.h,
                    context: context,
                    child: const ContractActionWidget(),
                  );
                },
                buttonText: 'Action')
            .paddingSymmetric(horizontal: 20),
      ),
    );
  }
}
