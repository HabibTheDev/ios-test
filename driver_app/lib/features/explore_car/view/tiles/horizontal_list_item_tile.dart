import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constants/app_color.dart';
import '../../../../shared/widgets/network_image_widget.dart';
import '../../../../shared/widgets/text_widget.dart';

class HorizontalListItemTile extends StatelessWidget {
  const HorizontalListItemTile({
    super.key,
    required this.title,
    required this.onTap,
    this.imageUrl,
    this.logoWidget,
  });
  final String? title;
  final String? imageUrl;
  final Widget? logoWidget;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        width: 160,
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          child: Stack(
            alignment: Alignment.center,
            children: [
              NetworkImageWidget(
                imageUrl: imageUrl,
                width: double.infinity,
              ),
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                color: Colors.black45,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    logoWidget != null ? logoWidget!.paddingOnly(bottom: 7) : const SizedBox.shrink(),
                    BodyText(
                      text: title ?? 'N/A',
                      textColor: AppColors.buttonTextColor,
                      textAlign: TextAlign.center,
                      fontWeight: FontWeight.w600,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
