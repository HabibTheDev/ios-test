import 'package:flutter/material.dart';

import '../../../../shared/widgets/border_card_widget.dart';
import '../../../../shared/widgets/text_widget.dart';
import '../../../../core/constants/app_color.dart';

class FaqExpandableWidget extends StatefulWidget {
  const FaqExpandableWidget({
    super.key,
    required this.question,
    required this.answer,
    this.isExpanded = false,
  });

  final String question;
  final String answer;
  final bool isExpanded;

  @override
  State<FaqExpandableWidget> createState() => _FaqExpandableWidgetState();
}

class _FaqExpandableWidgetState extends State<FaqExpandableWidget> {
  late bool isExpanded;

  @override
  void initState() {
    super.initState();
    isExpanded = widget.isExpanded;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData().copyWith(dividerColor: Colors.transparent),
      child: BorderCardWidget(
        contentPadding: EdgeInsets.only(left: 12, right: 8, bottom: isExpanded ? 12 : 0),
        borderColor: isExpanded ? AppColors.primaryColor.withOpacity(0.5) : null,
        child: ExpansionTile(
          initiallyExpanded: widget.isExpanded,
          childrenPadding: EdgeInsets.zero,
          tilePadding: EdgeInsets.zero,
          dense: true,
          visualDensity: VisualDensity.compact,
          onExpansionChanged: (value) => setState(() => isExpanded = value),
          trailing: const Icon(
            Icons.keyboard_arrow_down,
            size: 1,
            color: Colors.transparent,
          ),
          leading: AnimatedRotation(
            turns: isExpanded ? 0.25 : 0,
            duration: const Duration(milliseconds: 200),
            child: const Icon(
              Icons.keyboard_arrow_right,
              color: AppColors.lightSecondaryTextColor,
              size: 16,
            ),
          ),
          backgroundColor: AppColors.lightCardColor,
          title: SmallText(
            text: widget.question,
            fontWeight: FontWeight.w600,
          ),
          expandedAlignment: Alignment.centerLeft,
          children: [SmallText(text: widget.answer)],
        ),
      ),
    );
  }
}
