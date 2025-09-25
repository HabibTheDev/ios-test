import 'app_assets.dart';

import '../../shared/enums/car_sections_enum.dart';
import '../../features/maintenance/model/damage_section_group_model.dart';
import '../../shared/enums/car_parts.enum.dart';
import '../../shared/enums/car_side_enum.dart';

class CarPartsList {
  CarPartsList._();

  // Car Map-key from response
  static final List<String> carSection = [
    CarSectionEnum.leftSideHealth.value,
    CarSectionEnum.rightSideHealth.value,
    CarSectionEnum.frontHealth.value,
    CarSectionEnum.rearHealth.value,
  ];

  static final List<String> leftSides = [
    CarPartsEnum.alloyRimRearLeftSide.value,
    CarPartsEnum.alloyRimFrontLeftSide.value,
    CarPartsEnum.wheelRearLeftSide.value,
    CarPartsEnum.windowRearLeftSide.value,
    CarPartsEnum.doorRearLeftSide.value,
    CarPartsEnum.exteriorDoorHandleRearLeftSide.value,
    CarPartsEnum.exteriorDoorHandleFrontLeftSide.value,
    CarPartsEnum.fenderLeftSide.value,
    CarPartsEnum.archPanelFrontLeftSide.value,
    CarPartsEnum.wheelFrontLeftSide.value,
    CarPartsEnum.windowFrontLeftSide.value,
    CarPartsEnum.sideBumperFrontLeftSide.value,
    CarPartsEnum.doorFrontLeftSide.value,
    CarPartsEnum.fuelCap.value,
    CarPartsEnum.indicatorLightLeftSide.value,
    CarPartsEnum.moldingLeftSide.value,
    CarPartsEnum.quarterPanelLeftSide.value,
    CarPartsEnum.quarterGlassLeftSide.value,
    CarPartsEnum.archPanelRearLeftSide.value,
    CarPartsEnum.sideBumperRearLeftSide.value,
    CarPartsEnum.sideRockerPanelLeftSide.value,
    CarPartsEnum.sideMirrorLeftSide.value,
    CarPartsEnum.roofLeftSide.value,
    CarPartsEnum.roofRailLeftSide.value,
  ];

  static final List<String> rightSides = [
    CarPartsEnum.alloyRimRearRightSide.value,
    CarPartsEnum.alloyRimFrontRightSide.value,
    CarPartsEnum.wheelRearRightSide.value,
    CarPartsEnum.windowRearRightSide.value,
    CarPartsEnum.doorRearRightSide.value,
    CarPartsEnum.exteriorDoorHandleRearRightSide.value,
    CarPartsEnum.exteriorDoorHandleFrontRightSide.value,
    CarPartsEnum.fenderRightSide.value,
    CarPartsEnum.archPanelFrontRightSide.value,
    CarPartsEnum.wheelFrontRightSide.value,
    CarPartsEnum.windowFrontRightSide.value,
    CarPartsEnum.sideBumperFrontRightSide.value,
    CarPartsEnum.doorFrontRightSide.value,
    CarPartsEnum.indicatorLightRightSide.value,
    CarPartsEnum.moldingRightSide.value,
    CarPartsEnum.quarterPanelRightSide.value,
    CarPartsEnum.quarterGlassRightSide.value,
    CarPartsEnum.archPanelRearRightSide.value,
    CarPartsEnum.sideBumperRearRightSide.value,
    CarPartsEnum.sideRockerPanelRightSide.value,
    CarPartsEnum.sideMirrorRightSide.value,
    CarPartsEnum.roofRightSide.value,
    CarPartsEnum.roofRailRightSide.value,
  ];

  static final List<String> frontSides = [
    CarPartsEnum.fogLightFrontLeftSide.value,
    CarPartsEnum.fogLightFrontRightSide.value,
    CarPartsEnum.logoFrontSide.value,
    CarPartsEnum.bumperFrontSide.value,
    CarPartsEnum.grilleFrontSide.value,
    CarPartsEnum.headLightLeftSide.value,
    CarPartsEnum.headLightRightSide.value,
    CarPartsEnum.hood.value,
    CarPartsEnum.windshieldFrontSide.value,
    CarPartsEnum.wiperFrontSide.value,
    CarPartsEnum.roofFrontSide.value,
  ];

  static final List<String> rearSides = [
    CarPartsEnum.bumperRearSide.value,
    CarPartsEnum.grilleRearSide.value,
    CarPartsEnum.logoRearSide.value,
    CarPartsEnum.windshieldRearSide.value,
    CarPartsEnum.brakeLight.value,
    CarPartsEnum.fogLightRearLeftSide.value,
    CarPartsEnum.fogLightRearRightSide.value,
    CarPartsEnum.licensePlate.value,
    CarPartsEnum.wiperRearSide.value,
    CarPartsEnum.tailLightLeftSide.value,
    CarPartsEnum.tailLightRightSide.value,
    CarPartsEnum.trunk.value,
    CarPartsEnum.spoiler.value,
    CarPartsEnum.antenna.value,
    CarPartsEnum.roofRearSide.value,
  ];

  // Maintenance
  static final List<DamageSectionGroupModel> carSectionGroupList = [
    DamageSectionGroupModel(
      sectionName: CarSideEnum.leftSide.value,
      svgImagePath: Assets.assetsSvgCarPartsLeftSide,
      parts: leftSides,
    ),
    DamageSectionGroupModel(
      sectionName: CarSideEnum.rightSide.value,
      svgImagePath: Assets.assetsSvgCarPartsRightSide,
      parts: rightSides,
    ),
    DamageSectionGroupModel(
      sectionName: CarSideEnum.frontSide.value,
      svgImagePath: Assets.assetsSvgCarPartsFrontSide,
      parts: frontSides,
    ),
    DamageSectionGroupModel(
      sectionName: CarSideEnum.rearSide.value,
      svgImagePath: Assets.assetsSvgCarPartsRearSide,
      parts: rearSides,
    ),
  ];
}
