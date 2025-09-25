import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'image_placeholder_widget.dart';

class NetworkImageWidget extends StatelessWidget {
  const NetworkImageWidget(
      {super.key,
      required this.imageUrl,
      this.height = 100,
      this.width = 100,
      this.borderRadius = 0,
      this.fit = BoxFit.cover});
  final String? imageUrl;
  final double height;
  final double width;
  final double borderRadius;
  final BoxFit fit;

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
              errorWidget: (context, url, error) => ImagePlaceholderWidget(height: height, width: width),
              placeholder: (context, url) => ImagePlaceholderWidget(height: height, width: width),
            )
          : ImagePlaceholderWidget(height: height, width: width),
    );
  }
}
