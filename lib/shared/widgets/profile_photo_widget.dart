part of 'widget_imports.dart';

class ProfilePhotoWidget extends StatelessWidget {
  const ProfilePhotoWidget({
    super.key,
    required this.imageUrl,
    this.imageSize = 60,
    this.iconSize = 50,
  });
  final String? imageUrl;
  final double imageSize;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(imageSize / 2)),
      child: NetworkImageWidget(imageUrl: imageUrl, height: imageSize, width: imageSize, fit: BoxFit.cover),
    );
  }
}
