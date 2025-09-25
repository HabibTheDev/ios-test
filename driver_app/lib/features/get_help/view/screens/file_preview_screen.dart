import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../../../core/constants/app_color.dart';
import '../../../../core/constants/arguments_key.dart';
import '../../../../shared/utils/utils.dart';
import '../../../../shared/widgets/image_placeholder_widget.dart';
import '../../../../shared/widgets/text_widget.dart';
import '../../model/message_model.dart';

class FilePreviewScreen extends StatefulWidget {
  const FilePreviewScreen({super.key});

  @override
  State<FilePreviewScreen> createState() => _FilePreviewScreenState();
}

class _FilePreviewScreenState extends State<FilePreviewScreen> {
  @override
  Widget build(BuildContext context) {
    final List<Attachment> attachments =
        Get.arguments?[ArgumentsKey.attachments] ?? [];
    return Scaffold(
        backgroundColor: AppColors.lightCardColor,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: false,
          title: const ButtonText(text: 'Preview'),
          titleSpacing: 0,
          leading: const Icon(
            Icons.preview,
            size: 20,
            color: AppColors.lightAppBarIconColor,
          ),
          actions: [
            IconButton(
                onPressed: () => Get.back(), icon: const Icon(Icons.close))
          ],
        ),
        body: PageView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: attachments.length,
          itemBuilder: (context, index) =>
              attachments[index].url!.endsWith('.pdf')
                  ? Theme(
                      data: ThemeData(useMaterial3: false),
                      child: SfPdfViewer.network(
                        attachments[index].url!,
                        scrollDirection: PdfScrollDirection.vertical,
                      ),
                    )
                  : attachments[index].url!.endsWith('.png') ||
                          attachments[index].url!.endsWith('.jpg') ||
                          attachments[index].url!.endsWith('.jpeg')
                      ? CachedNetworkImage(
                          imageUrl: attachments[index].url!,
                          fit: BoxFit.fitWidth,
                          placeholder: (context, url) =>
                              const ImagePlaceholderWidget(),
                          errorWidget: (context, url, error) =>
                              const ImagePlaceholderWidget(),
                        )
                      : Center(
                          child: BodyText(
                            text: getFileNameFromUrl(attachments[index].url!),
                            textAlign: TextAlign.center,
                            textColor: AppColors.primaryColor,
                          ),
                        ),
        ));
  }
}
