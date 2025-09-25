part of 'widget_imports.dart';

class CarDetailsWidget extends StatelessWidget {
  const CarDetailsWidget({
    super.key,
    required this.imageUrl,
    required this.carBrandImageUrl,
    required this.model,
    required this.make,
    required this.vin,
    required this.location,
    required this.license,
    required this.carColorName,
    required this.carColorCode,
  });
  final String? imageUrl;
  final String? carBrandImageUrl;
  final String? model;
  final String? make;
  final String? vin;
  final String? location;
  final String? license;
  final String? carColorName;
  final Color? carColorCode;

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        //Brand & Logo
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleImageWidget(imageUrl: carBrandImageUrl, fit: BoxFit.fitWidth),
            // const CircleAvatar(radius: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TitleText(text: make ?? '${locale?.notAvailable}'),
                SmallText(text: model ?? '${locale?.notAvailable}', textColor: AppColors.lightSecondaryTextColor),
              ],
            ).paddingOnly(left: 10),
          ],
        ).paddingOnly(bottom: 28),

        //Car Image
        NetworkImageWidget(
          imageUrl: imageUrl,
          height: 90,
          width: double.infinity,
          fit: BoxFit.fitHeight,
        ).paddingOnly(bottom: 20),

        //Car Details
        CarInfoTile(
          leading: const Icon(CupertinoIcons.barcode, color: AppColors.primaryColor, size: 16),
          titleKey: '${locale?.vin}',
          titleValue: vin ?? '${locale?.notAvailable}',
        ).paddingOnly(bottom: 4),
        CarInfoTile(
          leading: const Icon(Icons.location_on_rounded, color: AppColors.primaryColor, size: 16),
          titleKey: '${locale?.location}',
          titleValue: location ?? '${locale?.notAvailable}',
        ).paddingOnly(bottom: 16),

        CarInfoTile(
          titleKey: '${locale?.license}',
          titleValue: license ?? '${locale?.notAvailable}',
        ).paddingOnly(bottom: 4),

        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SmallText(text: '${locale?.color}:', textColor: AppColors.lightSecondaryTextColor),
            BorderCardWidget(
              backgroundColor: carColorCode ?? Colors.white,
              borderRadius: 4,
              borderColor: Colors.black,
              borderWidth: 0.3,
              child: SizedBox(height: 16, width: 16),
            ).paddingSymmetric(horizontal: 8),
            Expanded(
              child: SmallText(text: carColorName ?? '${locale?.notAvailable}', fontWeight: FontWeight.bold),
            ),
          ],
        ).paddingOnly(bottom: 4),
      ],
    );
  }
}
