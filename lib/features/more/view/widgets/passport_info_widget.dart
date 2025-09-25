part of 'widget_imports.dart';

class PassportInfoWidget extends StatelessWidget {
  const PassportInfoWidget({super.key, required this.passport});
  final Passport? passport;

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
            text: '${locale?.passportInfo}',
            textColor: AppColors.lightSecondaryTextColor,
            fontWeight: FontWeight.bold,
          ).paddingOnly(bottom: 16),

          // Image
          if (passport?.passportPhoto != null)
            Wrap(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(6)),
                  child: NetworkImageWidget(
                    imageUrl: passport?.passportPhoto,
                    width: 100,
                    height: 80,
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ],
            ).paddingOnly(bottom: 16),

          // Table
          if (passport?.passportNo != null)
            BorderedTable(
              rows: [
                ['${locale?.passportNo}:', (passport?.passportNo ?? '${locale?.notAvailable}')],
                ['${locale?.expirationDate}:', (passport?.expirationDate ?? '${locale?.notAvailable}')],
                ['${locale?.type}:', (passport?.type ?? '${locale?.notAvailable}')],
                ['${locale?.issuingProvince}:', (passport?.issuingProvince ?? '${locale?.notAvailable}')],
              ],
            ).paddingOnly(bottom: 16),
          OutlineTextButton(
            onTap: () => controller.updatePassportOnTap(locale),
            buttonText: '${locale?.updatePassport}',
            primaryColor: AppColors.primaryColor,
            splashColor: AppColors.primaryColor.withAlpha(51),
          ),
        ],
      ),
    );
  }
}
