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

class ReturnCarDetailsWidget extends StatelessWidget {
  const ReturnCarDetailsWidget({super.key, required this.taskModel});
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

          // Location
          BorderCardTile(
            leading: const Icon(Icons.location_on_rounded, color: AppColors.primaryColor, size: 20),
            title: taskModel?.task?.type == TaskTypeEnum.dropOff.value
                ? taskModel?.task?.locationId?.toString() ?? '${locale?.notAvailable}'
                : taskModel?.task?.address ?? '${locale?.notAvailable}',
            subTitle:
                '${taskModel?.task?.type?.toCapitalized()} ${taskModel?.task?.type == TaskTypeEnum.dropOff.value ? 'location' : 'address'}',
          ).paddingOnly(bottom: 10),

          // Date & Time
          BorderCardTile(
            leading: const Icon(Icons.watch_later, color: AppColors.primaryColor, size: 20),
            title: readableDate(taskModel?.task?.date ?? DateTime.now(), pattern: AppString.readableDateFormat),
            secondaryTitle: readableDate(
              taskModel?.task?.date ?? DateTime.now(),
              pattern: AppString.readableTimeFormat,
            ),
            subTitle: '${taskModel?.task?.type?.toCapitalized()} ${locale?.time.toLowerCase()}',
          ).paddingOnly(bottom: 20),

          // Note
          BodyText(text: taskModel?.task?.note ?? '${locale?.notAvailable}').paddingOnly(bottom: 20),

          // Car Direction Button
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
                ButtonText(text: '${locale?.carDirection}', textColor: AppColors.primaryColor),
              ],
            ),
          ),
        ],
      ),
    ).paddingOnly(bottom: 10);
  }
}
