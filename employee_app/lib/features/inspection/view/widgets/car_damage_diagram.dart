import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:employee_app/core/l10n/app_localizations.dart';

import '../../../../core/constants/app_color.dart';
import '../../../../shared/enums/car_parts.enum.dart';
import '../../../../shared/utils/utils.dart';
import '../../../../shared/widgets/widget_imports.dart';
import '../../model/damage_parts_svg_model.dart';

class CarDamageDiagram extends StatelessWidget {
  const CarDamageDiagram({super.key, required this.carPartsSvgMap});
  final Map<String, DamagePartsSvgModel>? carPartsSvgMap;

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context);
    return Column(
      children: [
        // Color bar
        if (carPartsSvgMap != null)
          Row(
            children: [
              ExtraSmallText(text: '${locale?.lowDamage}', fontWeight: FontWeight.w500),
              Expanded(
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(6)),
                  child: Row(
                    children: AppColors.damageColorList
                        .map((color) => Expanded(child: Container(height: 10, color: color)))
                        .toList(),
                  ),
                ).paddingSymmetric(horizontal: 8),
              ),
              ExtraSmallText(text: '${locale?.highDamage}', fontWeight: FontWeight.w500),
            ],
          ).paddingOnly(bottom: 30),

        // Diagram
        SizedBox(
          height: 420,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(child: _leftSection(carPartsSvgMap)),
              Expanded(child: _middleSection(carPartsSvgMap)),
              Expanded(child: _rightSection(carPartsSvgMap)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _leftSection(Map<String, DamagePartsSvgModel>? carPartsSvgMap) {
    return SizedBox(
      height: 380,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          // Fender section
          Positioned(
            top: 0,
            right: 0,
            left: 0,
            child: SizedBox(
              height: 154,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Indicator Light Left-Side
                  Positioned(
                    top: 0,
                    left: 52.dg,
                    child: _svgImage(model: carPartsSvgMap?[CarPartsEnum.indicatorLightLeftSide.value]),
                  ),
                  // Side Bumper Front Left Side
                  Positioned(
                    top: 0,
                    left: 16.dg,
                    child: _svgImage(model: carPartsSvgMap?[CarPartsEnum.sideBumperFrontLeftSide.value]),
                  ),
                  // Fender Left Side
                  Positioned(
                    top: 18,
                    right: 0,
                    child: _svgImage(model: carPartsSvgMap?[CarPartsEnum.fenderLeftSide.value]),
                  ),
                  // Arch-Panel-Front-Left-Side
                  Positioned(
                    top: 38,
                    left: 16.dg,
                    child: _svgImage(model: carPartsSvgMap?[CarPartsEnum.archPanelFrontLeftSide.value], height: 56),
                  ),
                  // Wheel section
                  Positioned(
                    left: 0,
                    top: 42,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        _svgImage(
                            model: carPartsSvgMap?[CarPartsEnum.wheelFrontLeftSide.value], height: 46.w, width: 46.w),
                        _svgImage(
                            model: carPartsSvgMap?[CarPartsEnum.alloyRimFrontLeftSide.value], height: 30, width: 30),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Door section
          Positioned(
            left: -8.w,
            bottom: 94,
            right: 0,
            child: SizedBox(
              height: 166,
              width: double.infinity,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Door, Window, Mirror, Handle
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        // Door-Front-Left-Side
                        _svgImage(model: carPartsSvgMap?[CarPartsEnum.doorFrontLeftSide.value]),
                        // Window, Mirror
                        Positioned(
                          right: 4.w,
                          child: Stack(
                            children: [
                              // Window-Front-Left-Side
                              _svgImage(model: carPartsSvgMap?[CarPartsEnum.windowFrontLeftSide.value]),
                              // Side-Mirror-Left-Side
                              Positioned(
                                left: 2.w,
                                top: 4,
                                child: _svgImage(model: carPartsSvgMap?[CarPartsEnum.sideMirrorLeftSide.value]),
                              ),
                            ],
                          ),
                        ),
                        // Exterior Door Handle Front Left Side
                        Positioned(
                          right: 44.w,
                          bottom: 16,
                          child: _svgImage(model: carPartsSvgMap?[CarPartsEnum.exteriorDoorHandleFrontLeftSide.value]),
                        ),
                      ],
                    ),
                  ),
                  // Rear-Door, Window, Handle
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Column(
                      children: [
                        Stack(children: [
                          // door-Rear-Left-Side
                          _svgImage(model: carPartsSvgMap?[CarPartsEnum.doorRearLeftSide.value]),
                          // Window,
                          Positioned(
                            top: 6,
                            right: 4.w,
                            child: _svgImage(model: carPartsSvgMap?[CarPartsEnum.windowRearLeftSide.value]),
                          ),
                          // Exterior Door Handle Front Left Side
                          Positioned(
                            right: 44.w,
                            bottom: 16,
                            child: _svgImage(model: carPartsSvgMap?[CarPartsEnum.exteriorDoorHandleRearLeftSide.value]),
                          ),
                        ]),
                      ],
                    ),
                  ),
                  // Molding-Left-Side
                  Positioned(
                    left: 48.dg,
                    bottom: 20,
                    child: _svgImage(model: carPartsSvgMap?[CarPartsEnum.moldingLeftSide.value]),
                  ),
                ],
              ),
            ),
          ),

          // Side-Rocker-Panel-Left-Side
          Positioned(
            left: 10.dg,
            bottom: 118,
            child: _svgImage(model: carPartsSvgMap?[CarPartsEnum.sideRockerPanelLeftSide.value]),
          ),

          // Quarter Panel section
          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: SizedBox(
              height: 124,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Side Bumper Front Left Side
                  Positioned(
                    bottom: 0,
                    left: 24.dg,
                    child: _svgImage(model: carPartsSvgMap?[CarPartsEnum.sideBumperRearLeftSide.value], height: 52),
                  ),
                  // Quarter-Panel
                  Positioned(
                    top: 18,
                    right: 0,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        // Quarter-Panel-Left-Side
                        _svgImage(model: carPartsSvgMap?[CarPartsEnum.quarterPanelLeftSide.value]),
                        // Quarter-Glass-Left-Side
                        Positioned(
                          top: 18,
                          right: 8,
                          child: _svgImage(model: carPartsSvgMap?[CarPartsEnum.quarterGlassLeftSide.value]),
                        ),
                        // Fuel-Cap
                        Positioned(
                          top: 32,
                          right: 42.w,
                          child: _svgImage(model: carPartsSvgMap?[CarPartsEnum.fuelCap.value]),
                        ),
                        // Indicator-Light-Left-Side
                        Positioned(
                          bottom: 0,
                          child: _svgImage(model: carPartsSvgMap?[CarPartsEnum.indicatorLightLeftSide.value]),
                        ),
                      ],
                    ),
                  ),
                  // Arch-Panel-Front-Left-Side
                  Positioned(
                    top: 30,
                    left: 12.dg,
                    child: _svgImage(model: carPartsSvgMap?[CarPartsEnum.archPanelRearLeftSide.value], height: 56),
                  ),
                  // Wheel section
                  Positioned(
                    left: 0,
                    bottom: 42,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        _svgImage(
                            model: carPartsSvgMap?[CarPartsEnum.wheelRearLeftSide.value], height: 44.w, width: 44.w),
                        _svgImage(
                            model: carPartsSvgMap?[CarPartsEnum.alloyRimRearLeftSide.value], height: 30, width: 30),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _middleSection(Map<String, DamagePartsSvgModel>? carPartsSvgMap) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        // Roof section
        Positioned(
          left: 10.w,
          right: 10.w,
          top: 154,
          bottom: 116,
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              // Roof - left,right,front,rear
              _svgImage(model: carPartsSvgMap?[CarPartsEnum.roofLeftSide.value]),
              _svgImage(model: carPartsSvgMap?[CarPartsEnum.roofRightSide.value]),
              _svgImage(model: carPartsSvgMap?[CarPartsEnum.roofFrontSide.value]),
              _svgImage(model: carPartsSvgMap?[CarPartsEnum.roofRearSide.value]),
              // Roof Rail Left Side
              Positioned(
                left: 18.w,
                child: _svgImage(model: carPartsSvgMap?[CarPartsEnum.roofRailLeftSide.value]),
              ),
              // Roof Rail Right Side
              Positioned(
                right: 18.w,
                child: _svgImage(model: carPartsSvgMap?[CarPartsEnum.roofRailRightSide.value]),
              ),
              // Antenna
              Positioned(bottom: 20, child: _svgImage(model: carPartsSvgMap?[CarPartsEnum.antenna.value])),
            ],
          ),
        ),

        // Front Bumper light section
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: SizedBox(
            height: 44,
            child: Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: [
                // Front-bumper
                Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: _svgImage(model: carPartsSvgMap?[CarPartsEnum.bumperFrontSide.value])),
                // Fog-light
                Positioned(
                    top: 10,
                    left: 8.w,
                    child: _svgImage(model: carPartsSvgMap?[CarPartsEnum.fogLightFrontLeftSide.value])),
                Positioned(
                    top: 10,
                    right: 8.w,
                    child: _svgImage(model: carPartsSvgMap?[CarPartsEnum.fogLightFrontRightSide.value])),
                // Grille Front Side
                Positioned(
                  top: 10,
                  child: _svgImage(model: carPartsSvgMap?[CarPartsEnum.grilleFrontSide.value], width: 48.w),
                ),
                // Head-light
                Positioned(
                  bottom: 0,
                  left: -4.w,
                  child: _svgImage(model: carPartsSvgMap?[CarPartsEnum.headLightLeftSide.value], width: 30.w),
                ),
                Positioned(
                  bottom: 0,
                  right: -4.w,
                  child: _svgImage(model: carPartsSvgMap?[CarPartsEnum.headLightRightSide.value], width: 30.w),
                ),
              ],
            ),
          ),
        ),

        // Hood & Windshield section
        Positioned(
          top: 44,
          left: 0,
          right: 0,
          child: SizedBox(
            height: 120,
            child: Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: [
                // Hood
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: _svgImage(model: carPartsSvgMap?[CarPartsEnum.hood.value], fit: BoxFit.fitWidth),
                ),
                // Windshield
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: SizedBox(
                    height: 64,
                    child: Stack(
                      clipBehavior: Clip.none,
                      alignment: Alignment.center,
                      children: [
                        // Windshield
                        _svgImage(
                            model: carPartsSvgMap?[CarPartsEnum.windshieldFrontSide.value], topLeft: 20, topRight: 20),
                        // Windshield Wiper
                        Positioned(
                          top: 8,
                          child: _svgImage(model: carPartsSvgMap?[CarPartsEnum.wiperFrontSide.value]),
                        ),
                      ],
                    ),
                  ),
                ),
                // Logo-front
                Positioned(
                  top: 12,
                  child: _svgImage(model: carPartsSvgMap?[CarPartsEnum.logoFrontSide.value]),
                ),
              ],
            ),
          ),
        ),

        // Spoiler, Trunk RearWindshield section
        Positioned(
          bottom: 60,
          left: 0,
          right: 0,
          child: SizedBox(
            height: 74,
            child: Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: [
                // Spoiler
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: _svgImage(model: carPartsSvgMap?[CarPartsEnum.spoiler.value]),
                ),
                // Trunk
                Positioned(
                  bottom: 6,
                  left: 0,
                  right: 0,
                  child: _svgImage(model: carPartsSvgMap?[CarPartsEnum.trunk.value], bottomLeft: 12, bottomRight: 12),
                ),
                // Windshield Rear Side
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: SizedBox(
                    height: 44,
                    child: Stack(
                      clipBehavior: Clip.none,
                      alignment: Alignment.center,
                      children: [
                        // Windshield-Rear-Side
                        _svgImage(
                            model: carPartsSvgMap?[CarPartsEnum.windshieldRearSide.value],
                            bottomLeft: 12,
                            bottomRight: 12),
                        // Brake-Light
                        Positioned(
                          top: 10,
                          child: _svgImage(model: carPartsSvgMap?[CarPartsEnum.brakeLight.value]),
                        ),
                        // Wiper-Rear-Side
                        Positioned(
                          bottom: 8,
                          child: _svgImage(model: carPartsSvgMap?[CarPartsEnum.wiperRearSide.value]),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        // Rear-Bumper light section
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: SizedBox(
            height: 54,
            child: Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: [
                // Rear-bumper
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: _svgImage(model: carPartsSvgMap?[CarPartsEnum.bumperRearSide.value]),
                ),
                // Grille_Rear-Side
                Positioned(
                  bottom: 28,
                  child: _svgImage(model: carPartsSvgMap?[CarPartsEnum.grilleRearSide.value], width: 42.w),
                ),
                // License-plate
                Positioned(
                  bottom: 6,
                  child: _svgImage(model: carPartsSvgMap?[CarPartsEnum.licensePlate.value], width: 28.w),
                ),
                // Fog-light-left
                Positioned(
                  bottom: 10,
                  left: 8.w,
                  child: _svgImage(model: carPartsSvgMap?[CarPartsEnum.fogLightRearLeftSide.value]),
                ),
                // Fog-light-right
                Positioned(
                  bottom: 10,
                  right: 8.w,
                  child: _svgImage(model: carPartsSvgMap?[CarPartsEnum.fogLightRearRightSide.value]),
                ),
                // Tail-light-left
                Positioned(
                  top: 0,
                  left: 4.w,
                  child: _svgImage(model: carPartsSvgMap?[CarPartsEnum.tailLightLeftSide.value], width: 30.w),
                ),
                // Tail-light-right
                Positioned(
                  top: 0,
                  right: 4,
                  child: _svgImage(model: carPartsSvgMap?[CarPartsEnum.tailLightRightSide.value], width: 30.w),
                ),
                // Logo-rear-side
                Positioned(
                  top: 0,
                  child: _svgImage(model: carPartsSvgMap?[CarPartsEnum.logoRearSide.value]),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _rightSection(Map<String, DamagePartsSvgModel>? carPartsSvgMap) {
    return SizedBox(
      height: 380,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          // Fender section
          Positioned(
            top: 0,
            right: 0,
            left: 0,
            child: SizedBox(
              height: 154,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Indicator-Light-Right-Side
                  Positioned(
                    top: 0,
                    right: 52.dg,
                    child: _svgImage(model: carPartsSvgMap?[CarPartsEnum.indicatorLightRightSide.value]),
                  ),
                  // Side-Bumper-Front-Right-Side
                  Positioned(
                    top: 0,
                    right: 16.dg,
                    child: _svgImage(model: carPartsSvgMap?[CarPartsEnum.sideBumperFrontRightSide.value]),
                  ),
                  // Fender-Right-Side
                  Positioned(
                    top: 18,
                    left: 0,
                    child: _svgImage(model: carPartsSvgMap?[CarPartsEnum.fenderRightSide.value]),
                  ),
                  // Arch-Panel-Front-Right-Side
                  Positioned(
                    top: 38,
                    right: 16.dg,
                    child: _svgImage(model: carPartsSvgMap?[CarPartsEnum.archPanelFrontRightSide.value], height: 56),
                  ),
                  // Wheel section
                  Positioned(
                    right: 0,
                    top: 42,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        _svgImage(
                            model: carPartsSvgMap?[CarPartsEnum.wheelFrontRightSide.value], height: 46.w, width: 46.w),
                        _svgImage(
                            model: carPartsSvgMap?[CarPartsEnum.alloyRimFrontRightSide.value], height: 30, width: 30),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Door section
          Positioned(
            left: -8.w,
            bottom: 94,
            right: 0,
            child: SizedBox(
              height: 166,
              width: double.infinity,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Door, Window, Mirror, Handle
                  Positioned(
                    top: 0,
                    left: 0,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        // Door-Front-Right-Side
                        _svgImage(model: carPartsSvgMap?[CarPartsEnum.doorFrontRightSide.value]),
                        // Window, Mirror
                        Positioned(
                          left: 4.w,
                          child: Stack(
                            children: [
                              // Window-Front-Right-Side
                              _svgImage(model: carPartsSvgMap?[CarPartsEnum.windowFrontRightSide.value]),
                              // Side-Mirror-Right-Side
                              Positioned(
                                right: 2.w,
                                top: 4,
                                child: _svgImage(model: carPartsSvgMap?[CarPartsEnum.sideMirrorRightSide.value]),
                              ),
                            ],
                          ),
                        ),
                        // Exterior-Door-Handle-Front-Right-Side
                        Positioned(
                          left: 44.w,
                          bottom: 16,
                          child: _svgImage(model: carPartsSvgMap?[CarPartsEnum.exteriorDoorHandleFrontRightSide.value]),
                        ),
                      ],
                    ),
                  ),
                  // Rear-Door, Window, Handle
                  Positioned(
                    bottom: 0,
                    left: 0,
                    child: Column(
                      children: [
                        Stack(children: [
                          // door-Rear-Left-Side
                          _svgImage(model: carPartsSvgMap?[CarPartsEnum.doorRearRightSide.value]),
                          // Window,
                          Positioned(
                            top: 6,
                            left: 4.w,
                            child: _svgImage(model: carPartsSvgMap?[CarPartsEnum.windowRearRightSide.value]),
                          ),
                          // Exterior Door Handle Front Left Side
                          Positioned(
                            left: 44.w,
                            bottom: 16,
                            child:
                                _svgImage(model: carPartsSvgMap?[CarPartsEnum.exteriorDoorHandleRearRightSide.value]),
                          ),
                        ]),
                      ],
                    ),
                  ),
                  // Molding-Left-Side
                  Positioned(
                    right: 48.dg,
                    bottom: 20,
                    child: _svgImage(model: carPartsSvgMap?[CarPartsEnum.moldingRightSide.value]),
                  ),
                ],
              ),
            ),
          ),

          // Side-Rocker-Panel-Right-Side
          Positioned(
            right: 10.dg,
            bottom: 118,
            child: _svgImage(model: carPartsSvgMap?[CarPartsEnum.sideRockerPanelRightSide.value]),
          ),

          // Quarter Panel section
          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: SizedBox(
              height: 124,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Side-Bumper-Front-Right-Side
                  Positioned(
                    bottom: 0,
                    right: 24.dg,
                    child: _svgImage(model: carPartsSvgMap?[CarPartsEnum.sideBumperRearRightSide.value], height: 52),
                  ),
                  // Quarter-Panel
                  Positioned(
                    top: 18,
                    left: 0,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        // Quarter-Panel-Right-Side
                        _svgImage(model: carPartsSvgMap?[CarPartsEnum.quarterPanelRightSide.value]),
                        // Quarter-Glass-Right-Side
                        Positioned(
                          top: 18,
                          left: 8,
                          child: _svgImage(model: carPartsSvgMap?[CarPartsEnum.quarterGlassRightSide.value]),
                        ),
                        // Indicator-Light-Right-Side
                        Positioned(
                          bottom: 0,
                          child: _svgImage(model: carPartsSvgMap?[CarPartsEnum.indicatorLightRightSide.value]),
                        ),
                      ],
                    ),
                  ),
                  // Arch-Panel-Front-Right-Side
                  Positioned(
                    top: 30,
                    right: 12.dg,
                    child: _svgImage(model: carPartsSvgMap?[CarPartsEnum.archPanelRearRightSide.value], height: 56),
                  ),
                  // Wheel section
                  Positioned(
                    right: 0,
                    bottom: 42,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        _svgImage(
                            model: carPartsSvgMap?[CarPartsEnum.wheelRearRightSide.value], height: 44.w, width: 44.w),
                        _svgImage(
                            model: carPartsSvgMap?[CarPartsEnum.alloyRimRearRightSide.value], height: 30, width: 30),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _svgImage({
    required DamagePartsSvgModel? model,
    double? height,
    double? width,
    BoxFit? fit,
    double topLeft = 0,
    double topRight = 0,
    double bottomLeft = 0,
    double bottomRight = 0,
  }) {
    return model != null && model.svgImage != null
        ? ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(topLeft),
              topRight: Radius.circular(topRight),
              bottomLeft: Radius.circular(bottomLeft),
              bottomRight: Radius.circular(bottomRight),
            ),
            child: SvgPicture.asset(
              model.svgImage!,
              height: height,
              width: width,
              fit: fit ?? BoxFit.fitWidth,
              colorFilter: ColorFilter.mode(_getDamageColor(model.severity, model: model), BlendMode.modulate),
            ),
          )
        : const SizedBox.shrink();
  }

  Color _getDamageColor(List<String> severity, {DamagePartsSvgModel? model}) {
    if (severity.isEmpty) return Colors.white;
    // Assign weights to each severity level
    final Map<String, double> weights = {'High': 1.0, 'Medium': 0.4, 'Low': 0.1};
    // Count the occurrences of each severity level
    final Map<String, int> severityCount = {};
    for (var level in severity) {
      severityCount[level] = (severityCount[level] ?? 0) + 1;
    }
    // Calculate the weighted average percentage
    final int total = severity.length;
    final double weightedPercentage = severityCount.entries
            .map((entry) => (weights[entry.key] ?? 0) * (entry.value / total))
            .reduce((a, b) => a + b) *
        100;

    final double percentage = roundDouble(weightedPercentage);

    // Console the severity
    debugPrint('${model?.part}: $percentage% $severity\n');

    if (percentage < 20.0) {
      return AppColors.damageColorList[0];
    } else if (percentage >= 20.0 && percentage < 40.0) {
      return AppColors.damageColorList[1];
    } else if (percentage >= 40.0 && percentage < 60.0) {
      return AppColors.damageColorList[2];
    } else if (percentage >= 60.0 && percentage < 80.0) {
      return AppColors.damageColorList[3];
    } else if (percentage >= 80.0 && percentage <= 100.0) {
      return AppColors.damageColorList[4];
    } else {
      return Colors.white;
    }
  }
}
