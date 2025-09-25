import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../../shared/widgets/text_widget.dart';
import '../../../../core/constants/app_color.dart';
import '../../model/extra_model.dart';
import 'quantity_button.dart';

class ExtraWidget extends StatefulWidget {
  const ExtraWidget({super.key, required this.extraList, required this.onSelectionChanged});
  final List<ExtraModel> extraList;
  final ValueChanged<List<ExtraModel>> onSelectionChanged;

  @override
  State<ExtraWidget> createState() => _ExtraWidgetState();
}

class _ExtraWidgetState extends State<ExtraWidget> {
  List<ExtraModel> _selectedExtra = [];

  @override
  void initState() {
    super.initState();
    _selectedExtra = List.from(widget.extraList);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: _selectedExtra
          .map((extra) => Container(
                margin: const EdgeInsets.only(bottom: 10),
                padding: const EdgeInsets.all(12),
                decoration: const BoxDecoration(
                    color: AppColors.lightBgColor, borderRadius: BorderRadius.all(Radius.circular(6))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    BodyText(
                      text: '${extra.title}',
                      fontWeight: FontWeight.w600,
                    ).paddingOnly(bottom: 3),

                    // Description
                    RichText(
                      textAlign: TextAlign.start,
                      text: TextSpan(
                        style: const TextStyle(
                            color: AppColors.lightSecondaryTextColor, fontSize: 12, fontWeight: FontWeight.w400),
                        children: [
                          TextSpan(text: '${extra.description} (You can add up to '),
                          TextSpan(
                              text: '${extra.maxUnits}',
                              style: const TextStyle(fontWeight: FontWeight.w600, color: AppColors.lightTextColor)),
                          const TextSpan(text: ' units)'),
                        ],
                      ),
                    ).paddingOnly(bottom: 10),

                    // Rate and Buttons
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 3,
                          child: RichText(
                            text: TextSpan(
                              style: const TextStyle(
                                  color: AppColors.lightSecondaryTextColor, fontSize: 12, fontWeight: FontWeight.w400),
                              children: [
                                TextSpan(
                                    text: '${extra.packagePrice ?? 0.0}',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w600, fontSize: 18, color: AppColors.lightTextColor)),
                                const TextSpan(text: '\$', style: TextStyle(color: AppColors.lightTextColor)),
                                const TextSpan(text: ' /m & unit'),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                            flex: 2,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                QuantityButton(
                                    onTap: () {
                                      if (extra.quantity > 0) {
                                        setState(() => extra.quantity--);
                                        _selectedExtra = List.from(widget.extraList);
                                        widget.onSelectionChanged(_selectedExtra);
                                      }
                                    },
                                    iconData: Icons.remove),
                                TitleText(
                                  text: '${extra.quantity}',
                                  textSize: 16,
                                ),
                                QuantityButton(
                                    onTap: () {
                                      if (extra.quantity < extra.maxUnits!) {
                                        setState(() => extra.quantity++);
                                        _selectedExtra = List.from(widget.extraList);
                                        widget.onSelectionChanged(_selectedExtra);
                                      }
                                    },
                                    iconData: Icons.add),
                              ],
                            ))
                      ],
                    ),
                  ],
                ),
              ))
          .toList(),
    );
  }
}
