import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_color.dart';
import '../../../../core/constants/app_list.dart';
import '../../../../core/constants/arguments_key.dart';
import '../../../../core/router/router_paths.dart';
import '../../../../shared/widgets/heightbox.dart';
import '../../../../shared/widgets/image_placeholder_widget.dart';
import '../../../../shared/widgets/outline_text_button.dart';
import '../../../../shared/widgets/solid_text_button.dart';
import '../../../../shared/widgets/text_widget.dart';
import '../../../../shared/widgets/widthbox.dart';
import '../../../explore_car/view/widgets/checkout_app_scaffold.dart';
import '../tiles/ul_tile.dart';

class CaptureImageInstruction extends StatefulWidget {
  const CaptureImageInstruction({super.key});

  @override
  State<CaptureImageInstruction> createState() => _CaptureImageInstructionState();
}

class _CaptureImageInstructionState extends State<CaptureImageInstruction> {
  VideoPlayerController? videoPlayerController;

  @override
  void initState() {
    super.initState();
    videoPlayerController = VideoPlayerController.asset(Assets.assetsVideoVideoInstruction);

    videoPlayerController?.setLooping(true);
    videoPlayerController?.setVolume(0);
    videoPlayerController?.initialize().then((value) => setState(() {}));
    videoPlayerController?.play();
  }

  @override
  void dispose() {
    videoPlayerController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Retrieve arguments
    final screenTitle = Get.arguments?[ArgumentsKey.title] ?? 'Report an issue';
    final issueTitle = Get.arguments?[ArgumentsKey.issueTitle];
    final returnScreen = Get.arguments?[ArgumentsKey.returnScreen] ?? RouterPaths.drawer;

    return CheckoutAppScaffold(
      backgroundColor: AppColors.lightCardColor,
      title: 'Report an issue',
      leading: CircleAvatar(
        radius: 12,
        backgroundColor: Colors.transparent,
        child: SvgPicture.asset(Assets.assetsSvgCarCrush),
      ),
      progressValue: 0.3,
      progressColor: AppColors.inProgressColor,
      closeOnTap: () => Get.until((route) => route.settings.name == RouterPaths.drawer),
      body: _bodyUI(screenTitle: screenTitle, issueTitle: issueTitle, returnScreen: returnScreen),
    );
  }

  Widget _bodyUI({
    required String screenTitle,
    required String issueTitle,
    required String returnScreen,
  }) =>
      SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Instruction video
            videoPlayerController != null
                ? AspectRatio(
                    aspectRatio: videoPlayerController!.value.aspectRatio,
                    child: VideoPlayer(videoPlayerController!),
                  )
                : const ImagePlaceholderWidget(
                    height: 100,
                    iconData: Icons.play_circle,
                  ),
            const HeightBox(height: 20),

            Center(child: const TitleText(text: 'Capture images').paddingOnly(bottom: 16)),

            Container(
              padding: const EdgeInsets.all(12),
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.lightBorderColor, width: 1),
                borderRadius: const BorderRadius.all(
                  Radius.circular(6),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const BodyText(
                    text: 'Steps',
                    textColor: AppColors.lightSecondaryTextColor,
                    fontWeight: FontWeight.bold,
                  ).paddingOnly(bottom: 16),

                  // Instructions
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: AppList.inspectionInstructionList.length,
                    separatorBuilder: (context, index) => const HeightBox(height: 10),
                    itemBuilder: (context, index) => UlTile(
                      title: AppList.inspectionInstructionList[index],
                    ),
                  ),
                ],
              ),
            ).paddingOnly(bottom: 16),

            Row(
              children: [
                // Previous button
                Expanded(
                  child: OutlineTextButton(onTap: () => Get.back(), buttonText: 'Previous'),
                ),
                const WidthBox(width: 6),
                // Start capturing button
                Expanded(
                  child: SolidTextButton(
                      onTap: () {
                        Get.offAndToNamed(
                          RouterPaths.captureInspectionImage,
                          arguments: {
                            ArgumentsKey.title: screenTitle,
                            ArgumentsKey.issueTitle: issueTitle,
                            ArgumentsKey.returnScreen: returnScreen,
                          },
                        );
                      },
                      buttonText: 'Start Capturing'),
                ),
              ],
            ),
          ],
        ),
      );
}
