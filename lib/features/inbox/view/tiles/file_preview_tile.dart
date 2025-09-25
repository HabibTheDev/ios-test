import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../../../core/constants/app_color.dart';
import '../../../../shared/utils/utils.dart';
import '../../../../shared/widgets/network_image_widget.dart';
import '../../../../shared/widgets/widget_imports.dart';

class FilePreviewTile extends StatelessWidget {
  const FilePreviewTile({super.key, required this.fileUrl, this.pdfOnTap, this.imageOnTap, this.textOnTap});
  final String fileUrl;
  final Function(PdfGestureDetails details)? pdfOnTap;
  final Function()? imageOnTap;
  final Function()? textOnTap;

  @override
  Widget build(BuildContext context) {
    if (fileUrl.endsWith('.pdf')) {
      return Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(6)),
          color: AppColors.lightCardColor,
        ),
        height: 150,
        // margin: const EdgeInsets.only(bottom: 4),
        child: Theme(
          data: ThemeData(useMaterial3: false),
          child: SfPdfViewer.network(
            onTap: pdfOnTap,
            fileUrl,
            canShowScrollHead: false,
            canShowScrollStatus: false,
            scrollDirection: PdfScrollDirection.horizontal,
            enableDoubleTapZooming: false,
          ),
        ),
      );
    } else if (isOnlineImage(url: fileUrl)) {
      return GestureDetector(
        onTap: imageOnTap,
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(6)),
          child: NetworkImageWidget(imageUrl: fileUrl, height: 150, fit: BoxFit.cover),
        ),
      );
    } else {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.info, color: Colors.grey),
            GestureDetector(
              onTap: textOnTap,
              child: BodyText(
                text: getFileNameFromUrl(fileUrl),
                textColor: AppColors.primaryColor,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      );
    }
  }
}
