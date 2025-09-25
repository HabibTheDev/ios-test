import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../../../../shared/widgets/border_card_widget.dart';
import '../../../../shared/widgets/text_widget.dart';
import '../../../../core/constants/app_color.dart';
import '../../model/anybody_hurt_model.dart';

class AnybodyHurtRadioWidget extends StatefulWidget {
  final List<AnybodyHurtModel> anybodyHurtList;
  final ValueChanged<AnybodyHurtModel> onChanged;

  const AnybodyHurtRadioWidget({
    super.key,
    required this.anybodyHurtList,
    required this.onChanged,
  });

  @override
  State<AnybodyHurtRadioWidget> createState() => _AnybodyHurtRadioWidgetState();
}

class _AnybodyHurtRadioWidgetState extends State<AnybodyHurtRadioWidget> {
  List<AnybodyHurtModel> _anybodyHurtList = [];
  int groupValue = 0;

  @override
  void initState() {
    super.initState();
    _anybodyHurtList = List.from(widget.anybodyHurtList);
    widget.onChanged(_anybodyHurtList.first);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: widget.anybodyHurtList.map((anybodyHurt) {
        return BorderCardWidget(
          contentPadding: const EdgeInsets.only(left: 8, right: 16, top: 8, bottom: 8),
          backgroundColor:
              groupValue == anybodyHurt.radioValue ? AppColors.primaryColor.withOpacity(0.1) : AppColors.lightCardColor,
          borderColor: groupValue == anybodyHurt.radioValue ? AppColors.primaryColor.withOpacity(0.1) : null,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Radio<int>(
                visualDensity: VisualDensity.compact,
                value: anybodyHurt.radioValue,
                groupValue: groupValue,
                onChanged: (value) {
                  setState(() => groupValue = value!);
                  for (var item in _anybodyHurtList) {
                    if (item.radioValue == groupValue) {
                      widget.onChanged(item);
                      break;
                    }
                  }
                },
              ),

              // title
              Expanded(
                  child: SmallText(
                text: '${anybodyHurt.title}',
                textColor:
                    groupValue == anybodyHurt.radioValue ? AppColors.lightTextColor : AppColors.lightSecondaryTextColor,
                fontWeight: FontWeight.w700,
              )),
            ],
          ),
        ).paddingOnly(bottom: 10);
      }).toList(),
    );
  }
}
