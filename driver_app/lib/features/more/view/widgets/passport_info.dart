import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constants/app_color.dart';
import '../../../../shared/widgets/card_widget.dart';
import '../../../../shared/widgets/image_placeholder_widget.dart';
import '../../../../shared/widgets/outline_text_button.dart';
import '../../../../shared/widgets/text_widget.dart';
import '../../controller/profile_controller.dart';
import '../../model/customer_model.dart';
import '../tiles/border_table.dart';

class PassportInfo extends StatelessWidget {
  const PassportInfo({super.key, required this.passport});
  final Passport? passport;

  @override
  Widget build(BuildContext context) {
    final ProfileController controller = Get.find();
    return CardWidget(
      contentPadding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //Title
          const BodyText(
            text: 'Passport Info',
            textColor: AppColors.lightSecondaryTextColor,
            fontWeight: FontWeight.bold,
          ).paddingOnly(bottom: 16),

          //Image
          Wrap(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(6)),
                child: CachedNetworkImage(
                  imageUrl: passport?.passportPhoto ?? '',
                  width: 100,
                  height: 80,
                  fit: BoxFit.fitWidth,
                  placeholder: (context, url) =>
                      const ImagePlaceholderWidget(width: 100, height: 80),
                  errorWidget: (context, url, error) =>
                      const ImagePlaceholderWidget(width: 100, height: 80),
                ),
              )
            ],
          ).paddingOnly(bottom: 16),

          //Table
          BorderedTable(
            rows: [
              ['Passport no:', (passport?.passportNo ?? 'N/A')],
              ['Expiration date:', (passport?.expirationDate ?? 'N/A')],
              ['Type:', (passport?.type ?? 'N/A')],
              ['Issuing Province:', (passport?.issuingProvince ?? 'N/A')],
            ],
          ).paddingOnly(bottom: 16),
          OutlineTextButton(
            onTap: () {
              controller.updatePassportOnTap();
            },
            buttonText: 'Update Passport',
            primaryColor: AppColors.primaryColor,
            splashColor: AppColors.primaryColor.withOpacity(0.2),
          )
        ],
      ),
    );
  }
}
