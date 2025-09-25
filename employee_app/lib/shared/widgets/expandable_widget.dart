import 'package:flutter/material.dart';

import '../../core/constants/app_color.dart';

class ExpandableWidget extends StatefulWidget {
  const ExpandableWidget({
    super.key,
    this.leading,
    this.trailing,
    required this.title,
    required this.children,
    this.isExpanded = false,
  });

  final Widget? leading;
  final Widget? trailing;
  final Widget title;
  final List<Widget> children;
  final bool isExpanded;

  @override
  State<ExpandableWidget> createState() => _ExpandableWidgetState();
}

class _ExpandableWidgetState extends State<ExpandableWidget> {
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
      data: ThemeData().copyWith(
        dividerColor: Colors.transparent,
        iconTheme: const IconThemeData(color: AppColors.primaryColor),
        radioTheme: RadioThemeData(
          fillColor: WidgetStateProperty.resolveWith<Color>((states) {
            if (states.contains(WidgetState.selected)) {
              return AppColors.primaryColor;
            }
            return Colors.grey;
          }),
        ),
      ),
      child: ExpansionTile(
        leading: widget.leading,
        initiallyExpanded: widget.isExpanded,
        childrenPadding: EdgeInsets.zero,
        tilePadding: EdgeInsets.zero,
        dense: true,
        onExpansionChanged: (value) => setState(() => isExpanded = value),
        trailing: AnimatedRotation(
          turns: isExpanded ? -0.5 : 0,
          duration: const Duration(milliseconds: 200),
          child: widget.trailing ??
              const Icon(Icons.keyboard_arrow_down, color: AppColors.lightSecondaryTextColor, size: 18),
        ),
        backgroundColor: AppColors.lightCardColor,
        title: widget.title,
        children: widget.children,
      ),
    );
  }
}
