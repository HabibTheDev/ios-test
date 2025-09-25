import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:employee_app/core/l10n/app_localizations.dart';

import '../../../../core/constants/app_string.dart';
import '../../../../core/constants/arguments_key.dart';
import '../../../../shared/extensions/string_extension.dart';
import '../../../../core/constants/app_color.dart';
import '../../../../core/router/router_paths.dart';
import '../../../../shared/model/single_task_model.dart';
import '../../../../shared/utils/app_toast.dart';
import '../../../../shared/enums/enums.dart';
import '../../../../shared/utils/utils.dart';
import '../../../../shared/widgets/widget_imports.dart';
import 'old_car_details_widget.dart';

class ExchangeCarDetailsWidget extends StatelessWidget {
  const ExchangeCarDetailsWidget({super.key, required this.taskModel});
  final SingleTaskModel? taskModel;

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context);
    return CardWidget(
      contentPadding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          OldCarDetailsWidget(
            imageUrl: taskModel?.requestCarInfo?.images?.first,
            carBrandImageUrl: taskModel?.requestCarInfo?.brandLogo,
            model: taskModel?.requestCarInfo?.model,
            make: taskModel?.requestCarInfo?.make,
          ),

          const Center(child: Icon(Icons.arrow_downward, color: AppColors.primaryColor, size: 28)).paddingAll(20),

          CarDetailsWidget(
            imageUrl: taskModel?.activeCarInfo?.images?.first,
            carBrandImageUrl: taskModel?.activeCarInfo?.brandLogo,
            model: taskModel?.activeCarInfo?.model,
            make: taskModel?.activeCarInfo?.make,
            vin: taskModel?.activeCarInfo?.vin,
            location: taskModel?.activeCarInfo?.location?.locationName,
            license: taskModel?.activeCarInfo?.license,
            carColorName: taskModel?.activeCarInfo?.exteriorColor,
            carColorCode: taskModel?.activeCarInfo?.exteriorColorCode,
          ),
          const AppDivider().paddingSymmetric(vertical: 12),

          //Location and Date
          BorderCardTile(
            leading: const Icon(Icons.location_on_rounded, color: AppColors.primaryColor, size: 20),
            title: taskModel?.task?.type == TaskTypeEnum.pickUp.value
                ? taskModel?.task?.locationId?.toString() ?? '${locale?.notAvailable}'
                : taskModel?.task?.address ?? '${locale?.notAvailable}',
            subTitle:
                '${taskModel?.task?.type?.toCapitalized()} ${taskModel?.task?.type == TaskTypeEnum.pickUp.value ? 'location' : 'address'}',
          ).paddingOnly(bottom: 10),
          BorderCardTile(
            leading: const Icon(Icons.watch_later, color: AppColors.primaryColor, size: 20),
            title: readableDate(taskModel?.task?.date ?? DateTime.now(), pattern: AppString.readableDateFormat),
            secondaryTitle: readableDate(
              taskModel?.task?.date ?? DateTime.now(),
              pattern: AppString.readableTimeFormat,
            ),
            subTitle: '${taskModel?.task?.type?.toCapitalized()} ${locale?.time}',
          ).paddingOnly(bottom: 20),

          // Note
          BodyText(text: taskModel?.task?.note ?? '${locale?.notAvailable}').paddingOnly(bottom: 20),
          OutlineButton(
            onTap: () {
              final latitude = taskModel?.task?.location?.latitude;
              final longitude = taskModel?.task?.location?.longitude;
              final destinationAddress = taskModel?.task?.location?.locationName;
              if (latitude == null || longitude == null) {
                showToast('${locale?.addressNotFound}');
                return;
              }
              Get.toNamed(
                RouterPaths.carDirection,
                arguments: {
                  ArgumentsKey.latitude: latitude,
                  ArgumentsKey.longitude: longitude,
                  ArgumentsKey.destinationAddress: destinationAddress,
                },
              );
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(Icons.location_on_rounded, color: AppColors.primaryColor, size: 18),
                ButtonText(text: ' ${locale?.newCarDirection}', textColor: AppColors.primaryColor),
              ],
            ),
          ),
        ],
      ),
    ).paddingOnly(bottom: 10);
  }
}
