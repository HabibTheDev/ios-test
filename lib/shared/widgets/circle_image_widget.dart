part of 'widget_imports.dart';

class CircleImageWidget extends StatelessWidget {
  const CircleImageWidget({
    super.key,
    required this.imageUrl,
    this.imageSize = 40,
    this.iconSize = 40,
    this.fit = BoxFit.cover,
  });
  final String? imageUrl;
  final double imageSize;
  final double iconSize;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(imageSize / 2)),
      child: NetworkImageWidget(imageUrl: imageUrl, height: imageSize, width: imageSize, fit: fit),
    );
  }
}
