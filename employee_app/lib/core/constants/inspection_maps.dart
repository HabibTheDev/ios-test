import 'app_assets.dart';
import 'car_parts_list.dart';

import '../../shared/enums/car_parts.enum.dart';
import '../../shared/enums/car_side_enum.dart';
import '../../shared/enums/car_sections_enum.dart';

class InspectionMaps {
  InspectionMaps._();

  static final Map<String, List<String>> carSectionListMap = {
    CarSectionEnum.leftSideHealth.value: CarPartsList.leftSides,
    CarSectionEnum.rightSideHealth.value: CarPartsList.rightSides,
    CarSectionEnum.frontHealth.value: CarPartsList.frontSides,
    CarSectionEnum.rearHealth.value: CarPartsList.rearSides,
  };

  static final Map<String, String> carSectionNameMap = {
    CarSectionEnum.leftSideHealth.value: CarSideEnum.leftSide.value,
    CarSectionEnum.rightSideHealth.value: CarSideEnum.rightSide.value,
    CarSectionEnum.frontHealth.value: CarSideEnum.frontSide.value,
    CarSectionEnum.rearHealth.value: CarSideEnum.rearSide.value,
  };

  static final Map<String, String> carSectionSvgMap = {
    CarSectionEnum.leftSideHealth.value: Assets.assetsSvgCarPartsLeftSide,
    CarSectionEnum.rightSideHealth.value: Assets.assetsSvgCarPartsRightSide,
    CarSectionEnum.frontHealth.value: Assets.assetsSvgCarPartsFrontSide,
    CarSectionEnum.rearHealth.value: Assets.assetsSvgCarPartsRearSide,
  };

  static final Map<String, String> carPartMap = {
    CarPartsEnum.alloyRimRearLeftSide.value: 'Rear alloy rim',
    CarPartsEnum.alloyRimFrontLeftSide.value: 'Front alloy rim',
    CarPartsEnum.wheelRearLeftSide.value: 'Rear wheel',
    CarPartsEnum.windowRearLeftSide.value: 'Rear window',
    CarPartsEnum.doorRearLeftSide.value: 'Rear door',
    CarPartsEnum.exteriorDoorHandleRearLeftSide.value: 'Rear door handle',
    CarPartsEnum.exteriorDoorHandleFrontLeftSide.value: 'Front door handle',
    CarPartsEnum.fenderLeftSide.value: 'Fender',
    CarPartsEnum.archPanelFrontLeftSide.value: 'Front arch panel',
    CarPartsEnum.wheelFrontLeftSide.value: 'Front wheel',
    CarPartsEnum.windowFrontLeftSide.value: 'Front window',
    CarPartsEnum.sideBumperFrontLeftSide.value: 'Front side bumper',
    CarPartsEnum.doorFrontLeftSide.value: 'Front door',
    CarPartsEnum.fuelCap.value: 'Fuel cap',
    CarPartsEnum.indicatorLightLeftSide.value: 'Indicator light',
    CarPartsEnum.moldingLeftSide.value: 'Moldings',
    CarPartsEnum.quarterPanelLeftSide.value: 'Quarter panel',
    CarPartsEnum.quarterGlassLeftSide.value: 'Quarter glass',
    CarPartsEnum.archPanelRearLeftSide.value: 'Rear arch panel',
    CarPartsEnum.sideBumperRearLeftSide.value: 'Rear side bumper',
    CarPartsEnum.sideRockerPanelLeftSide.value: 'Side rocker panel',
    CarPartsEnum.sideMirrorLeftSide.value: 'Side mirror',
    CarPartsEnum.alloyRimRearRightSide.value: 'Rear alloy rim',
    CarPartsEnum.alloyRimFrontRightSide.value: 'Front alloy rim',
    CarPartsEnum.wheelRearRightSide.value: 'Rear wheel',
    CarPartsEnum.windowRearRightSide.value: 'Rear window',
    CarPartsEnum.doorRearRightSide.value: 'Rear door',
    CarPartsEnum.exteriorDoorHandleRearRightSide.value: 'Rear door handle',
    CarPartsEnum.exteriorDoorHandleFrontRightSide.value: 'Front door handle',
    CarPartsEnum.fenderRightSide.value: 'Fender',
    CarPartsEnum.archPanelFrontRightSide.value: 'Front arch panel',
    CarPartsEnum.wheelFrontRightSide.value: 'Front wheel',
    CarPartsEnum.windowFrontRightSide.value: 'Front window',
    CarPartsEnum.sideBumperFrontRightSide.value: 'Front side bumper',
    CarPartsEnum.doorFrontRightSide.value: 'Front door',
    CarPartsEnum.indicatorLightRightSide.value: 'Indicator light',
    CarPartsEnum.moldingRightSide.value: 'Moldings',
    CarPartsEnum.quarterPanelRightSide.value: 'Quarter panel',
    CarPartsEnum.quarterGlassRightSide.value: 'Quarter glass',
    CarPartsEnum.archPanelRearRightSide.value: 'Rear arch panel',
    CarPartsEnum.sideBumperRearRightSide.value: 'Rear side bumper',
    CarPartsEnum.sideRockerPanelRightSide.value: 'Side rocker panel',
    CarPartsEnum.sideMirrorRightSide.value: 'Side mirror',
    CarPartsEnum.fogLightFrontLeftSide.value: 'Left fog light',
    CarPartsEnum.fogLightFrontRightSide.value: 'Right fog light',
    CarPartsEnum.logoFrontSide.value: 'Logo',
    CarPartsEnum.bumperFrontSide.value: 'Bumper',
    CarPartsEnum.grilleFrontSide.value: 'Grille',
    CarPartsEnum.grilleRearSide.value: 'Grille',
    CarPartsEnum.headLightLeftSide.value: 'Left headlight',
    CarPartsEnum.headLightRightSide.value: 'Right headlight',
    CarPartsEnum.hood.value: 'Hood',
    CarPartsEnum.windshieldFrontSide.value: 'Windshield',
    CarPartsEnum.wiperFrontSide.value: 'Wiper',
    CarPartsEnum.bumperRearSide.value: 'Bumper',
    CarPartsEnum.logoRearSide.value: 'Logo',
    CarPartsEnum.windshieldRearSide.value: 'Windshield',
    CarPartsEnum.brakeLight.value: 'Brake light',
    CarPartsEnum.fogLightRearLeftSide.value: 'Left fog light',
    CarPartsEnum.fogLightRearRightSide.value: 'Right fog light',
    CarPartsEnum.licensePlate.value: 'License plate',
    CarPartsEnum.wiperRearSide.value: 'Wiper',
    CarPartsEnum.tailLightLeftSide.value: 'Left tail light',
    CarPartsEnum.tailLightRightSide.value: 'Right tail light',
    CarPartsEnum.trunk.value: 'Trunk',
    CarPartsEnum.spoiler.value: 'Spoiler',
    CarPartsEnum.antenna.value: 'Antenna',
    CarPartsEnum.roofLeftSide.value: 'Roof',
    CarPartsEnum.roofRightSide.value: 'Roof',
    CarPartsEnum.roofFrontSide.value: 'Roof',
    CarPartsEnum.roofRearSide.value: 'Roof',
    CarPartsEnum.roofRailLeftSide.value: 'Roof rail',
    CarPartsEnum.roofRailRightSide.value: 'Roof rail',
  };
}
