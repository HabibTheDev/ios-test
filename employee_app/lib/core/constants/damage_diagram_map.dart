import 'app_assets.dart';

import '../../features/inspection/model/damage_parts_svg_model.dart';
import '../../shared/enums/car_parts.enum.dart';

class DamageDiagramMap {
  static final Map<String, DamagePartsSvgModel> partsMap = {
    // Alloy-Rim
    CarPartsEnum.alloyRimRearLeftSide.value: DamagePartsSvgModel(
      part: CarPartsEnum.alloyRimRearLeftSide.value,
      svgImage: Assets.assetsSvgLeftSectionAlloyRimRearLeftSide,
      severity: [],
    ),
    CarPartsEnum.alloyRimRearRightSide.value: DamagePartsSvgModel(
      part: CarPartsEnum.alloyRimRearRightSide.value,
      svgImage: Assets.assetsSvgRightSectionAlloyRimRearRightSide,
      severity: [],
    ),
    CarPartsEnum.alloyRimFrontLeftSide.value: DamagePartsSvgModel(
      part: CarPartsEnum.alloyRimFrontLeftSide.value,
      svgImage: Assets.assetsSvgLeftSectionAlloyRimFrontLeftSide,
      severity: [],
    ),
    CarPartsEnum.alloyRimFrontRightSide.value: DamagePartsSvgModel(
      part: CarPartsEnum.alloyRimFrontRightSide.value,
      svgImage: Assets.assetsSvgRightSectionAlloyRimFrontRightSide,
      severity: [],
    ),

    // Arch-Panel
    CarPartsEnum.archPanelFrontLeftSide.value: DamagePartsSvgModel(
      part: CarPartsEnum.archPanelFrontLeftSide.value,
      svgImage: Assets.assetsSvgLeftSectionArchPanelFrontLeftSide,
      severity: [],
    ),
    CarPartsEnum.archPanelFrontRightSide.value: DamagePartsSvgModel(
      part: CarPartsEnum.archPanelFrontRightSide.value,
      svgImage: Assets.assetsSvgRightSectionArchPanelFrontRightSide,
      severity: [],
    ),
    CarPartsEnum.archPanelRearLeftSide.value: DamagePartsSvgModel(
      part: CarPartsEnum.archPanelRearLeftSide.value,
      svgImage: Assets.assetsSvgLeftSectionArchPanelRearLeftSide,
      severity: [],
    ),
    CarPartsEnum.archPanelRearRightSide.value: DamagePartsSvgModel(
      part: CarPartsEnum.archPanelRearRightSide.value,
      svgImage: Assets.assetsSvgRightSectionArchPanelRearRightSide,
      severity: [],
    ),

    // Antenna
    CarPartsEnum.antenna.value: DamagePartsSvgModel(
      part: CarPartsEnum.antenna.value,
      svgImage: Assets.assetsSvgMiddleSectionAntenna,
      severity: [],
    ),

    // Bumper
    CarPartsEnum.bumperRearSide.value: DamagePartsSvgModel(
      part: CarPartsEnum.bumperRearSide.value,
      svgImage: Assets.assetsSvgMiddleSectionBumperRearSide,
      severity: [],
    ),
    CarPartsEnum.bumperFrontSide.value: DamagePartsSvgModel(
      part: CarPartsEnum.bumperFrontSide.value,
      svgImage: Assets.assetsSvgMiddleSectionBumperFrontSide,
      severity: [],
    ),

    // Side-Bumper
    CarPartsEnum.sideBumperFrontLeftSide.value: DamagePartsSvgModel(
      part: CarPartsEnum.sideBumperFrontLeftSide.value,
      svgImage: Assets.assetsSvgLeftSectionSideBumperFrontLeftSide,
      severity: [],
    ),
    CarPartsEnum.sideBumperFrontRightSide.value: DamagePartsSvgModel(
      part: CarPartsEnum.sideBumperFrontRightSide.value,
      svgImage: Assets.assetsSvgRightSectionSideBumperFrontRightSide,
      severity: [],
    ),
    CarPartsEnum.sideBumperRearLeftSide.value: DamagePartsSvgModel(
      part: CarPartsEnum.sideBumperRearLeftSide.value,
      svgImage: Assets.assetsSvgLeftSectionSideBumperRearLeftSide,
      severity: [],
    ),
    CarPartsEnum.sideBumperRearRightSide.value: DamagePartsSvgModel(
      part: CarPartsEnum.sideBumperRearRightSide.value,
      svgImage: Assets.assetsSvgRightSectionSideBumperRearRightSide,
      severity: [],
    ),

    // Logo
    CarPartsEnum.logoFrontSide.value: DamagePartsSvgModel(
      part: CarPartsEnum.logoFrontSide.value,
      svgImage: Assets.assetsSvgMiddleSectionLogoFrontSide,
      severity: [],
    ),
    CarPartsEnum.logoRearSide.value: DamagePartsSvgModel(
      part: CarPartsEnum.logoRearSide.value,
      svgImage: Assets.assetsSvgMiddleSectionLogoRearSide,
      severity: [],
    ),

    // Wheel
    CarPartsEnum.wheelRearLeftSide.value: DamagePartsSvgModel(
      part: CarPartsEnum.wheelRearLeftSide.value,
      svgImage: Assets.assetsSvgLeftSectionWheelRearLeftSide,
      severity: [],
    ),
    CarPartsEnum.wheelRearRightSide.value: DamagePartsSvgModel(
      part: CarPartsEnum.wheelRearRightSide.value,
      svgImage: Assets.assetsSvgRightSectionWheelRearRightSide,
      severity: [],
    ),
    CarPartsEnum.wheelFrontLeftSide.value: DamagePartsSvgModel(
      part: CarPartsEnum.wheelFrontLeftSide.value,
      svgImage: Assets.assetsSvgLeftSectionWheelFrontLeftSide,
      severity: [],
    ),
    CarPartsEnum.wheelFrontRightSide.value: DamagePartsSvgModel(
      part: CarPartsEnum.wheelFrontRightSide.value,
      svgImage: Assets.assetsSvgRightSectionWheelFrontRightSide,
      severity: [],
    ),

    // Window
    CarPartsEnum.windowFrontLeftSide.value: DamagePartsSvgModel(
      part: CarPartsEnum.windowFrontLeftSide.value,
      svgImage: Assets.assetsSvgLeftSectionWindowFrontLeftSide,
      severity: [],
    ),
    CarPartsEnum.windowFrontRightSide.value: DamagePartsSvgModel(
      part: CarPartsEnum.windowFrontRightSide.value,
      svgImage: Assets.assetsSvgRightSectionWindowFrontRightSide,
      severity: [],
    ),
    CarPartsEnum.windowRearLeftSide.value: DamagePartsSvgModel(
      part: CarPartsEnum.windowRearLeftSide.value,
      svgImage: Assets.assetsSvgLeftSectionWindowRearLeftSide,
      severity: [],
    ),
    CarPartsEnum.windowRearRightSide.value: DamagePartsSvgModel(
      part: CarPartsEnum.windowRearRightSide.value,
      svgImage: Assets.assetsSvgRightSectionWindowRearRightSide,
      severity: [],
    ),

    // Door
    CarPartsEnum.doorFrontLeftSide.value: DamagePartsSvgModel(
      part: CarPartsEnum.doorFrontLeftSide.value,
      svgImage: Assets.assetsSvgLeftSectionDoorFrontLeftSide,
      severity: [],
    ),
    CarPartsEnum.doorFrontRightSide.value: DamagePartsSvgModel(
      part: CarPartsEnum.doorFrontRightSide.value,
      svgImage: Assets.assetsSvgRightSectionDoorFrontRightSide,
      severity: [],
    ),
    CarPartsEnum.doorRearLeftSide.value: DamagePartsSvgModel(
      part: CarPartsEnum.doorRearLeftSide.value,
      svgImage: Assets.assetsSvgLeftSectionDoorRearLeftSide,
      severity: [],
    ),
    CarPartsEnum.doorRearRightSide.value: DamagePartsSvgModel(
      part: CarPartsEnum.doorRearRightSide.value,
      svgImage: Assets.assetsSvgRightSectionDoorRearRightSide,
      severity: [],
    ),

    // Brake-Light
    CarPartsEnum.brakeLight.value: DamagePartsSvgModel(
      part: CarPartsEnum.brakeLight.value,
      svgImage: Assets.assetsSvgMiddleSectionBrakeLight,
      severity: [],
    ),

    // Exterior-Door-Handle
    CarPartsEnum.exteriorDoorHandleRearLeftSide.value: DamagePartsSvgModel(
      part: CarPartsEnum.exteriorDoorHandleRearLeftSide.value,
      svgImage: Assets.assetsSvgLeftSectionExteriorDoorHandleRearLeftSide,
      severity: [],
    ),
    CarPartsEnum.exteriorDoorHandleRearRightSide.value: DamagePartsSvgModel(
      part: CarPartsEnum.exteriorDoorHandleRearRightSide.value,
      svgImage: Assets.assetsSvgRightSectionExteriorDoorHandleRearRightSide,
      severity: [],
    ),
    CarPartsEnum.exteriorDoorHandleFrontLeftSide.value: DamagePartsSvgModel(
      part: CarPartsEnum.exteriorDoorHandleFrontLeftSide.value,
      svgImage: Assets.assetsSvgLeftSectionExteriorDoorHandleFrontLeftSide,
      severity: [],
    ),
    CarPartsEnum.exteriorDoorHandleFrontRightSide.value: DamagePartsSvgModel(
      part: CarPartsEnum.exteriorDoorHandleFrontRightSide.value,
      svgImage: Assets.assetsSvgRightSectionExteriorDoorHandleFrontRightSide,
      severity: [],
    ),

    // Fender
    CarPartsEnum.fenderLeftSide.value: DamagePartsSvgModel(
      part: CarPartsEnum.fenderLeftSide.value,
      svgImage: Assets.assetsSvgLeftSectionFenderLeftSide,
      severity: [],
    ),
    CarPartsEnum.fenderRightSide.value: DamagePartsSvgModel(
      part: CarPartsEnum.fenderRightSide.value,
      svgImage: Assets.assetsSvgRightSectionFenderRightSide,
      severity: [],
    ),

    // Fog-Light
    CarPartsEnum.fogLightRearLeftSide.value: DamagePartsSvgModel(
      part: CarPartsEnum.fogLightRearLeftSide.value,
      svgImage: Assets.assetsSvgMiddleSectionFogLightRearLeftSide,
      severity: [],
    ),
    CarPartsEnum.fogLightRearRightSide.value: DamagePartsSvgModel(
      part: CarPartsEnum.fogLightRearRightSide.value,
      svgImage: Assets.assetsSvgMiddleSectionFogLightRearRightSide,
      severity: [],
    ),
    CarPartsEnum.fogLightFrontLeftSide.value: DamagePartsSvgModel(
      part: CarPartsEnum.fogLightFrontLeftSide.value,
      svgImage: Assets.assetsSvgMiddleSectionFogLightFrontLeftSide,
      severity: [],
    ),
    CarPartsEnum.fogLightFrontRightSide.value: DamagePartsSvgModel(
      part: CarPartsEnum.fogLightFrontRightSide.value,
      svgImage: Assets.assetsSvgMiddleSectionFogLightFrontRightSide,
      severity: [],
    ),

    // Fuel-Cap
    CarPartsEnum.fuelCap.value: DamagePartsSvgModel(
      part: CarPartsEnum.fuelCap.value,
      svgImage: Assets.assetsSvgLeftSectionFuelCap,
      severity: [],
    ),

    // Grille
    CarPartsEnum.grilleFrontSide.value: DamagePartsSvgModel(
      part: CarPartsEnum.grilleFrontSide.value,
      svgImage: Assets.assetsSvgMiddleSectionGrilleFrontSide,
      severity: [],
    ),
    CarPartsEnum.grilleRearSide.value: DamagePartsSvgModel(
      part: CarPartsEnum.grilleRearSide.value,
      svgImage: Assets.assetsSvgMiddleSectionGrilleRearSide,
      severity: [],
    ),

    // Head-Light
    CarPartsEnum.headLightLeftSide.value: DamagePartsSvgModel(
      part: CarPartsEnum.headLightLeftSide.value,
      svgImage: Assets.assetsSvgMiddleSectionHeadLightLeftSide,
      severity: [],
    ),
    CarPartsEnum.headLightRightSide.value: DamagePartsSvgModel(
      part: CarPartsEnum.headLightRightSide.value,
      svgImage: Assets.assetsSvgMiddleSectionHeadLightRightSide,
      severity: [],
    ),

    // Hood
    CarPartsEnum.hood.value: DamagePartsSvgModel(
      part: CarPartsEnum.hood.value,
      svgImage: Assets.assetsSvgMiddleSectionHood,
      severity: [],
    ),

    // Indicator-Light
    CarPartsEnum.indicatorLightLeftSide.value: DamagePartsSvgModel(
      part: CarPartsEnum.indicatorLightLeftSide.value,
      svgImage: Assets.assetsSvgLeftSectionIndicatorLightLeftSide,
      severity: [],
    ),
    CarPartsEnum.indicatorLightRightSide.value: DamagePartsSvgModel(
      part: CarPartsEnum.indicatorLightRightSide.value,
      svgImage: Assets.assetsSvgRightSectionIndicatorLightRightSide,
      severity: [],
    ),

    // License-Plate
    CarPartsEnum.licensePlate.value: DamagePartsSvgModel(
      part: CarPartsEnum.licensePlate.value,
      svgImage: Assets.assetsSvgMiddleSectionLicensePlate,
      severity: [],
    ),

    // Molding
    CarPartsEnum.moldingLeftSide.value: DamagePartsSvgModel(
      part: CarPartsEnum.moldingLeftSide.value,
      svgImage: Assets.assetsSvgLeftSectionMoldingLeftSide,
      severity: [],
    ),
    CarPartsEnum.moldingRightSide.value: DamagePartsSvgModel(
      part: CarPartsEnum.moldingRightSide.value,
      svgImage: Assets.assetsSvgRightSectionMoldingRightSide,
      severity: [],
    ),

    // Quarter-Panel
    CarPartsEnum.quarterPanelLeftSide.value: DamagePartsSvgModel(
      part: CarPartsEnum.quarterPanelLeftSide.value,
      svgImage: Assets.assetsSvgLeftSectionQuarterPanelLeftSide,
      severity: [],
    ),
    CarPartsEnum.quarterPanelRightSide.value: DamagePartsSvgModel(
      part: CarPartsEnum.quarterPanelRightSide.value,
      svgImage: Assets.assetsSvgRightSectionQuarterPanelRightSide,
      severity: [],
    ),

    // Quarter-Glass
    CarPartsEnum.quarterGlassLeftSide.value: DamagePartsSvgModel(
      part: CarPartsEnum.quarterGlassLeftSide.value,
      svgImage: Assets.assetsSvgLeftSectionQuarterGlassLeftSide,
      severity: [],
    ),
    CarPartsEnum.quarterGlassRightSide.value: DamagePartsSvgModel(
      part: CarPartsEnum.quarterGlassRightSide.value,
      svgImage: Assets.assetsSvgRightSectionQuarterGlassRightSide,
      severity: [],
    ),
    CarPartsEnum.wiperRearSide.value: DamagePartsSvgModel(
      part: CarPartsEnum.wiperRearSide.value,
      svgImage: Assets.assetsSvgMiddleSectionWiperRearSide,
      severity: [],
    ),

    // Rocker panel
    CarPartsEnum.sideRockerPanelLeftSide.value: DamagePartsSvgModel(
      part: CarPartsEnum.sideRockerPanelLeftSide.value,
      svgImage: Assets.assetsSvgLeftSectionSideRockerPanelLeftSide,
      severity: [],
    ),
    CarPartsEnum.sideRockerPanelRightSide.value: DamagePartsSvgModel(
      part: CarPartsEnum.sideRockerPanelRightSide.value,
      svgImage: Assets.assetsSvgRightSectionSideRockerPanelRightSide,
      severity: [],
    ),

    // Roof
    CarPartsEnum.roofLeftSide.value: DamagePartsSvgModel(
      part: CarPartsEnum.roofLeftSide.value,
      svgImage: Assets.assetsSvgMiddleSectionRoof,
      severity: [],
    ),
    CarPartsEnum.roofRightSide.value: DamagePartsSvgModel(
      part: CarPartsEnum.roofRightSide.value,
      svgImage: Assets.assetsSvgMiddleSectionRoof,
      severity: [],
    ),
    CarPartsEnum.roofFrontSide.value: DamagePartsSvgModel(
      part: CarPartsEnum.roofFrontSide.value,
      svgImage: Assets.assetsSvgMiddleSectionRoof,
      severity: [],
    ),
    CarPartsEnum.roofRearSide.value: DamagePartsSvgModel(
      part: CarPartsEnum.roofRearSide.value,
      svgImage: Assets.assetsSvgMiddleSectionRoof,
      severity: [],
    ),

    // Roof Rail
    CarPartsEnum.roofRailLeftSide.value: DamagePartsSvgModel(
      part: CarPartsEnum.roofRailLeftSide.value,
      svgImage: Assets.assetsSvgMiddleSectionRoofRailLeftSide,
      severity: [],
    ),
    CarPartsEnum.roofRailRightSide.value: DamagePartsSvgModel(
      part: CarPartsEnum.roofRailRightSide.value,
      svgImage: Assets.assetsSvgMiddleSectionRoofRailRightSide,
      severity: [],
    ),

    // Side-Mirror
    CarPartsEnum.sideMirrorLeftSide.value: DamagePartsSvgModel(
      part: CarPartsEnum.sideMirrorLeftSide.value,
      svgImage: Assets.assetsSvgLeftSectionSideMirrorLeftSide,
      severity: [],
    ),
    CarPartsEnum.sideMirrorRightSide.value: DamagePartsSvgModel(
      part: CarPartsEnum.sideMirrorRightSide.value,
      svgImage: Assets.assetsSvgRightSectionSideMirrorRightSide,
      severity: [],
    ),

    // Tail-Light
    CarPartsEnum.tailLightLeftSide.value: DamagePartsSvgModel(
      part: CarPartsEnum.tailLightLeftSide.value,
      svgImage: Assets.assetsSvgMiddleSectionTailLightLeftSide,
      severity: [],
    ),
    CarPartsEnum.tailLightRightSide.value: DamagePartsSvgModel(
      part: CarPartsEnum.tailLightRightSide.value,
      svgImage: Assets.assetsSvgMiddleSectionTailLightRightSide,
      severity: [],
    ),

    // Trunk
    CarPartsEnum.trunk.value: DamagePartsSvgModel(
      part: CarPartsEnum.trunk.value,
      svgImage: Assets.assetsSvgMiddleSectionTrunk,
      severity: [],
    ),

    // Windshield
    CarPartsEnum.windshieldFrontSide.value: DamagePartsSvgModel(
      part: CarPartsEnum.windshieldFrontSide.value,
      svgImage: Assets.assetsSvgMiddleSectionWindshieldFrontSide,
      severity: [],
    ),
    CarPartsEnum.windshieldRearSide.value: DamagePartsSvgModel(
      part: CarPartsEnum.windshieldRearSide.value,
      svgImage: Assets.assetsSvgMiddleSectionWindshieldRearSide,
      severity: [],
    ),
    CarPartsEnum.wiperFrontSide.value: DamagePartsSvgModel(
      part: CarPartsEnum.wiperFrontSide.value,
      svgImage: Assets.assetsSvgMiddleSectionWiperFrontSide,
      severity: [],
    ),

    // Spoiler
    CarPartsEnum.spoiler.value: DamagePartsSvgModel(
      part: CarPartsEnum.spoiler.value,
      svgImage: Assets.assetsSvgMiddleSectionSpoiler,
      severity: [],
    ),
  };
}
