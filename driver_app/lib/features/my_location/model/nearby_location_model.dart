import '../../../core/constants/app_assets.dart';
import '../../../shared/utils/enums.dart';

class NearbyLocationModel {
  final String title;
  final String svgAsset;
  final NearbyLocationType locationType;

  NearbyLocationModel({required this.title, required this.svgAsset, required this.locationType});

  static final List<NearbyLocationModel> nearbyLocationList = [
    NearbyLocationModel(
        title: 'Gas Station', svgAsset: Assets.assetsSvgGasStation, locationType: NearbyLocationType.gasStation),
    NearbyLocationModel(
        title: 'EV charging station',
        svgAsset: Assets.assetsSvgEvChargingStation,
        locationType: NearbyLocationType.evChargingStation),
    NearbyLocationModel(
        title: 'Parking lots', svgAsset: Assets.assetsSvgParkingLot, locationType: NearbyLocationType.parkingLot),
    NearbyLocationModel(title: 'Car wash', svgAsset: Assets.assetsSvgCarWash, locationType: NearbyLocationType.carWash),
    NearbyLocationModel(
        title: 'Repair centers', svgAsset: Assets.assetsSvgRepairCenter, locationType: NearbyLocationType.repairCenter),
    NearbyLocationModel(
        title: 'Roadside assistance',
        svgAsset: Assets.assetsSvgRoadsideAssistance,
        locationType: NearbyLocationType.roadsideAssistance),
    NearbyLocationModel(
        title: 'Company location',
        svgAsset: Assets.assetsSvgCompanyLocation,
        locationType: NearbyLocationType.companyLocation),
  ];
}
