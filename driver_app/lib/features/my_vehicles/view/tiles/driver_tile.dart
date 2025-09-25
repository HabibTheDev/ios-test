import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constants/app_color.dart';
import '../../../../core/router/router_paths.dart';
import '../../../../shared/tiles/info_tile.dart';
import '../../../../shared/tiles/status_label_tile.dart';
import '../../../../shared/tiles/three_item_info_tile.dart';
import '../../../../shared/widgets/card_widget.dart';
import '../../../../shared/widgets/outline_button.dart';
import '../../../../shared/widgets/text_widget.dart';
import '../../../../shared/widgets/warning_note_widget.dart';
import '../../../../shared/widgets/widthbox.dart';
import '../../../more/view/tiles/driver_info_tile.dart';
import '../../controller/driver_controller.dart';
import '../../model/day_slot_model.dart';

class DriverTile extends StatelessWidget {
  const DriverTile({super.key, required this.awaiting, required this.verified, required this.fullAccess});
  final bool awaiting;
  final bool verified;
  final bool fullAccess;

  @override
  Widget build(BuildContext context) {
    final DriverController controller = Get.find();
    return CardWidget(
      contentPadding: const EdgeInsets.all(12),
      child: Column(
        children: [
          // Driver details
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(child: DriverInfoTile(verified: verified)),
              if (awaiting) const StatusLabelTile(status: 'Awaiting', statusColor: AppColors.awaitingColor)
            ],
          ).paddingOnly(bottom: 20),

          // Note
          if (awaiting)
            WarningNoteWidget(
              child: RichText(
                text: const TextSpan(
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: AppColors.lightTextColor),
                  children: [
                    TextSpan(text: 'Driver is added. Pending '),
                    TextSpan(
                        text: 'verification',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                        )),
                    TextSpan(text: ' of his driver’s license.'),
                  ],
                ),
              ),
            ).paddingOnly(bottom: 20),

          // Permission
          !awaiting
              ? fullAccess
                  ? const InfoTile(titleKey: 'Permission', titleValue: 'Full access').paddingOnly(bottom: 30)
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const ThreeItemInfoTile(
                          leadingText: 'Permission',
                          titleText: '10:30 AM - 05:10 PM',
                          trailingText: '(7 hrs)',
                        ).paddingOnly(bottom: 16),
                        Wrap(
                          children: DaySlotModel.daySlotList
                              .map(
                                (item) => Container(
                                  alignment: Alignment.center,
                                  margin: const EdgeInsets.only(right: 5),
                                  height: 38,
                                  width: 38,
                                  decoration: BoxDecoration(
                                      color: item.checkValue ? AppColors.lightTextFieldFillColor : null,
                                      shape: BoxShape.circle),
                                  child: BodyText(
                                    text: item.day[0],
                                    textColor: !item.checkValue ? AppColors.lightCurrentUserChatColor : null,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              )
                              .toList(),
                        )
                      ],
                    ).paddingOnly(bottom: 30)
              : const SizedBox.shrink(),

          // Delete & Edit Button
          awaiting
              ? OutlineButton(
                  onTap: () => controller.deleteDriverOnTap(),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.delete,
                        color: AppColors.errorColor,
                        size: 18,
                      ),
                      ButtonText(
                        text: 'Delete',
                        textColor: AppColors.errorColor,
                      )
                    ],
                  ),
                )
              : Row(
                  children: [
                    Expanded(
                      child: OutlineButton(
                        onTap: () => controller.deleteDriverOnTap(),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.delete,
                              color: AppColors.errorColor,
                              size: 18,
                            ),
                            ButtonText(
                              text: ' Delete',
                              textColor: AppColors.errorColor,
                            )
                          ],
                        ),
                      ),
                    ),
                    const WidthBox(width: 10),
                    Expanded(
                      child: OutlineButton(
                        onTap: () => Get.toNamed(RouterPaths.editDriverAccess),
                        primaryColor: AppColors.primaryColor,
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.phonelink_lock_rounded,
                              color: AppColors.primaryColor,
                              size: 18,
                            ),
                            ButtonText(
                              text: ' Edit access',
                              textColor: AppColors.primaryColor,
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                )
        ],
      ),
    );
  }
}
