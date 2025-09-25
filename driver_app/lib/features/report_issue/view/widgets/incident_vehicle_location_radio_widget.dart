import 'dart:async';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../../../../shared/widgets/border_card_widget.dart';
import '../../../../shared/widgets/text_field_widget.dart';
import '../../../../shared/widgets/text_widget.dart';
import '../../../../core/constants/app_color.dart';
import '../../model/incident_vehicle_location_model.dart';

class IncidentVehicleLocationRadioWidget extends StatefulWidget {
  final List<IncidentVehicleLocationModel> vehicleLocationList;
  final ValueChanged<IncidentVehicleLocationModel> onChanged;

  const IncidentVehicleLocationRadioWidget({
    super.key,
    required this.vehicleLocationList,
    required this.onChanged,
  });

  @override
  State<IncidentVehicleLocationRadioWidget> createState() => _IncidentVehicleLocationRadioWidgetState();
}

class _IncidentVehicleLocationRadioWidgetState extends State<IncidentVehicleLocationRadioWidget> {
  List<IncidentVehicleLocationModel> _vehicleLocationList = [];
  int groupValue = 0;
  Timer? debounceTimer;

  @override
  void initState() {
    super.initState();
    _vehicleLocationList = List.from(widget.vehicleLocationList);
    widget.onChanged(_vehicleLocationList.first);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: _vehicleLocationList.map((vehicleLocation) {
        return BorderCardWidget(
          contentPadding: const EdgeInsets.only(left: 8, right: 16, top: 8, bottom: 8),
          backgroundColor: groupValue == vehicleLocation.radioValue
              ? AppColors.primaryColor.withOpacity(0.1)
              : AppColors.lightCardColor,
          borderColor: groupValue == vehicleLocation.radioValue ? AppColors.primaryColor.withOpacity(0.1) : null,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Radio<int>(
                    visualDensity: VisualDensity.compact,
                    value: vehicleLocation.radioValue,
                    groupValue: groupValue,
                    onChanged: (value) {
                      setState(() => groupValue = value!);
                      for (var item in _vehicleLocationList) {
                        if (item.radioValue == groupValue) {
                          widget.onChanged(item);
                          break;
                        }
                      }
                    },
                  ),
                  // vehicleLocation
                  Expanded(
                    child: SmallText(
                      text: vehicleLocation.locationName,
                      textColor: groupValue == vehicleLocation.radioValue
                          ? AppColors.lightTextColor
                          : AppColors.lightSecondaryTextColor,
                      fontWeight: FontWeight.w700,
                    ).paddingOnly(bottom: 2),
                  ),
                ],
              ),
              if (vehicleLocation.nameController != null &&
                  vehicleLocation.addressController != null &&
                  groupValue == vehicleLocation.radioValue) ...{
                TextFormFieldWidget(
                  controller: vehicleLocation.nameController!,
                  hintText: 'Name',
                  required: true,
                  fillColor: AppColors.lightCardColor,
                  onChanged: (value) {
                    debouncing(fn: () {
                      for (var item in _vehicleLocationList) {
                        if (item.radioValue == groupValue) {
                          final newItem = item.copyWith(nameController: vehicleLocation.nameController!);
                          _vehicleLocationList[_vehicleLocationList.indexOf(item)] = newItem;
                          widget.onChanged(newItem);
                          break;
                        }
                      }
                    });
                  },
                ).paddingOnly(top: 10),
                TextFormFieldWidget(
                  controller: vehicleLocation.addressController!,
                  hintText: 'Address or location',
                  required: true,
                  fillColor: AppColors.lightCardColor,
                  onChanged: (value) {
                    debouncing(fn: () {
                      for (var item in _vehicleLocationList) {
                        if (item.radioValue == groupValue) {
                          final newItem = item.copyWith(addressController: vehicleLocation.addressController!);
                          _vehicleLocationList[_vehicleLocationList.indexOf(item)] = newItem;
                          widget.onChanged(newItem);
                          break;
                        }
                      }
                    });
                  },
                ).paddingOnly(top: 10),
              },
            ],
          ),
        ).paddingOnly(bottom: 10);
      }).toList(),
    );
  }

  void debouncing({required Function() fn, int waitForMs = 1000}) {
    debounceTimer?.cancel();
    debounceTimer = Timer(Duration(milliseconds: waitForMs), fn);
  }
}
