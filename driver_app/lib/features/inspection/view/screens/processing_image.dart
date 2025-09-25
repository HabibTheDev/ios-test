import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_color.dart';
import '../../../../core/constants/arguments_key.dart';
import '../../../../core/router/router_paths.dart';
import '../../../../shared/services/local/orientation_service.dart';
import '../../../../shared/widgets/text_widget.dart';
import '../../../explore_car/view/widgets/checkout_app_scaffold.dart';

class ProcessingImage extends StatefulWidget {
  const ProcessingImage({super.key});

  @override
  State<ProcessingImage> createState() => _ProcessingImageState();
}

class _ProcessingImageState extends State<ProcessingImage> {
  late String title;
  late String issueTitle;
  late String returnScreen;

  @override
  void initState() {
    super.initState();
    OrientationService().showStatusBar();
    OrientationService().portraitOrientation();
    // Retrieve arguments
    title = Get.arguments?[ArgumentsKey.title] ?? 'Processing images';
    issueTitle = Get.arguments?[ArgumentsKey.issueTitle];
    returnScreen = Get.arguments?[ArgumentsKey.returnScreen] ?? RouterPaths.drawer;

    Future.delayed(const Duration(seconds: 4)).then((value) {
      Get.toNamed(RouterPaths.inspectionFinishing, arguments: {
        ArgumentsKey.title: title,
        ArgumentsKey.issueTitle: issueTitle,
        ArgumentsKey.returnScreen: returnScreen,
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // final ProcessingImageController controller = Get.find();
    // Retrieve arguments
    final String title = Get.arguments?[ArgumentsKey.title] ?? 'Processing images';

    return CheckoutAppScaffold(
      backgroundColor: AppColors.lightCardColor,
      title: 'Report an issue',
      leading: CircleAvatar(
        radius: 12,
        backgroundColor: Colors.transparent,
        child: SvgPicture.asset(Assets.assetsSvgCarCrush),
      ),
      progressValue: 0.6,
      progressColor: AppColors.inProgressColor,
      closeOnTap: () => Get.until((route) => route.settings.name == RouterPaths.drawer),
      body: _bodyUI(title: title),
    );
  }

  Widget _bodyUI({required String title}) => SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(Assets.assetsGifProcessingImage, height: 140).paddingOnly(bottom: 40, top: 100),
              const TitleText(text: 'Processing images').paddingOnly(bottom: 10),
              const SmallText(
                text: 'Please wait while we process your images. This won\'t take long. Thank you!',
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
      );
}
