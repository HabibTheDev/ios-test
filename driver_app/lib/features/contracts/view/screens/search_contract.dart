import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
import '../../controller/search_contract_controller.dart';
import '../tiles/active_contract_tile.dart';
import '../tiles/canceled_contract_tile.dart';

class SearchContract extends StatelessWidget {
  const SearchContract({super.key});

  @override
  Widget build(BuildContext context) {
    final SearchContractController controller = Get.find();
    final String contractType = Get.arguments?[ArgumentsKey.contractType] ?? AppList.contractType.first;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: const AppBarLeadingIcon(),
        titleSpacing: -8,
        title: SearchField(
          onChanged: (value) {
            controller.searchKey.value = value;
          },
          hintText: 'Search contract',
        ),
        centerTitle: false,
        actions: const [WidthBox(width: 24)],
      ),
      body: SafeArea(
        child: Obx(
          () => controller.searchKey.value == null || controller.searchKey.value!.isEmpty
              ? EmptyContentWidget(
                  title: 'Search ${contractType.toLowerCase()} contract',
                  subTitle: 'Enter your contract Id to find the specific contract.',
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
                    ).paddingOnly(left: 16, right: 16, top: 20.h, bottom: 20),

                    // Vehicles
                    Expanded(
                      child: // Contract List
                          contractType == AppList.contractType.first
                              ? ListView.separated(
                                  padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                                  itemCount: 5,
                                  separatorBuilder: (context, index) => const HeightBox(height: 12),
                                  itemBuilder: (context, index) => const ActiveContractTile(),
                                )
                              : ListView.separated(
                                  padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                                  itemCount: 5,
                                  separatorBuilder: (context, index) => const HeightBox(height: 12),
                                  itemBuilder: (context, index) => const CanceledContractTile(),
                                ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
