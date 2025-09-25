import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constants/app_color.dart';
import '../../../../shared/widgets/border_card_widget.dart';
import '../../../../shared/widgets/text_widget.dart';
import '../../model/driver_permission_radio_model.dart';

class DriverPermissionRadioWidget extends StatefulWidget {
  final List<DriverPermissionRadioModel> permissionList;
  final ValueChanged<DriverPermissionRadioModel> onChanged;

  const DriverPermissionRadioWidget({
    super.key,
    required this.permissionList,
    required this.onChanged,
  });

  @override
  State<DriverPermissionRadioWidget> createState() =>
      _DriverPermissionRadioWidgetState();
}

class _DriverPermissionRadioWidgetState
    extends State<DriverPermissionRadioWidget> {
  List<DriverPermissionRadioModel> _permissions = [];
  int groupValue = 0;

  @override
  void initState() {
    super.initState();
    _permissions = List.from(widget.permissionList);
    widget.onChanged(_permissions.first);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: widget.permissionList.map((handoverMethod) {
        return BorderCardWidget(
          contentPadding:
              const EdgeInsets.only(left: 8, right: 16, top: 8, bottom: 8),
          backgroundColor: groupValue == handoverMethod.radioValue
              ? AppColors.primaryColor.withOpacity(0.1)
              : AppColors.lightCardColor,
          borderColor: groupValue == handoverMethod.radioValue
              ? AppColors.primaryColor.withOpacity(0.1)
              : null,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Radio<int>(
                visualDensity: VisualDensity.compact,
                value: handoverMethod.radioValue,
                groupValue: groupValue,
                onChanged: (value) {
                  setState(() => groupValue = value!);
                  for (var item in _permissions) {
                    if (item.radioValue == groupValue) {
                      widget.onChanged(item);
                      break;
                    }
                  }
                },
              ).paddingOnly(right: 4),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SmallText(
                      text: '${handoverMethod.permissionType}',
                      textColor: groupValue == handoverMethod.radioValue
                          ? AppColors.lightTextColor
                          : AppColors.lightSecondaryTextColor,
                      fontWeight: FontWeight.w700,
                    ).paddingOnly(bottom: 2),
                    ExtraSmallText(
                      text: '${handoverMethod.description}',
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
