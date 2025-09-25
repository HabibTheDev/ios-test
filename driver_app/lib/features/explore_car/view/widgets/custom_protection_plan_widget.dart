import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../../../../shared/widgets/app_divider.dart';
import '../../../../shared/widgets/border_card_widget.dart';
import '../../../../shared/widgets/outline_text_button.dart';
import '../../../../shared/widgets/solid_text_button.dart';
import '../../../../shared/widgets/text_widget.dart';
import '../../../../core/constants/app_color.dart';
import '../../../../shared/widgets/widthbox.dart';
import '../../model/protection_plan_model.dart';

class CustomProtectionPlanWidget extends StatefulWidget {
  const CustomProtectionPlanWidget({super.key, required this.customProtectionList, required this.onSelectionChanged});
  final List<CustomProtectionModel> customProtectionList;
  final ValueChanged<List<CustomProtectionModel>> onSelectionChanged;

  @override
  State<CustomProtectionPlanWidget> createState() => _CustomProtectionPlanWidgetState();
}

class _CustomProtectionPlanWidgetState extends State<CustomProtectionPlanWidget> {
  List<CustomProtectionModel> _selectedProtections = [];
  bool _selectAll = false;
  double total = 0.0;

  @override
  void initState() {
    super.initState();
    _selectedProtections = List.from(widget.customProtectionList);
    widget.onSelectionChanged(_selectedProtections);
    calculateTotal();
  }

  void _toggleSelectAll() {
    setState(() {
      _selectAll = !_selectAll;
      if (_selectAll == true) {
        _selectedProtections = _selectedProtections.map((protection) {
          return protection.copyWith(checkValue: _selectAll);
        }).toList();
      } else {
        _selectedProtections = List.from(widget.customProtectionList);
      }
    });
    widget.onSelectionChanged(_selectedProtections);
  }

  void calculateTotal() {
    total = 0.0;
    for (var e in _selectedProtections) {
      if (e.checkValue == true) {
        total = total + e.coveragePrice!;
      }
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  // Select all Button
                  BorderCardWidget(
                    contentPadding: const EdgeInsets.only(top: 12, bottom: 12, right: 12),
                    child: CheckboxListTile(
                      value: _selectAll,
                      onChanged: (value) {
                        _toggleSelectAll();
                        calculateTotal();
                      },
                      title: const SmallText(
                        text: 'Select all coverages',
                        fontWeight: FontWeight.w700,
                      ),
                      controlAffinity: ListTileControlAffinity.leading,
                      contentPadding: EdgeInsets.zero,
                      dense: true,
                      visualDensity: VisualDensity.compact,
                    ),
                  ),

                  // Items
                  Column(
                    children: _selectedProtections.map((protection) {
                      return BorderCardWidget(
                        borderColor: protection.checkValue ? AppColors.primaryColor.withOpacity(0.4) : null,
                        backgroundColor: protection.checkValue ? AppColors.primaryColor.withOpacity(0.07) : null,
                        child: CheckboxListTile(
                          controlAffinity: ListTileControlAffinity.leading,
                          contentPadding: const EdgeInsets.only(right: 12, top: 12, bottom: 12),
                          dense: true,
                          visualDensity: VisualDensity.compact,
                          value: protection.checkValue,
                          onChanged: _selectAll
                              ? null
                              : (bool? value) {
                                  setState(() {
                                    protection.checkValue = value ?? false;
                                    _selectedProtections = List.from(widget.customProtectionList);
                                    widget.onSelectionChanged(_selectedProtections);
                                  });
                                  calculateTotal();
                                },
                          title: SmallText(
                            text: protection.coverageTitle ?? "N/A",
                            textColor:
                                protection.checkValue ? AppColors.lightTextColor : AppColors.lightSecondaryTextColor,
                            fontWeight: FontWeight.w700,
                          ),
                          subtitle: SmallText(
                            text: protection.description ?? 'N/A',
                            textColor: AppColors.lightSecondaryTextColor,
                          ),
                          secondary: RichText(
                            text: TextSpan(
                              style: const TextStyle(
                                  color: AppColors.lightSecondaryTextColor, fontSize: 12, fontWeight: FontWeight.w500),
                              children: [
                                TextSpan(
                                    text: '${protection.coveragePrice ?? 0.0}',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w600, fontSize: 18, color: AppColors.lightTextColor)),
                                const TextSpan(text: '\$', style: TextStyle(color: AppColors.lightTextColor)),
                                const TextSpan(text: ' /m'),
                              ],
                            ),
                          ),
                        ),
                      ).paddingOnly(top: 5, bottom: 5);
                    }).toList(),
                  ),
                ],
              ),
            ),
          ),
          Column(
            children: [
              const AppDivider().paddingOnly(bottom: 16),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const TitleText(
                      text: 'Total',
                      textSize: 16,
                    ),
                    TitleText(
                      text: '\$$total',
                      textSize: 24,
                      fontWeight: FontWeight.w700,
                    )
                  ]).paddingOnly(left: 16, right: 16, bottom: 16),
              //Button
              Row(
                children: [
                  Expanded(
                    child: OutlineTextButton(
                      buttonText: 'Cancel',
                      onTap: () {
                        widget.onSelectionChanged(_selectedProtections);
                        Get.back();
                      },
                    ),
                  ),
                  const WidthBox(width: 8),
                  Expanded(
                    child: SolidTextButton(
                      buttonText: 'Add',
                      onTap: () {
                        widget.onSelectionChanged(_selectedProtections);
                        Get.back();
                      },
                    ),
                  ),
                ],
              ).paddingOnly(left: 16, right: 16)
            ],
          ).paddingOnly(bottom: 16)
        ],
      ),
    );
  }
}
