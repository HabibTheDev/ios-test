import 'package:flutter/material.dart';
import '../../../../core/constants/app_color.dart';

class ImageStack extends StatelessWidget {
  final List<String> imageUrls;
  final double imageWidth;
  final Color? borderColor;
  final Function()? onTap;

  const ImageStack(
      {super.key,
      required this.imageUrls,
      this.imageWidth = 32,
      this.borderColor,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        height: imageWidth,
        child: Stack(
          alignment: Alignment.centerRight,
          children: List.generate(imageUrls.length, (index) {
            return Positioned(
              right: (imageUrls.length - index - 1) * (imageWidth * 0.7),
              child: Container(
                width: imageWidth,
                height: imageWidth,
                decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(imageUrls[index]),
                      fit: BoxFit.cover,
                    ),
                    color: AppColors.lightBgColor,
                    borderRadius: BorderRadius.circular(imageWidth / 2),
                    border: Border.all(
                        width: 2,
                        color: borderColor ?? Colors.white,
                        strokeAlign: BorderSide.strokeAlignOutside)),
              ),
            );
          }).reversed.toList(),
        ),
      ),
    );
  }
}
