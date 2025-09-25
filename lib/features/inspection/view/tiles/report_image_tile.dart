import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReportImageTile extends StatelessWidget {
  const ReportImageTile({super.key, required this.imageFile});
  final File? imageFile;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(6)),
      child: imageFile != null
          ? Image.file(imageFile!, height: 56.h, width: 80.w, fit: BoxFit.cover)
          : const SizedBox.shrink(),
    );
  }
}
