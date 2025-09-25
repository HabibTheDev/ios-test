import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:employee_app/core/l10n/app_localizations.dart';

import '../../../../core/constants/app_color.dart';
import '../../../../shared/model/single_task/regular_servicing_checklist_model.dart';
import '../../../../shared/widgets/border_card_widget.dart';
import '../../../../shared/widgets/expandable_widget.dart';
import '../../../../shared/widgets/widget_imports.dart';

class RegularServicingChecklistWidget extends StatefulWidget {
  const RegularServicingChecklistWidget({super.key, required this.regularServicingChecklist, this.onSelectionChanged});
  final List<RegularServicingChecklistModel> regularServicingChecklist;
  final Function(List<RegularServicingChecklistModel>)? onSelectionChanged;

  @override
  State<RegularServicingChecklistWidget> createState() => _RegularServicingChecklistWidgetState();
}

class _RegularServicingChecklistWidgetState extends State<RegularServicingChecklistWidget> {
  late List<RegularServicingChecklistModel> _regularServicingChecklist;

  @override
  void initState() {
    _regularServicingChecklist = widget.regularServicingChecklist;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context);
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _regularServicingChecklist.length,
      separatorBuilder: (context, index) => const HeightBox(height: 10),
      itemBuilder: (context, index) {
        return BorderCardWidget(
          child: ExpandableWidget(
            title: SmallText(
                    text: _regularServicingChecklist[index].checkListTitle ?? '${locale?.notAvailable}',
                    fontWeight: FontWeight.w700)
                .paddingOnly(left: 12),
            trailing: const RotatedBox(
              quarterTurns: -1,
              child: Icon(
                Icons.subdirectory_arrow_left_rounded,
                color: AppColors.lightSecondaryTextColor,
                size: 18,
              ),
            ).paddingOnly(right: 10),
            children: [
              ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.all(12),
                  itemCount: _regularServicingChecklist[index].checkList!.length,
                  separatorBuilder: (context, i) => HeightBox(height: widget.onSelectionChanged != null ? 0 : 10),
                  itemBuilder: (context, i) {
                    final checkList = _regularServicingChecklist[index].checkList?[i];
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment:
                          widget.onSelectionChanged != null ? CrossAxisAlignment.center : CrossAxisAlignment.start,
                      children: [
                        widget.onSelectionChanged != null
                            ? Transform.scale(
                                scale: .8,
                                child: Checkbox(
                                    visualDensity: VisualDensity.compact,
                                    value: checkList?.isChecked,
                                    fillColor: checkList?.isChecked == true
                                        ? const WidgetStatePropertyAll(AppColors.primaryColor)
                                        : null,
                                    side: const BorderSide(color: AppColors.lightSecondaryTextColor, width: 1.5),
                                    onChanged: (value) {
                                      setState(() {
                                        checkList?.isChecked = value ?? false;
                                        widget.onSelectionChanged!(_regularServicingChecklist);
                                      });
                                    }),
                              )
                            : const Icon(Icons.check, color: AppColors.primaryColor, size: 14).paddingOnly(right: 8),
                        Expanded(
                          child: SmallText(
                              text: _regularServicingChecklist[index].checkList?[i].title ?? '${locale?.notAvailable}',
                              textColor: AppColors.lightSecondaryTextColor),
                        )
                      ],
                    );
                  })
            ],
          ),
        );
      },
    );
  }
}
