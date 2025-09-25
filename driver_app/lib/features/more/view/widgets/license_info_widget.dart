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

class LicenseInfoWidget extends StatelessWidget {
  const LicenseInfoWidget({super.key, required this.license});
  final License? license;

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
            text: 'License Info',
            textColor: AppColors.lightSecondaryTextColor,
            fontWeight: FontWeight.bold,
          ).paddingOnly(bottom: 16),

          //Image
          Wrap(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(6)),
                child: CachedNetworkImage(
                  imageUrl: license?.licenseFront ?? '',
                  width: 100,
                  height: 80,
                  fit: BoxFit.fitWidth,
                  placeholder: (context, url) =>
                      const ImagePlaceholderWidget(width: 100, height: 80),
                  errorWidget: (context, url, error) =>
                      const ImagePlaceholderWidget(width: 100, height: 80),
                ),
              ).paddingOnly(right: 8),
              ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(6)),
                child: CachedNetworkImage(
                  imageUrl: license?.licenseBack ?? '',
                  width: 100,
                  height: 80,
                  fit: BoxFit.fitWidth,
                  placeholder: (context, url) =>
                      const ImagePlaceholderWidget(width: 100, height: 80),
                  errorWidget: (context, url, error) =>
                      const ImagePlaceholderWidget(width: 100, height: 80),
                ),
              ).paddingOnly(right: 8),
            ],
          ).paddingOnly(bottom: 16),

          //Table
          BorderedTable(
            rows: [
              ['License number:', (license?.licenseNumber ?? 'N/A')],
              ['Class', (license?.licenseClass ?? 'N/A')],
              ['Expiration date:', (license?.expirationDate ?? 'N/A')],
              ['Issuing Country:', (license?.issuingCountry ?? 'N/A')],
              ['Issuing Province:', (license?.issuingProvince ?? 'N/A')],
            ],
          ).paddingOnly(bottom: 16),
          OutlineTextButton(
            onTap: () {
              controller.updateLicenseOnTap();
            },
            buttonText: 'Update License',
            primaryColor: AppColors.primaryColor,
            splashColor: AppColors.primaryColor.withOpacity(0.2),
          )
        ],
      ),
    );
  }
}
