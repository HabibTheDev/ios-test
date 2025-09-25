import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../../core/constants/arguments_key.dart';
import '../../../../core/router/router_paths.dart';
import '../../../../shared/utils/app_toast.dart';
import '../../../../core/constants/app_color.dart';
import '../../../../shared/widgets/text_widget.dart';
import '../../model/message_model.dart';
import 'file_preview_tile.dart';

class MessageTile extends StatelessWidget {
  const MessageTile({super.key, required this.message});
  final Message message;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final double maxWidth = width * 0.7;
    // Measure text width
    final double textWidth =
        _calculateTextWidth(message.message ?? '', context);
    // Calculate container width with constraints
    final double containerWidth = textWidth > maxWidth ||
            (message.attachments != null && message.attachments!.isNotEmpty)
        ? message.attachments?.length == 1
            ? width * 0.42
            : maxWidth
        : textWidth;

    return Column(
      crossAxisAlignment:
          message.toAdmin! ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        InkWell(
          onLongPress: () {
            Clipboard.setData(ClipboardData(text: message.message ?? ''));
            showToast('Message copied');
          },
          onTap: () {
            if (message.attachments != null &&
                message.attachments!.isNotEmpty) {
              Get.toNamed(RouterPaths.filePreview,
                  arguments: {ArgumentsKey.attachments: message.attachments});
            }
          },
          child: Container(
            width: containerWidth,
            alignment:
                message.toAdmin! ? Alignment.centerRight : Alignment.centerLeft,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: message.toAdmin!
                  ? AppColors.lightCurrentUserChatColor
                  : AppColors.lightOtherUserChatColor,
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(10),
                topRight: const Radius.circular(10),
                bottomLeft: message.toAdmin!
                    ? const Radius.circular(10)
                    : const Radius.circular(0),
                bottomRight: !message.toAdmin!
                    ? const Radius.circular(10)
                    : const Radius.circular(0),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: message.toAdmin!
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
              children: [
                if (message.attachments != null &&
                    message.attachments!.isNotEmpty)
                  message.attachments!.length == 1
                      ? InkWell(
                          onTap: () {
                            if (message.attachments != null &&
                                message.attachments!.isNotEmpty) {
                              Get.toNamed(RouterPaths.filePreview, arguments: {
                                ArgumentsKey.attachments: message.attachments
                              });
                            }
                          },
                          child: FilePreviewTile(
                            fileUrl: message.attachments!.first.url!,
                            onTap: (details) {
                              if (message.attachments != null &&
                                  message.attachments!.isNotEmpty) {
                                Get.toNamed(RouterPaths.filePreview,
                                    arguments: {
                                      ArgumentsKey.attachments:
                                          message.attachments
                                    });
                              }
                            },
                          ).paddingOnly(bottom: 4),
                        )
                      : GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  mainAxisSpacing: 8,
                                  crossAxisSpacing: 8,
                                  childAspectRatio: 1),
                          itemCount: message.attachments!.length,
                          itemBuilder: (context, index) => FilePreviewTile(
                            fileUrl: message.attachments![index].url!,
                            onTap: (details) {
                              if (message.attachments != null &&
                                  message.attachments!.isNotEmpty) {
                                Get.toNamed(RouterPaths.filePreview,
                                    arguments: {
                                      ArgumentsKey.attachments:
                                          message.attachments
                                    });
                              }
                            },
                          ),
                        ).paddingOnly(bottom: 4),
                BodyText(text: message.message ?? 'N/A'),
              ],
            ),
          ),
        ),
        if (message.id == null && message.toAdmin == true)
          const SmallText(
            text: 'sending',
            textColor: AppColors.lightSecondaryTextColor,
          )
      ],
    );
  }

  double _calculateTextWidth(String text, BuildContext context) {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(text: text, style: Theme.of(context).textTheme.bodyMedium),
      maxLines: 1,
      textDirection: TextDirection.ltr,
    )..layout(minWidth: 0, maxWidth: double.infinity);
    return textPainter.size.width + 16; // +16 for padding
  }
}
