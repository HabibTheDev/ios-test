import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../../../core/constants/app_color.dart';
import '../../../../shared/utils/utils.dart';
import '../../../../shared/widgets/image_placeholder_widget.dart';
import '../../../../shared/widgets/text_widget.dart';

class FilePreviewTile extends StatelessWidget {
  const FilePreviewTile({super.key, required this.fileUrl, this.onTap});
  final String fileUrl;
  final Function(PdfGestureDetails details)? onTap;

  @override
  Widget build(BuildContext context) {
    if (fileUrl.endsWith('.pdf')) {
      return Container(
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(6)),
            color: AppColors.lightCardColor),
        height: 150,
        // margin: const EdgeInsets.only(bottom: 4),
        child: Theme(
          data: ThemeData(useMaterial3: false),
          child: SfPdfViewer.network(
            onTap: onTap,
            fileUrl,
            canShowScrollHead: false,
            canShowScrollStatus: false,
            scrollDirection: PdfScrollDirection.horizontal,
            enableDoubleTapZooming: false,
          ),
        ),
      );
    } else if (fileUrl.endsWith('.png') ||
        fileUrl.endsWith('.jpg') ||
        fileUrl.endsWith('.jpeg')) {
      return ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(6)),
        child: CachedNetworkImage(
          imageUrl: fileUrl,
          height: 150,
          fit: BoxFit.cover,
          placeholder: (context, url) => const ImagePlaceholderWidget(),
          errorWidget: (context, url, error) => const ImagePlaceholderWidget(),
        ),
      );
    } else {
      return BodyText(
        text: getFileNameFromUrl(fileUrl),
        textColor: AppColors.primaryColor,
      );
    }
  }
}
