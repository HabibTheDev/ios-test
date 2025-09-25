part of 'widget_imports.dart';

class MaintenanceCarDetailsWidget extends StatelessWidget {
  const MaintenanceCarDetailsWidget({super.key, required this.taskModel});
  final SingleTaskModel? taskModel;

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context);
    return CardWidget(
      contentPadding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Car Details
          CarDetailsWidget(
            imageUrl: taskModel?.carInfo?.images?.first,
            carBrandImageUrl: taskModel?.carInfo?.brandLogo,
            model: taskModel?.carInfo?.model,
            make: taskModel?.carInfo?.make,
            vin: taskModel?.carInfo?.vin,
            location: taskModel?.carInfo?.location?.locationName,
            license: taskModel?.carInfo?.license,
            carColorName: taskModel?.carInfo?.exteriorColor,
            carColorCode: taskModel?.carInfo?.exteriorColorCode,
          ),
          const AppDivider().paddingSymmetric(vertical: 12),

          // Maintenance type
          BorderCardTile(
            leading: const Icon(Icons.handyman, color: AppColors.primaryColor, size: 20),
            title: (taskModel?.task?.type ?? '${locale?.notAvailable}').toCapitalized(),
            subTitle: '${locale?.maintenanceType}',
          ).paddingOnly(bottom: 10),

          // Retrieve / Drop-off address
          if (taskModel?.task?.type != TaskTypeEnum.regular.value)
            BorderCardTile(
              leading: const Icon(Icons.location_on_rounded, color: AppColors.primaryColor, size: 20),
              title: taskModel?.task?.type == TaskTypeEnum.dropOff.value
                  ? taskModel?.task?.locationId?.toString() ?? '${locale?.notAvailable}'
                  : taskModel?.task?.address ?? '${locale?.notAvailable}',
              subTitle:
                  '${taskModel?.task?.type?.toCapitalized()} ${taskModel?.task?.type == TaskTypeEnum.dropOff.value ? 'location' : 'address'}',
            ).paddingOnly(bottom: 20),

          // Retrieve / Drop-off time
          BorderCardTile(
            leading: const Icon(Icons.watch_later, color: AppColors.primaryColor, size: 20),
            title: readableDate(taskModel?.task?.date ?? DateTime.now(), pattern: AppString.readableDateFormat),
            secondaryTitle: readableDate(
              taskModel?.task?.date ?? DateTime.now(),
              pattern: AppString.readableTimeFormat,
            ),
            subTitle:
                '${taskModel?.task?.type == TaskTypeEnum.regular.value ? '${locale?.maintenance}' : taskModel?.task?.type?.toCapitalized()} ${locale?.time}',
          ).paddingOnly(bottom: 20),

          // Delivery address
          if (taskModel?.task?.type != TaskTypeEnum.regular.value)
            BorderCardTile(
              leading: const Icon(Icons.pin_drop_rounded, color: AppColors.primaryColor, size: 20),
              title: taskModel?.task?.deliveryAddress ?? '${locale?.notAvailable}',
              subTitle: '${locale?.delivery} ${locale?.address.toLowerCase()}',
            ).paddingOnly(bottom: 20),

          // Note
          if (taskModel?.task?.note != null && taskModel!.task!.note!.isNotEmpty)
            BodyText(text: taskModel?.task?.note ?? '${locale?.notAvailable}').paddingOnly(bottom: 20),
        ],
      ),
    ).paddingOnly(bottom: 10);
  }
}
