import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:employee_app/core/l10n/app_localizations.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_color.dart';
import '../../../../core/constants/arguments_key.dart';
import '../../../../shared/repository/local/orientation_repo.dart';
import '../../../../shared/services/local/awake_lock_service.dart';
import '../../../../shared/services/service_locator.dart';
import '../../../../shared/utils/app_toast.dart';
import '../../../../shared/widgets/widget_imports.dart';
import '../../controller/processing_image_controller.dart';
import '../../model/inspection_arguments_model.dart';

class ProcessingImage extends StatefulWidget {
  const ProcessingImage({super.key});

  @override
  State<ProcessingImage> createState() => _ProcessingImageState();
}

class _ProcessingImageState extends State<ProcessingImage> {
  late ProcessingImageController controller;
  late OrientationRepo _orientationRepo;

  late InspectionArgumentsModel? inspectionArgumentsModel;

  @override
  void initState() {
    controller = Get.find();

    _orientationRepo = ServiceLocator.get<OrientationRepo>();
    _orientationRepo.showStatusBar();
    _orientationRepo.portraitOrientation();

    // Retrieve arguments
    inspectionArgumentsModel = Get.arguments?[ArgumentsKey.inspectionArgumentsModel];
    debugPrint(inspectionArgumentsModel.toString());

    // Call verify VIN
    WidgetsBinding.instance.addPostFrameCallback(
      (value) => controller.detectDamage(inspectionArgumentsModel: inspectionArgumentsModel),
    );

    AwakeLockService.enableAwakeLock();
    super.initState();
  }

  @override
  void dispose() {
    AwakeLockService.disableAwakeLock();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context);
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          screenTerminationWarning(locale, locale?.inspectionTerminationMgs, inspectionArgumentsModel?.returnScreen);
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.lightCardColor,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: false,
          leading: CircleAvatar(
            radius: 12,
            backgroundColor: Colors.transparent,
            child: SvgPicture.asset(Assets.assetsSvgGeneralFlag),
          ),
          title: ButtonText(text: '${locale?.step} 2/3'),
          titleSpacing: 0.0,
          actions: [
            IconButton(
              onPressed: () => screenTerminationWarning(
                locale,
                locale?.inspectionTerminationMgs,
                inspectionArgumentsModel?.returnScreen,
              ),
              icon: const Icon(Icons.close),
            ),
          ],
        ),
        body: _bodyUI(locale: locale),
      ),
    );
  }

  Widget _bodyUI({required AppLocalizations? locale}) => SingleChildScrollView(
    padding: const EdgeInsets.all(16),
    child: Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(Assets.assetsGifProcessingImage, height: 140).paddingOnly(bottom: 40, top: 100),
          TitleText(text: '${locale?.processingImages}').paddingOnly(bottom: 10),
          SmallText(text: '${locale?.processingImageMgs}', textAlign: TextAlign.center),
        ],
      ),
    ),
  );
}
