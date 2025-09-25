import 'dart:async';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/app_list.dart';
import '../../../../shared/widgets/basic_dropdown.dart';
import '../../../../shared/widgets/border_card_widget.dart';
import '../../../../shared/widgets/text_field_widget.dart';
import '../../../../shared/widgets/text_widget.dart';
import '../../../../core/constants/app_color.dart';
import '../../model/incident_location_model.dart';

class IncidentLocationRadioWidget extends StatefulWidget {
  final List<IncidentLocationModel> locationList;
  final ValueChanged<IncidentLocationModel> onChanged;

  const IncidentLocationRadioWidget({
    super.key,
    required this.locationList,
    required this.onChanged,
  });

  @override
  State<IncidentLocationRadioWidget> createState() => _IncidentLocationRadioWidgetState();
}

class _IncidentLocationRadioWidgetState extends State<IncidentLocationRadioWidget> {
  List<IncidentLocationModel> _locationList = [];
  int groupValue = 0;
  Timer? debounceTimer;

  @override
  void initState() {
    super.initState();
    _locationList = List.from(widget.locationList);
    widget.onChanged(_locationList.first);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: _locationList.map((location) {
        return BorderCardWidget(
          contentPadding: const EdgeInsets.only(left: 8, right: 16, top: 8, bottom: 8),
          backgroundColor:
              groupValue == location.radioValue ? AppColors.primaryColor.withOpacity(0.1) : AppColors.lightCardColor,
          borderColor: groupValue == location.radioValue ? AppColors.primaryColor.withOpacity(0.1) : null,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Radio<int>(
                    visualDensity: VisualDensity.compact,
                    value: location.radioValue,
                    groupValue: groupValue,
                    onChanged: (value) {
                      setState(() => groupValue = value!);
                      for (var item in _locationList) {
                        if (item.radioValue == groupValue) {
                          widget.onChanged(item);
                          break;
                        }
                      }
                    },
                  ),
                  // location
                  Expanded(
                    child: SmallText(
                      text: location.locationName,
                      textColor: groupValue == location.radioValue
                          ? AppColors.lightTextColor
                          : AppColors.lightSecondaryTextColor,
                      fontWeight: FontWeight.w700,
                    ).paddingOnly(bottom: 2),
                  ),
                ],
              ),
              if (location.provinceOrState != null &&
                  location.addressOrLocation != null &&
                  groupValue == location.radioValue) ...{
                BasicDropdown(
                    width: double.infinity,
                    dropdownWidth: 110,
                    bgColor: AppColors.lightCardColor,
                    items: AppList.countryList,
                    selectedValue: location.country,
                    hintText: 'Select',
                    onChanged: (value) {
                      for (var item in _locationList) {
                        if (item.radioValue == groupValue) {
                          final newItem = item.copyWith(country: value);
                          _locationList[_locationList.indexOf(item)] = newItem;
                          setState(() {});
                          widget.onChanged(newItem);
                          break;
                        }
                      }
                    }),
                TextFormFieldWidget(
                  controller: location.provinceOrState!,
                  hintText: 'Province / State',
                  required: true,
                  fillColor: AppColors.lightCardColor,
                  onChanged: (value) {
                    debouncing(fn: () {
                      for (var item in _locationList) {
                        if (item.radioValue == groupValue) {
                          final newItem = item.copyWith(provinceOrState: location.provinceOrState!);
                          _locationList[_locationList.indexOf(item)] = newItem;
                          widget.onChanged(newItem);
                          break;
                        }
                      }
                    });
                  },
                ).paddingOnly(top: 10),
                TextFormFieldWidget(
                  controller: location.addressOrLocation!,
                  hintText: 'Address / Location',
                  required: true,
                  fillColor: AppColors.lightCardColor,
                  onChanged: (value) {
                    debouncing(fn: () {
                      for (var item in _locationList) {
                        if (item.radioValue == groupValue) {
                          final newItem = item.copyWith(addressOrLocation: location.addressOrLocation!);
                          _locationList[_locationList.indexOf(item)] = newItem;
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
