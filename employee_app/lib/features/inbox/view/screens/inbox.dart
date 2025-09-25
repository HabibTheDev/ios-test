import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:employee_app/core/l10n/app_localizations.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_color.dart';
import '../../../../shared/widgets/widget_imports.dart';
import '../../controller/inbox_controller.dart';
import '../tiles/message_tile.dart';

class Inbox extends StatefulWidget {
  const Inbox({super.key});

  @override
  State<Inbox> createState() => _InboxState();
}

class _InboxState extends State<Inbox> with SingleTickerProviderStateMixin {
  late InboxController controller;

  @override
  void initState() {
    super.initState();

    controller = Get.find();
    controller.initScrollButtonAnimation(vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context);
    return ScrollConfiguration(
      behavior: MyBehavior(),
      child: Container(
        color: AppColors.lightCardColor,
        child: Obx(
          () => Column(
            children: [
              controller.isLoading.value
                  ? const Expanded(child: CenterLoadingWidget())
                  : _buildMessageList(controller, locale),
              SafeArea(child: _buildMessageInput(controller, locale)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMessageList(InboxController controller, AppLocalizations? locale) => Expanded(
    child: controller.messages.isEmpty
        ? _emptyChatWidget(locale)
        : Stack(
            alignment: Alignment.bottomCenter,
            children: [
              ListView.separated(
                controller: controller.chatScrollController,
                physics: const BouncingScrollPhysics(),
                addAutomaticKeepAlives: true,
                reverse: true,
                padding: const EdgeInsets.all(16),
                itemCount: controller.messages.length,
                separatorBuilder: (context, index) => const SizedBox(height: 20),
                itemBuilder: (context, index) {
                  return MessageTile(message: controller.messages[index]);
                },
              ),

              // Bottom scroll widget
              controller.messages.isNotEmpty && !controller.isListViewFullyScrolled.value
                  ? InkWell(
                      onTap: () async {
                        await Future.delayed(const Duration(milliseconds: 200)).then((_) => controller.scrollDown());
                      },
                      child: ScaleTransition(
                        scale: controller.scrollButtonAnimation,
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          padding: const EdgeInsets.only(left: 16, right: 16, top: 4, bottom: 8),
                          width: 163,
                          decoration: BoxDecoration(
                            color: AppColors.primaryColor,
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.primaryColor.withAlpha(51),
                                blurRadius: 16,
                                offset: const Offset(0, 10),
                              ),
                            ],
                            borderRadius: const BorderRadius.horizontal(
                              left: Radius.circular(40.0),
                              right: Radius.circular(40.0),
                            ),
                          ),
                          child: FittedBox(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                const Icon(Icons.arrow_downward_sharp, size: 12, color: Colors.white),
                                SmallText(
                                  text: ' ${locale?.scrollToBottom}',
                                  textSize: 10,
                                  textColor: Colors.white,
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  : const SizedBox.shrink(),

              // Message loading widget
              controller.isListViewFullyScrolledToTop.value
                  ? const Align(alignment: Alignment.topCenter, child: LoadingWidget()).paddingOnly(top: 20)
                  : const SizedBox.shrink(),
            ],
          ),
  );

  Widget _buildMessageInput(InboxController controller, AppLocalizations? locale) => Container(
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
                      child: const Icon(Icons.close, size: 16, color: AppColors.lightSecondaryTextColor),
                    ),
                    BodyText(
                      text: ' ${controller.selectedAttachments.length} ${locale?.fileSelected}',
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
              onPressed: () => controller.pickFiles(),
              icon: const Icon(Icons.add_circle, color: AppColors.lightSecondaryTextColor, size: 28),
            ),
            Expanded(
              child: TextFormFieldWidget(
                controller: controller.messageController,
                hintText: "${locale?.typeHere}",
                minLine: 1,
                maxLine: 6,
                textInputType: TextInputType.multiline,
                textCapitalization: TextCapitalization.sentences,
              ),
            ),
            Obx(
              () => IconButton(
                onPressed: () => controller.sendMessage(),
                icon: Icon(
                  Icons.send,
                  color: controller.hasMessage.value ? AppColors.primaryColor : AppColors.lightSecondaryTextColor,
                  size: 28,
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );

  Widget _emptyChatWidget(AppLocalizations? locale) => Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      SvgPicture.asset(Assets.assetsSvgChat).paddingOnly(bottom: 10),
      TitleText(text: '${locale?.chatWithAdmin}'),
      SmallText(
        text: '${locale?.emptyInboxMgs}',
        textColor: AppColors.lightSecondaryTextColor,
        textAlign: TextAlign.center,
      ),
    ],
  ).paddingAll(16);
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}
