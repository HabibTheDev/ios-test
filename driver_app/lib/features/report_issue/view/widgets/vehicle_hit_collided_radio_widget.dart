import 'dart:async';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../../../../shared/widgets/border_card_widget.dart';
import '../../../../shared/widgets/text_field_widget.dart';
import '../../../../shared/widgets/text_widget.dart';
import '../../../../core/constants/app_color.dart';
import '../../model/vehicle_hit_collided_model.dart';

class VehicleHitCollidedRadioWidget extends StatefulWidget {
  final List<VehicleHitCollidedModel> issueList;
  final ValueChanged<VehicleHitCollidedModel> onChanged;

  const VehicleHitCollidedRadioWidget({
    super.key,
    required this.issueList,
    required this.onChanged,
  });

  @override
  State<VehicleHitCollidedRadioWidget> createState() => _VehicleHitCollidedRadioWidgetState();
}

class _VehicleHitCollidedRadioWidgetState extends State<VehicleHitCollidedRadioWidget> {
  List<VehicleHitCollidedModel> _issueList = [];
  int groupValue = 0;
  Timer? debounceTimer;

  @override
  void initState() {
    super.initState();
    _issueList = List.from(widget.issueList);
    widget.onChanged(_issueList.first);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: _issueList.map((issue) {
        return BorderCardWidget(
          contentPadding: const EdgeInsets.only(left: 8, right: 16, top: 8, bottom: 8),
          backgroundColor:
              groupValue == issue.radioValue ? AppColors.primaryColor.withOpacity(0.1) : AppColors.lightCardColor,
          borderColor: groupValue == issue.radioValue ? AppColors.primaryColor.withOpacity(0.1) : null,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Radio<int>(
                    visualDensity: VisualDensity.compact,
                    value: issue.radioValue,
                    groupValue: groupValue,
                    onChanged: (value) {
                      setState(() => groupValue = value!);
                      for (var item in _issueList) {
                        if (item.radioValue == groupValue) {
                          widget.onChanged(item);
                          break;
                        }
                      }
                    },
                  ),

                  // Issue & description
                  Expanded(
                    child: SmallText(
                      text: '${issue.issue}',
                      textColor:
                          groupValue == issue.radioValue ? AppColors.lightTextColor : AppColors.lightSecondaryTextColor,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              if (issue.customIssue != null && groupValue == issue.radioValue)
                TextFormFieldWidget(
                  controller: issue.customIssue!,
                  hintText: 'Specify your condition',
                  required: true,
                  fillColor: AppColors.lightCardColor,
                  onChanged: (value) {
                    debouncing(fn: () {
                      for (var item in _issueList) {
                        if (item.radioValue == groupValue) {
                          final newItem = item.copyWith(customIssue: issue.customIssue!);
                          _issueList[_issueList.indexOf(item)] = newItem;
                          widget.onChanged(newItem);
                          break;
                        }
                      }
                    });
                  },
                ).paddingOnly(top: 10)
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
