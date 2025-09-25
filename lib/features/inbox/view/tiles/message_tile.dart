import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:employee_app/core/l10n/app_localizations.dart';

import '../../../../shared/extensions/string_extension.dart';
import '../../../../core/constants/arguments_key.dart';
import '../../../../core/router/router_paths.dart';
import '../../../../shared/utils/app_toast.dart';
import '../../../../core/constants/app_color.dart';
import '../../../../shared/utils/utils.dart';
import '../../../../shared/widgets/widget_imports.dart';
import '../../model/message_model.dart';
import 'file_preview_tile.dart';

class MessageTile extends StatelessWidget {
  const MessageTile({super.key, required this.message});
  final Message message;

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context);
    final double maxWidth = MediaQuery.of(context).size.width * 0.7;
    final bool hasAttachment = message.attachments != null && message.attachments!.isNotEmpty;
    final int attachmentLength = (message.attachments ?? []).length;

    // Measure text width
    final double textWidth = _calculateTextWidth(message.message ?? '', context);
    // Calculate container width with constraints
    final double containerWidth = textWidth > maxWidth || (hasAttachment) ? maxWidth : textWidth;
    final Color? tileColor =
        ((message.message == null || message.message!.isEmpty) && message.attachments != null && attachmentLength < 2)
        ? null
        : message.toAdmin!
        ? AppColors.lightCurrentUserChatColor
        : AppColors.lightOtherUserChatColor;
    final BorderRadiusGeometry tileBorderRadius = BorderRadius.only(
      topLeft: const Radius.circular(10),
      topRight: const Radius.circular(10),
      bottomLeft: message.toAdmin! ? const Radius.circular(10) : const Radius.circular(0),
      bottomRight: !message.toAdmin! ? const Radius.circular(10) : const Radius.circular(0),
    );

    return Column(
      crossAxisAlignment: message.toAdmin! ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Container(
          width: containerWidth,
          alignment: message.toAdmin! ? Alignment.centerRight : Alignment.centerLeft,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(color: tileColor, borderRadius: tileBorderRadius),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: message.toAdmin! ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              if (hasAttachment)
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  addAutomaticKeepAlives: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: attachmentLength == 1
                        ? 1
                        : attachmentLength == 2
                        ? 2
                        : 3,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                    childAspectRatio: 1,
                  ),
                  itemCount: attachmentLength,
                  itemBuilder: (context, index) => FilePreviewTile(
                    fileUrl: message.attachments![index].url!,
                    pdfOnTap: (details) => _goToFilePreviewScreen(message.attachments, index),
                    imageOnTap: () => _goToFilePreviewScreen(message.attachments, index),
                    textOnTap: () async => await openUrl(url: message.attachments![index].url),
                  ),
                ),
              if (message.message != null && message.message!.isNotEmpty)
                GestureDetector(
                  onLongPress: () {
                    if (message.message == null) return;
                    Clipboard.setData(ClipboardData(text: message.message!));
                    showToast('${locale?.messageCopied}');
                  },
                  onTap: () {
                    if (message.message.isValidUrl()) {
                      openUrl(url: message.message);
                    }
                  },
                  child: BodyText(
                    text: message.message ?? '',
                    textColor: message.message?.isValidUrl() ?? false ? AppColors.primaryColor : null,
                  ).paddingOnly(top: hasAttachment ? 4 : 0),
                ),
            ],
          ),
        ),
        if (message.id == null && message.toAdmin == true)
          SmallText(text: '${locale?.sending.toLowerCase()}', textColor: AppColors.lightSecondaryTextColor),
      ],
    );
  }

  void _goToFilePreviewScreen(List<Attachment>? attachments, int attachmentViewIndex) {
    Get.toNamed(
      RouterPaths.filePreview,
      arguments: {ArgumentsKey.attachments: attachments, ArgumentsKey.attachmentViewIndex: attachmentViewIndex},
    );
  }

  double _calculateTextWidth(String text, BuildContext context) {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(text: text, style: const TextStyle(fontSize: 14.5)),
      maxLines: 2,
      textDirection: TextDirection.ltr,
    )..layout(minWidth: 0, maxWidth: double.infinity);
    return textPainter.size.width + 24; // 28 for padding
  }
}
