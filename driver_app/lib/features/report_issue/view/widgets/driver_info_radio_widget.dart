import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../../../../shared/widgets/border_card_widget.dart';
import '../../../../shared/widgets/text_widget.dart';
import '../../../../core/constants/app_color.dart';
import '../../model/driver_info_model.dart';

class DriverInfoRadioWidget extends StatefulWidget {
  final List<DriverInfoModel> driverInfoList;
  final ValueChanged<DriverInfoModel> onChanged;

  const DriverInfoRadioWidget({
    super.key,
    required this.driverInfoList,
    required this.onChanged,
  });

  @override
  State<DriverInfoRadioWidget> createState() => _DriverInfoRadioWidgetState();
}

class _DriverInfoRadioWidgetState extends State<DriverInfoRadioWidget> {
  List<DriverInfoModel> _drivers = [];
  int groupValue = 0;

  @override
  void initState() {
    super.initState();
    _drivers = List.from(widget.driverInfoList);
    widget.onChanged(_drivers.first);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: widget.driverInfoList.map((driver) {
        return BorderCardWidget(
          contentPadding: const EdgeInsets.only(left: 8, right: 16, top: 8, bottom: 8),
          backgroundColor:
              groupValue == driver.radioValue ? AppColors.primaryColor.withOpacity(0.1) : AppColors.lightCardColor,
          borderColor: groupValue == driver.radioValue ? AppColors.primaryColor.withOpacity(0.1) : null,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Radio<int>(
                visualDensity: VisualDensity.compact,
                value: driver.radioValue,
                groupValue: groupValue,
                onChanged: (value) {
                  setState(() => groupValue = value!);
                  for (var item in _drivers) {
                    if (item.radioValue == groupValue) {
                      widget.onChanged(item);
                      break;
                    }
                  }
                },
              ),
              // Photo
              if (driver.imageUrl != null)
                const Icon(
                  Icons.account_circle,
                  size: 36,
                  color: AppColors.lightSecondaryTextColor,
                ).paddingOnly(right: 4),

              // Name & type
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Driver name
                    SmallText(
                      text: '${driver.name}',
                      textColor: groupValue == driver.radioValue
                          ? AppColors.lightTextColor
                          : AppColors.lightSecondaryTextColor,
                      fontWeight: FontWeight.w700,
                    ).paddingOnly(bottom: 2),

                    // Driver type
                    if (driver.driverType != null)
                      ExtraSmallText(
                        text: '${driver.driverType}',
                        textColor: AppColors.lightSecondaryTextColor,
                        fontWeight: FontWeight.w500,
                      )
                  ],
                ),
              ),
            ],
          ),
        ).paddingOnly(bottom: 10);
      }).toList(),
    );
  }
}
