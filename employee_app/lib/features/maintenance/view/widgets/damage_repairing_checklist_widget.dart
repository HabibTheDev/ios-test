import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:employee_app/core/l10n/app_localizations.dart';

import '../../../../core/constants/app_color.dart';
import '../../../../core/constants/arguments_key.dart';
import '../../../../core/router/router_paths.dart';
import '../../../../shared/widgets/border_card_widget.dart';
import '../../../../shared/widgets/expandable_widget.dart';
import '../../../../shared/widgets/network_image_widget.dart';
import '../../../../shared/widgets/widget_imports.dart';
import '../../../inbox/model/message_model.dart';
import '../../model/maintenance_repair_damage_model.dart';

class DamageRepairingChecklistWidget extends StatefulWidget {
  const DamageRepairingChecklistWidget({super.key, required this.damageList, this.onSelectionChanged});

  final List<MaintenanceRepairDamageModel> damageList;
  final Function(List<MaintenanceRepairDamageModel>)? onSelectionChanged;

  @override
  State<DamageRepairingChecklistWidget> createState() => _DamageRepairingChecklistWidgetState();
}

class _DamageRepairingChecklistWidgetState extends State<DamageRepairingChecklistWidget> {
  late List<MaintenanceRepairDamageModel> _damageList;

  @override
  void initState() {
    super.initState();
    _damageList = widget.damageList;
  }

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context);
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _damageList.length,
      separatorBuilder: (context, index) => const HeightBox(height: 10),
      itemBuilder: (context, index) {
        final damage = _damageList[index];
        return BorderCardWidget(
          child: ExpandableWidget(
            leading:
                SvgPicture.asset(damage.svgImagePath!, height: 18, width: 18, fit: BoxFit.cover).paddingOnly(left: 10),
            title: SmallText(text: damage.sectionName ?? '${locale?.notAvailable}', fontWeight: FontWeight.w700),
            trailing: const RotatedBox(
              quarterTurns: -1,
              child: Icon(Icons.subdirectory_arrow_left_rounded, color: AppColors.lightSecondaryTextColor, size: 18),
            ).paddingOnly(right: 10),
            children: [
              Table(
                border: TableBorder.all(color: AppColors.lightCurrentUserChatColor, width: 1),
                columnWidths: const {
                  0: FlexColumnWidth(2),
                  1: FlexColumnWidth(3),
                },
                children: [
                  // Header Row
                  TableRow(
                    decoration: BoxDecoration(color: AppColors.primaryColor.withAlpha(18)),
                    children: [
                      SmallText(
                        text: '${locale?.vehicleParts}',
                        textColor: AppColors.lightSecondaryTextColor,
                        fontWeight: FontWeight.w600,
                      ).paddingAll(8),
                      SmallText(
                        text: '${locale?.damagesRequired}',
                        textColor: AppColors.lightSecondaryTextColor,
                        fontWeight: FontWeight.w600,
                      ).paddingAll(8),
                    ],
                  ),

                  // Data Rows
                  if (damage.damageList != null)
                    ...damage.damageList!.map(
                      (damage) {
                        return TableRow(
                          children: [
                            // Area of Damage column
                            BodyText(text: damage.partName?.replaceAll('-', ' ') ?? '${locale?.notAvailable}')
                                .paddingAll(8),

                            // Damages of area list
                            damage.partAreaList!.isEmpty
                                ? const SmallText(text: '-').paddingAll(8)
                                : ListView.separated(
                                    shrinkWrap: true,
                                    physics: const NeverScrollableScrollPhysics(),
                                    itemCount: damage.partAreaList!.length,
                                    separatorBuilder: (context, index) => const AppDivider(
                                      thickness: 1,
                                      height: 0,
                                      color: AppColors.lightCurrentUserChatColor,
                                    ),
                                    itemBuilder: (context, index) {
                                      final area = damage.partAreaList![index];
                                      return Row(
                                        children: [
                                          widget.onSelectionChanged != null
                                              ? Transform.scale(
                                                  scale: .8,
                                                  child: Checkbox(
                                                    visualDensity: VisualDensity.compact,
                                                    value: area.bodyDamage?.checkValue,
                                                    fillColor: area.bodyDamage!.checkValue
                                                        ? const WidgetStatePropertyAll(AppColors.primaryColor)
                                                        : null,
                                                    side: const BorderSide(
                                                        color: AppColors.lightSecondaryTextColor, width: 1.5),
                                                    onChanged: (value) {
                                                      setState(() {
                                                        area.bodyDamage?.checkValue = value ?? false;
                                                        widget.onSelectionChanged!(_damageList);
                                                      });
                                                    },
                                                  ),
                                                )
                                              : InkWell(
                                                  onTap: () {
                                                    if (area.bodyDamage?.image != null) {
                                                      Get.toNamed(
                                                        RouterPaths.filePreview,
                                                        arguments: {
                                                          ArgumentsKey.attachments: [
                                                            Attachment(url: area.bodyDamage?.image)
                                                          ]
                                                        },
                                                      );
                                                    }
                                                  },
                                                  child: NetworkImageWidget(
                                                    imageUrl: area.bodyDamage?.image,
                                                    width: 20,
                                                    height: 20,
                                                    borderRadius: 4,
                                                  ).paddingOnly(left: 8),
                                                ),
                                          Expanded(
                                            child: SmallText(
                                              text:
                                                  '${area.bodyDamage?.count ?? ''} ${area.bodyDamage?.type ?? '${locale?.notAvailable}'}',
                                            ).paddingAll(widget.onSelectionChanged == null ? 8 : 0),
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                          ],
                        );
                      },
                    ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
