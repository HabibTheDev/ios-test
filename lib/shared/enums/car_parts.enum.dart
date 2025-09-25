enum CarPartsEnum {
  alloyRimRearLeftSide('Alloy-Rim_Rear-Left-Side'),
  alloyRimRearRightSide('Alloy-Rim_Rear-Right-Side'),
  alloyRimFrontLeftSide('Alloy-Rim_Front-Left-Side'),
  alloyRimFrontRightSide('Alloy-Rim_Front-Right-Side'),

  archPanelFrontLeftSide('Arch-Panel_Front-Left-Side'),
  archPanelFrontRightSide('Arch-Panel_Front-Right-Side'),
  archPanelRearLeftSide('Arch-Panel_Rear-Left-Side'),
  archPanelRearRightSide('Arch-Panel_Rear-Right-Side'),

  antenna('Antenna'),

  bumperRearSide('Bumper_Rear-Side'),
  bumperFrontSide('Bumper_Front-Side'),

  sideBumperFrontLeftSide('Side-Bumper_Front-Left-Side'),
  sideBumperFrontRightSide('Side-Bumper_Front-Right-Side'),
  sideBumperRearLeftSide('Side-Bumper_Rear-Left-Side'),
  sideBumperRearRightSide('Side-Bumper_Rear-Right-Side'),

  logoFrontSide('Logo_Front-Side'),
  logoRearSide('Logo_Rear-Side'),

  wheelFrontLeftSide('Wheel_Front-Left-Side'),
  wheelFrontRightSide('Wheel_Front-Right-Side'),
  wheelRearLeftSide('Wheel_Rear-Left-Side'),
  wheelRearRightSide('Wheel_Rear-Right-Side'),

  windowFrontLeftSide('Window_Front-Left-Side'),
  windowFrontRightSide('Window_Front-Right-Side'),
  windowRearLeftSide('Window_Rear-Left-Side'),
  windowRearRightSide('Window_Rear-Right-Side'),

  doorFrontLeftSide('Door_Front-Left-Side'),
  doorFrontRightSide('Door_Front-Right-Side'),
  doorRearLeftSide('Door_Rear-Left-Side'),
  doorRearRightSide('Door_Rear-Right-Side'),

  brakeLight('Brake-Light'),

  exteriorDoorHandleRearLeftSide('Exterior-Door-Handle_Rear-Left-Side'),
  exteriorDoorHandleRearRightSide('Exterior-Door-Handle_Rear-Right-Side'),
  exteriorDoorHandleFrontLeftSide('Exterior-Door-Handle_Front-Left-Side'),
  exteriorDoorHandleFrontRightSide('Exterior-Door-Handle_Front-Right-Side'),

  fenderLeftSide('Fender_Left-Side'),
  fenderRightSide('Fender_Right-Side'),

  fogLightRearLeftSide('Fog-Light_Rear-Left-Side'),
  fogLightRearRightSide('Fog-Light_Rear-Right-Side'),
  fogLightFrontLeftSide('Fog-Light_Front-Left-Side'),
  fogLightFrontRightSide('Fog-Light_Front-Right-Side'),

  fuelCap('Fuel-Cap'),
  grilleFrontSide('Grille_Front-Side'),
  grilleRearSide('Grille_Rear-Side'),

  headLightLeftSide('Head-Light_Left-Side'),
  headLightRightSide('Head-Light_Right-Side'),

  hood('Hood'),

  indicatorLightLeftSide('Indicator-Light_Left-Side'), // will have 2 for left side
  indicatorLightRightSide('Indicator-Light_Right-Side'), // will have 2 for right side

  licensePlate('License-Plate'),

  moldingLeftSide('Molding_Left-Side'),
  moldingRightSide('Molding_Right-Side'),

  quarterPanelLeftSide('Quarter-Panel_Left-Side'),
  quarterPanelRightSide('Quarter-Panel_Right-Side'),
  quarterGlassLeftSide('Quarter-Glass_Left-Side'),
  quarterGlassRightSide('Quarter-Glass_Right-Side'),

  wiperRearSide('Wiper_Rear-Side'),

  roofFrontSide('Roof_Front-Side'),
  roofRearSide('Roof_Rear-Side'),
  roofLeftSide('Roof_Left-Side'),
  roofRightSide('Roof_Right-Side'),

  roofRailLeftSide('Roof-Rail_Left-Side'),
  roofRailRightSide('Roof-Rail_Right-Side'),

  sideRockerPanelRightSide('Side-Rocker-Panel_Right-Side'),
  sideRockerPanelLeftSide('Side-Rocker-Panel_Left-Side'),

  sideMirrorLeftSide('Side-Mirror_Left-Side'),
  sideMirrorRightSide('Side-Mirror_Right-Side'),

  tailLightLeftSide('Tail-Light_Left-Side'),
  tailLightRightSide('Tail-Light_Right-Side'),

  trunk('Trunk'),

  windshieldFrontSide('Windshield_Front-Side'),
  windshieldRearSide('Windshield_Rear-Side'),

  wiperFrontSide('Wiper_Front-Side'),

  spoiler('Spoiler');

  const CarPartsEnum(this.value);
  final String value;
}
