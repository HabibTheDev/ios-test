import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';

import '../../../../core/constants/app_color.dart';
import '../../../../shared/widgets/border_card_widget.dart';
import '../../../../shared/widgets/text_widget.dart';
import '../../model/finishing_doc_model.dart';

class FinishingDocCheckboxWidget extends StatefulWidget {
  const FinishingDocCheckboxWidget({
    super.key,
    required this.finishingDocsList,
    required this.onSelectionChanged,
  });

  final List<FinishingDocModel> finishingDocsList;
  final ValueChanged<List<FinishingDocModel>> onSelectionChanged;

  @override
  State<FinishingDocCheckboxWidget> createState() => _FinishingDocCheckboxWidgetState();
}

class _FinishingDocCheckboxWidgetState extends State<FinishingDocCheckboxWidget> {
  List<FinishingDocModel> _finishingDocs = [];

  @override
  void initState() {
    super.initState();
    _finishingDocs = List.from(widget.finishingDocsList);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: _finishingDocs.map((finishingDoc) {
        return BorderCardWidget(
          borderColor: finishingDoc.checkValue ? AppColors.primaryColor.withOpacity(0.4) : null,
          backgroundColor: finishingDoc.checkValue ? AppColors.primaryColor.withOpacity(0.07) : null,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CheckboxListTile(
                controlAffinity: ListTileControlAffinity.leading,
                contentPadding: const EdgeInsets.only(right: 12, top: 4, bottom: 4),
                dense: true,
                visualDensity: VisualDensity.compact,
                value: finishingDoc.checkValue,
                onChanged: (bool? value) {
                  setState(() {
                    finishingDoc.checkValue = value ?? false;
                    _finishingDocs = List.from(widget.finishingDocsList);
                    widget.onSelectionChanged(_finishingDocs);
                  });
                },
                title: SmallText(
                  text: finishingDoc.docName,
                  textColor: finishingDoc.checkValue ? AppColors.lightTextColor : AppColors.lightSecondaryTextColor,
                  fontWeight: FontWeight.w700,
                ),
              ),
              if (finishingDoc.checkValue)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SmallText(text: finishingDoc.description!).paddingOnly(bottom: 16),
                    DottedBorder(
                      dashPattern: const [8],
                      radius: const Radius.circular(8),
                      borderType: BorderType.RRect,
                      color: AppColors.lightTextFieldHintColor,
                      child: Container(
                        height: 120,
                        width: double.infinity,
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                          color: AppColors.lightCardColor,
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Icon(Icons.file_upload_outlined, color: AppColors.primaryColor, size: 24),
                            const BodyText(
                              text: 'Add file or photo',
                              textColor: AppColors.primaryColor,
                              fontWeight: FontWeight.w700,
                            ),
                            SmallText(
                              text: finishingDoc.attachmentInstruction!,
                              textColor: AppColors.lightSecondaryTextColor,
                            ),
                          ],
                        ),
                      ),
                    ).paddingOnly(bottom: 16)
                  ],
                ).paddingSymmetric(horizontal: 12),
            ],
          ),
        ).paddingSymmetric(vertical: 4);
      }).toList(),
    );
  }
}
