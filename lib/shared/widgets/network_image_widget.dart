import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'widget_imports.dart';

class NetworkImageWidget extends StatelessWidget {
  const NetworkImageWidget({
    super.key,
    required this.imageUrl,
    this.height = 100,
    this.width = 100,
    this.borderRadius = 0,
    this.fit = BoxFit.cover,
    this.placeholderHeight,
    this.placeholderWidth,
  });
  final String? imageUrl;
  final double height;
  final double width;
  final double borderRadius;
  final BoxFit fit;
  final double? placeholderHeight;
  final double? placeholderWidth;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
      child: imageUrl != null
          ? CachedNetworkImage(
              imageUrl: imageUrl!,
              height: height,
              width: width,
              fit: fit,
              errorWidget: (context, url, error) =>
                  ImagePlaceholderWidget(height: placeholderHeight ?? height, width: placeholderWidth ?? width),
              placeholder: (context, url) =>
                  ImagePlaceholderWidget(height: placeholderHeight ?? height, width: placeholderWidth ?? width),
            )
          : ImagePlaceholderWidget(height: placeholderHeight ?? height, width: placeholderWidth ?? width),
    );
  }
}
