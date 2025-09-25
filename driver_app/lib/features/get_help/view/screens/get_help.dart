import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_color.dart';
import '../../../../shared/services/remote/get_help_service.dart';
import '../../../../shared/widgets/loading_widget.dart';
import '../../../../shared/widgets/text_field_widget.dart';
import '../../../../shared/widgets/text_widget.dart';
import '../../controller/get_help_controller.dart';
import '../tiles/message_tile.dart';

class GetHelp extends StatefulWidget {
  const GetHelp({super.key});

  @override
  State<GetHelp> createState() => _GetHelpState();
}

class _GetHelpState extends State<GetHelp> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<GetHelpController>(
      init: GetHelpController(GetHelpService(), this),
      autoRemove: false,
      builder: (controller) {
        return ScrollConfiguration(
          behavior: MyBehavior(),
          child: Container(
            color: AppColors.lightCardColor,
            child: Obx(
              () => Column(
                children: [
                  controller.isLoading.value
                      ? const Expanded(child: CenterLoadingWidget())
                      : _buildMessageList(controller),
                  SafeArea(child: _buildMessageInput(controller))
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildMessageList(GetHelpController controller) => Expanded(
        child: controller.messages.isEmpty
            ? _emptyChatWidget()
            : Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  ListView.separated(
                    controller: controller.chatScrollController,
                    physics: const BouncingScrollPhysics(),
                    addAutomaticKeepAlives: false,
                    addRepaintBoundaries: false,
                    reverse: true,
                    padding: const EdgeInsets.all(16),
                    itemCount: controller.messages.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 20),
                    itemBuilder: (context, index) {
                      return MessageTile(message: controller.messages[index]);
                    },
                  ),

                  // Bottom scroll widget
                  controller.messages.isNotEmpty &&
                          !controller.isListViewFullyScrolled.value
                      ? InkWell(
                          onTap: () async {
                            await Future.delayed(
                                    const Duration(milliseconds: 200))
                                .then((_) => controller.scrollDown());
                          },
                          child: ScaleTransition(
                            scale: controller.scrollButtonAnimation,
                            child: Container(
                              margin: const EdgeInsets.only(bottom: 12),
                              padding: const EdgeInsets.only(
                                  left: 16, right: 16, top: 4, bottom: 8),
                              width: 163,
                              decoration: BoxDecoration(
                                color: AppColors.primaryColor,
                                boxShadow: [
                                  BoxShadow(
                                      color: const Color(0xff0072C6)
                                          .withOpacity(0.2),
                                      blurRadius: 16,
                                      offset: const Offset(0, 10))
                                ],
                                borderRadius: const BorderRadius.horizontal(
                                    left: Radius.circular(40.0),
                                    right: Radius.circular(40.0)),
                              ),
                              child: const FittedBox(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Icon(Icons.arrow_downward_sharp,
                                        size: 12, color: Colors.white),
                                    SmallText(
                                      text: ' scroll to bottom',
                                      textSize: 10,
                                      textColor: Colors.white,
                                      textAlign: TextAlign.center,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )
                      : const SizedBox.shrink(),

                  // Message loading widget
                  controller.isListViewFullyScrolledToTop.value
                      ? const Align(
                              alignment: Alignment.topCenter,
                              child: LoadingWidget())
                          .paddingOnly(top: 20)
                      : const SizedBox.shrink()
                ],
              ),
      );

  Widget _buildMessageInput(GetHelpController controller) => Container(
        padding: const EdgeInsets.only(bottom: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(
              () => controller.selectedAttachments.isNotEmpty
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () => controller.clearAttachments(),
                          child: const Icon(
                            Icons.close,
                            size: 16,
                            color: AppColors.lightSecondaryTextColor,
                          ),
                        ),
                        BodyText(
                          text:
                              ' ${controller.selectedAttachments.length} file selected',
                          textColor: AppColors.lightSecondaryTextColor,
                        ),
                      ],
                    ).paddingOnly(left: 16)
                  : const SizedBox.shrink(),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                IconButton(
                    onPressed: () => controller.pickMultipleFiles(),
                    icon: const Icon(
                      Icons.add_circle,
                      color: AppColors.lightSecondaryTextColor,
                      size: 28,
                    )),
                Expanded(
                    child: TextFormFieldWidget(
                  controller: controller.messageController,
                  hintText: "Type here",
                  minLine: 1,
                  maxLine: 6,
                  textInputType: TextInputType.multiline,
                  textCapitalization: TextCapitalization.sentences,
                )),
                Obx(() => IconButton(
                      onPressed: () => controller.sendMessage(),
                      icon: Icon(
                        Icons.send,
                        color: controller.hasMessage.value
                            ? AppColors.primaryColor
                            : AppColors.lightSecondaryTextColor,
                        size: 28,
                      ),
                    ))
              ],
            ),
          ],
        ),
      );

  Widget _emptyChatWidget() => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(Assets.assetsSvgChat).paddingOnly(bottom: 10),
          const TitleText(text: 'Chat with admin'),
          const SmallText(
            text:
                'Connect with the admin here! Drop a message, and we\'ll get back to you ASAP',
            textColor: AppColors.lightSecondaryTextColor,
            textAlign: TextAlign.center,
          )
        ],
      ).paddingAll(16);
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}
