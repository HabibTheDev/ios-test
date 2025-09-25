import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../../../core/constants/app_color.dart';
import '../../../../core/constants/arguments_key.dart';
import '../../../../core/l10n/app_localizations.dart';
import '../../../../shared/utils/utils.dart';
import '../../../../shared/widgets/network_image_widget.dart';
import '../../../../shared/widgets/widget_imports.dart';
import '../../model/message_model.dart';

class FilePreviewScreen extends StatefulWidget {
  const FilePreviewScreen({super.key});

  @override
  State<FilePreviewScreen> createState() => _FilePreviewScreenState();
}

class _FilePreviewScreenState extends State<FilePreviewScreen> with SingleTickerProviderStateMixin {
  late TransformationController _transformationController;
  late AnimationController _animationController;
  Animation<Matrix4>? _animation;
  late PageController pageController;

  late List<Attachment> attachments;
  int attachmentViewIndex = 0;
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    attachments = Get.arguments?[ArgumentsKey.attachments] ?? [];
    attachmentViewIndex = Get.arguments?[ArgumentsKey.attachmentViewIndex] ?? attachmentViewIndex;
    currentIndex = attachmentViewIndex;
    pageController = PageController(initialPage: attachmentViewIndex);

    _transformationController = TransformationController();
    _animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 300))
      ..addListener(() {
        _transformationController.value = _animation!.value;
      });
  }

  @override
  void dispose() {
    _transformationController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _handleDoubleTap() {
    final double currentScale = _transformationController.value.getMaxScaleOnAxis();
    late Matrix4 endMatrix;
    if (currentScale == 1.0) {
      endMatrix = Matrix4.identity()..scale(1.5);
    } else {
      endMatrix = Matrix4.identity();
    }

    _animation = Matrix4Tween(
      begin: _transformationController.value,
      end: endMatrix,
    ).animate(CurvedAnimation(parent: _animationController, curve: Curves.easeInOut));

    _animationController.forward(from: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightCardColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: false,
        titleSpacing: 0,
        title: ButtonText(text: '${AppLocalizations.of(context)?.preview} ${currentIndex + 1}/${attachments.length}'),
        leading: const Icon(Icons.preview, size: 20, color: AppColors.lightAppBarIconColor),
        actions: [IconButton(onPressed: () => Get.back(), icon: const Icon(Icons.close))],
      ),
      body: PageView.builder(
        controller: pageController,
        scrollDirection: Axis.horizontal,
        itemCount: attachments.length,
        onPageChanged: (int value) => setState(() => currentIndex = value),
        itemBuilder: (context, index) {
          final String url = attachments[index].url ?? '';
          if (isPdf(url: url)) {
            return Theme(
              data: ThemeData(useMaterial3: false),
              child: SfPdfViewer.network(attachments[index].url ?? '', scrollDirection: PdfScrollDirection.vertical),
            );
          } else if (isOnlineImage(url: url)) {
            return GestureDetector(
              onDoubleTap: _handleDoubleTap,
              child: InteractiveViewer(
                transformationController: _transformationController,
                panEnabled: true, // Enable panning
                boundaryMargin: EdgeInsets.zero, // Allow movement beyond screen edges
                constrained: true, // Restrict movement at minScale
                clipBehavior: Clip.none, // Ensures smooth panning when zoomed in
                minScale: 1.0,
                maxScale: 10.0,
                child: NetworkImageWidget(imageUrl: url, fit: BoxFit.fitWidth),
              ),
            );
          } else if (isLocalImage(path: url)) {
            return GestureDetector(
              onDoubleTap: _handleDoubleTap,
              child: InteractiveViewer(
                transformationController: _transformationController,
                panEnabled: true, // Enable panning
                boundaryMargin: EdgeInsets.zero, // Allow movement beyond screen edges
                constrained: true, // Restrict movement at minScale
                clipBehavior: Clip.none, // Ensures smooth panning when zoomed in
                minScale: 1.0,
                maxScale: 10.0,
                child: Image.file(File(url), fit: BoxFit.fitWidth),
              ),
            );
          } else {
            return Center(
              child: InkWell(
                onTap: () async => await openUrl(url: url),
                child: BodyText(
                  text: getFileNameFromUrl(url),
                  textAlign: TextAlign.center,
                  textColor: AppColors.primaryColor,
                ).paddingAll(16),
              ),
            );
          }
        },
      ),
    );
  }
}
