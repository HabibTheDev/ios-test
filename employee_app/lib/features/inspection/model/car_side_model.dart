import '../../../core/constants/app_assets.dart';

class CarSideModel {
  final String side;
  final String svgAsset;

  CarSideModel({required this.side, required this.svgAsset});

  static final List<CarSideModel> carSides = [
    CarSideModel(side: 'Left side', svgAsset: Assets.assetsSvgDriverSide),
    CarSideModel(side: 'Front side', svgAsset: Assets.assetsSvgFrontSide),
    CarSideModel(side: 'Right side', svgAsset: Assets.assetsSvgPassengerSide),
    CarSideModel(side: 'Back side', svgAsset: Assets.assetsSvgBackSide),
  ];
}
