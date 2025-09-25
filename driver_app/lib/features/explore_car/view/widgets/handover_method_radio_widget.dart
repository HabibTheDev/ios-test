import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../../../../shared/widgets/border_card_widget.dart';
import '../../../../shared/widgets/text_widget.dart';
import '../../../../core/constants/app_color.dart';
import '../../model/handover_method_radio_model.dart';

class HandoverMethodRadioWidget extends StatefulWidget {
  final List<HandoverMethodRadioModel> handoverMethodList;
  final ValueChanged<HandoverMethodRadioModel> onChanged;

  const HandoverMethodRadioWidget({
    super.key,
    required this.handoverMethodList,
    required this.onChanged,
  });

  @override
  State<HandoverMethodRadioWidget> createState() =>
      _HandoverMethodRadioWidgetState();
}

class _HandoverMethodRadioWidgetState extends State<HandoverMethodRadioWidget> {
  List<HandoverMethodRadioModel> _handoverMethods = [];
  int groupValue = 0;

  @override
  void initState() {
    super.initState();
    _handoverMethods = List.from(widget.handoverMethodList);
    widget.onChanged(_handoverMethods.first);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: widget.handoverMethodList.map((handoverMethod) {
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
                  for (var item in _handoverMethods) {
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
                      text: '${handoverMethod.method}',
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
              RichText(
                text: TextSpan(
                  style: const TextStyle(
                      color: AppColors.lightTextColor,
                      fontSize: 10,
                      fontWeight: FontWeight.w500),
                  children: [
                    TextSpan(
                        text: handoverMethod.rate,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                        )),
                    const TextSpan(text: '\$'),
                  ],
                ),
              )
            ],
          ),
        ).paddingOnly(bottom: 10);
      }).toList(),
    );
  }
}
