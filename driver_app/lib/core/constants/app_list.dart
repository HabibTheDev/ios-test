import 'package:flutter/material.dart';

import '../../features/contracts/model/contract_action_model.dart';
import '../../features/drawer/model/drawer_model.dart';
import '../../shared/utils/enums.dart';
import '../../shared/utils/locale.enum.dart';

import 'app_assets.dart';
import 'app_color.dart';

class AppList {
  AppList._();

  static final localeList = [Locale(LocaleEnum.english.value), Locale(LocaleEnum.bengali.value)];

  static const genderList = ['Male', 'Female', 'Other'];
  static const countryList = ['Canada', 'USA'];
  static const distanceUnitList = ['Mile', 'Kilometer'];

  static final List<DrawerModel> drawerItemList = [
    DrawerModel(asset: Assets.assetsSvgVehicles, title: 'My vehicles', drawerItemEnum: DrawerItemEnum.myVehicles),
    DrawerModel(asset: Assets.assetsSvgLocation, title: 'My location', drawerItemEnum: DrawerItemEnum.myLocation),
    DrawerModel(asset: Assets.assetsSvgContracts, title: 'Contracts', drawerItemEnum: DrawerItemEnum.contracts),
    DrawerModel(asset: Assets.assetsSvgCollisions, title: 'Report issue', drawerItemEnum: DrawerItemEnum.reportIssue),
    DrawerModel(asset: Assets.assetsSvgInbox, title: 'Get help', drawerItemEnum: DrawerItemEnum.getHelp),
    DrawerModel(asset: Assets.assetsSvgCarSearch, title: 'Explore cars', drawerItemEnum: DrawerItemEnum.exploreCar),
    DrawerModel(asset: Assets.assetsSvgMore, title: 'More', drawerItemEnum: DrawerItemEnum.more),
  ];

  static const List<String> inspectionInstructionList = [
    'Place the car in a well lit environment.',
    'Position yourself so that the entire car always stays within the camera frame.',
    'Start at the driver\'s side and move left around the car to the rear side, as guided in the process.',
    'After the process is complete, press the arrow to continue.',
    'If you want to retake the video, press repeat.',
  ];

  static final List<int> hours = List.generate(12, (index) => index + 1);
  static final List<int> minutes = List.generate(60, (index) => index);
  static const List<String> amPM = ['AM', 'PM'];

  static const List<String> fuelTypes = [
    'Petrol',
    'Diesel',
    'Electric',
    'Hybrid',
    'Plug-in Hybrid',
    'Hydrogen Fuel Cell',
    'Compressed Natural Gas (CNG)',
    'Liquefied Petroleum Gas (LPG)',
  ];
  static const List<String> carMakes = [
    'Toyota',
    'Volkswagen',
    'Ford',
    'Honda',
    'Chevrolet',
    'Nissan',
    'Hyundai',
    'BMW',
    'Mercedes-Benz',
    'Audi',
    'Lexus',
    'Kia',
    'Mazda',
    'Subaru',
    'Tesla',
    'Jaguar',
    'Land Rover',
    'Ferrari',
    'Lamborghini',
    'Porsche',
    'Volvo',
    'Jeep',
    'Dodge',
    'Chrysler',
    'GMC',
    'Buick',
    'Mitsubishi',
    'Renault',
    'Peugeot',
    'Fiat',
  ];
  static const List<String> carStyles = [
    'Sedan',
    'Hatchback',
    'SUV',
    'Coupe',
    'Convertible',
    'Wagon',
    'Minivan',
    'Crossover',
    'Pickup truck',
    'Coupe SUV',
  ];
  static const List<String> carTransmissions = [
    'Manual Transmission',
    'Automatic Transmission',
    'Dual-Clutch Transmission',
    'Hybrid Transmission',
    'Sequential Manual Transmission',
    'Tiptronic Transmission',
  ];

  static const List<String> locationList = ['Location 1', 'Location 2', 'Location 3', 'Location 4', 'Location 5'];
  static const List<String> startDrivingTabBarList = ['Controller', 'Contract'];
  static const List<String> contractType = ['Active', 'Canceled'];
  static const List<String> contractDetailsFinanceType = ['Payments', 'Refunds'];
  static const List<String> contractDetailsTabs = ['Overview', 'Vehicles', 'Financial'];
  static const List<String> requestTypeTabs = ['Maintenance', 'Exchange'];
  static const List<String> inspectionTypeTabs = ['Departure', 'Return'];

  static const List<String> dummyImageList = [
    'https://images.squarespace-cdn.com/content/v1/54bdcba5e4b08f92b173441f/1550534549382-6QZWBANFQ85FCBG0HE74/file-20180102-26163-d9wlms.jpg',
    'https://upload.wikimedia.org/wikipedia/commons/thumb/3/39/GodfreyKneller-IsaacNewton-1689.jpg/220px-GodfreyKneller-IsaacNewton-1689.jpg',
    'https://hips.hearstapps.com/hmg-prod/images/albert-einstein-sticks-out-his-tongue-when-asked-by-news-photo-1681316749.jpg',
  ];

  static final List<ContractActionModel> contractActionList = [
    ContractActionModel(title: 'Request maintenance', icon: Icons.handyman, iconColor: AppColors.primaryColor),
    ContractActionModel(title: 'Request exchange', icon: Icons.swap_horiz, iconColor: AppColors.primaryColor),
    ContractActionModel(title: 'Upgrade plan', icon: Icons.local_police, iconColor: AppColors.primaryColor),
    ContractActionModel(title: 'Give feedback', icon: Icons.reviews, iconColor: AppColors.primaryColor),
    ContractActionModel(title: 'Cancel contract', icon: Icons.receipt_long, iconColor: AppColors.errorColor),
  ];

  static const List<String> cancelationReasonList = [
    'Not satisfied with service',
    'Financial reasons',
    'Relocation',
    'Vehicle no longer needed',
    'Found better deal elsewhere',
    'Change in circumstances',
    'Health issue',
    'Others'
  ];

  static const List<Color> signatureColorList = [Colors.black, Colors.blue, Color(0xff6F6464)];
}
