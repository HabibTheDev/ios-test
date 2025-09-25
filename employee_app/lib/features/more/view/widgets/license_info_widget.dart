part of 'widget_imports.dart';

class LicenseInfoWidget extends StatelessWidget {
  const LicenseInfoWidget({super.key, required this.license});
  final License? license;

  @override
  Widget build(BuildContext context) {
    final ProfileController controller = Get.find();
    final locale = AppLocalizations.of(context);
    return CardWidget(
      contentPadding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          BodyText(
            text: '${locale?.licenseInfo}',
            textColor: AppColors.lightSecondaryTextColor,
            fontWeight: FontWeight.bold,
          ).paddingOnly(bottom: 16),

          // Images
          if (license?.licenseImage != null && license!.licenseImage!.isNotEmpty)
            Wrap(
              spacing: 8,
              children: license!.licenseImage!
                  .map(
                    (item) => InkWell(
                      onTap: () {
                        Get.toNamed(
                          RouterPaths.filePreview,
                          arguments: {
                            ArgumentsKey.attachments: [Attachment(url: item)],
                          },
                        );
                      },
                      child: ClipRRect(
                        borderRadius: const BorderRadius.all(Radius.circular(6)),
                        child: NetworkImageWidget(imageUrl: item, width: 100, height: 80, fit: BoxFit.cover),
                      ),
                    ),
                  )
                  .toList(),
            ).paddingOnly(bottom: 16),

          // Table data
          if (license?.licenseData?.licenseNumber != null)
            BorderedTable(
              rows: [
                ['${locale?.licenseNumber}:', (license?.licenseNumber ?? '${locale?.notAvailable}')],
                ['${locale?.classStr}:', ('${locale?.notAvailable}')],
                ['${locale?.expirationDate}:', license?.expirationDate ?? '${locale?.notAvailable}'],
                ['${locale?.issuingCountry}:', (license?.licenseData?.country ?? '${locale?.notAvailable}')],
                ['${locale?.issuingProvince}:', (license?.licenseData?.state ?? '${locale?.notAvailable}')],
              ],
            ).paddingOnly(bottom: 16),

          // Update license button
          OutlineTextButton(
            onTap: () => controller.updateLicenseOnTap(locale),
            buttonText: '${locale?.updateLicense}',
            primaryColor: AppColors.primaryColor,
            splashColor: AppColors.primaryColor.withAlpha(51),
          ),
        ],
      ),
    );
  }
}
