import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constants/arguments_key.dart';
import '../../../../core/router/router_paths.dart';
import '../../../../core/constants/app_color.dart';
import '../../../../shared/utils/app_toast.dart';
import '../../../../shared/widgets/app_divider.dart';
import '../../../../shared/widgets/appbar_leading_icon.dart';
import '../../../../shared/widgets/heightbox.dart';
import '../../../../shared/widgets/loading_widget.dart';
import '../../../../shared/widgets/solid_text_button.dart';
import '../../../../shared/widgets/text_widget.dart';
import '../../controller/car_details_controller.dart';
import '../tiles/fees_and_deposit_tile.dart';
import '../tiles/review_tile.dart';
import '../widgets/explore_car_details_widget.dart';
import '../widgets/faq_expandable_widget.dart';

class CarDetails extends StatefulWidget {
  const CarDetails({super.key});

  @override
  State<CarDetails> createState() => _CarDetailsState();
}

class _CarDetailsState extends State<CarDetails> {
  late CarDetailsController controller;
  late int id;

  @override
  void initState() {
    super.initState();
    controller = Get.find();
    id = Get.arguments?[ArgumentsKey.id] ?? 1;
    controller.initializeData(id: id);
    debugPrint('Id: $id');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightCardColor,
      appBar: AppBar(
        leading: const AppBarLeadingIcon(),
        centerTitle: false,
        title: const ButtonText(
          text: 'Car Details',
          textColor: AppColors.lightAppBarIconColor,
        ),
        titleSpacing: 0.0,
      ),
      body: Obx(() => controller.isLoading.value ? const CenterLoadingWidget() : _bodyUI()),
      bottomNavigationBar: SafeArea(
        child: SolidTextButton(
                onTap: () {
                  if (controller.carDetailsModel.value?.catalogue?.id == null) {
                    showToast('Car not found');
                    return;
                  }
                  Get.toNamed(RouterPaths.mileageAndProtection);
                },
                buttonText: 'Checkout with this car')
            .paddingSymmetric(horizontal: 16),
      ),
    );
  }

  Widget _bodyUI() => ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Car Details
          if (controller.carDetailsModel.value != null)
            ExploreCarDetailsWidget(carDetailsModel: controller.carDetailsModel.value!),

          // Fees & Deposit
          if (controller.carDetailsModel.value?.catalogue?.feesAndDeposit != null)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TitleText(text: 'Fees & Deposit', textSize: 18).paddingOnly(bottom: 16),
                FeesAndDepositTile(
                  leadingIcon: Icons.paid,
                  titleText: 'Deposit fees',
                  subTitleText:
                      'Security deposit - \$${controller.carDetailsModel.value?.catalogue?.feesAndDeposit?.securityDeposit ?? 0.0}',
                  trailingText:
                      '${controller.carDetailsModel.value?.catalogue?.feesAndDeposit?.securityDeposit ?? 0.0}',
                ).paddingOnly(bottom: 5),
                if (controller.carDetailsModel.value?.catalogue?.feesAndDeposit?.isEnrollmentFee == true)
                  FeesAndDepositTile(
                    leadingIcon: Icons.how_to_reg,
                    titleText: 'Enrollment fee',
                    trailingText: '${controller.carDetailsModel.value?.catalogue?.feesAndDeposit?.totalFee ?? 0.0}',
                  ).paddingOnly(bottom: 5),
                if (controller.carDetailsModel.value?.catalogue?.feesAndDeposit?.isCanceletaionFee == true)
                  FeesAndDepositTile(
                    leadingIcon: Icons.article,
                    titleText: 'Cancelation fee',
                    subTitleText: 'If cancel before 60 days',
                    trailingText:
                        '${controller.carDetailsModel.value?.catalogue?.feesAndDeposit?.totalCancelFee ?? 0.0}',
                  ).paddingOnly(bottom: 10),
                const AppDivider().paddingSymmetric(vertical: 20),
              ],
            ),

          // Customer Review
          if (controller.carDetailsModel.value?.catalogue?.customerFeedbacks != null) ...{
            const TitleText(text: 'Customer review', textSize: 18),
            ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.only(top: 20),
                addAutomaticKeepAlives: false,
                itemBuilder: (context, index) =>
                    ReviewTile(model: controller.carDetailsModel.value!.catalogue!.customerFeedbacks![index]),
                separatorBuilder: (context, index) => const HeightBox(height: 10),
                itemCount: controller.carDetailsModel.value!.catalogue!.customerFeedbacks!.length),
            const AppDivider().paddingSymmetric(vertical: 20),
          },

          // Frequently asked questions
          if (controller.carDetailsModel.value?.faqSection?.faqQuestions != null) ...{
            const TitleText(text: 'Frequently asked questions', textSize: 18),
            ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.only(top: 20),
                addAutomaticKeepAlives: false,
                itemBuilder: (context, index) => FaqExpandableWidget(
                      question: controller.carDetailsModel.value!.faqSection!.faqQuestions![index].question!,
                      answer: controller.carDetailsModel.value!.faqSection!.faqQuestions![index].answer!,
                    ),
                separatorBuilder: (context, index) => const HeightBox(height: 10),
                itemCount: controller.carDetailsModel.value!.faqSection!.faqQuestions!.length),
          },
        ],
      );
}
