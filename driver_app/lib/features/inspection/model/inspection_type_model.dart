// import '../../../core/constants/app_assets.dart';
// import '../../../shared/utils/enums.dart';

// class InspectionTypeModel {
//   final InspectionCaptureTypeEnum type;
//   final String svgAsset;
//   final InspectionCaptureStatus status;

//   InspectionTypeModel(
//       {required this.type, required this.svgAsset, required this.status});

//   InspectionTypeModel copyWith({
//     InspectionCaptureTypeEnum? type,
//     String? svgAsset,
//     InspectionCaptureStatus? status,
//   }) {
//     return InspectionTypeModel(
//       type: type ?? this.type,
//       svgAsset: svgAsset ?? this.svgAsset,
//       status: status ?? this.status,
//     );
//   }

//   static final List<InspectionTypeModel> inspectionTypes = [
//     InspectionTypeModel(
//       type: InspectionCaptureTypeEnum.carExterior,
//       svgAsset: Assets.assetsSvgCarExterior,
//       status: InspectionCaptureStatus.awaiting,
//     ),
//     InspectionTypeModel(
//       type: InspectionCaptureTypeEnum.licensePlate,
//       svgAsset: Assets.assetsSvgLicensePlate,
//       status: InspectionCaptureStatus.incomplete,
//     ),
//     InspectionTypeModel(
//       type: InspectionCaptureTypeEnum.odometer,
//       svgAsset: Assets.assetsSvgOdometer,
//       status: InspectionCaptureStatus.incomplete,
//     ),
//     InspectionTypeModel(
//       type: InspectionCaptureTypeEnum.doorVinSticker,
//       svgAsset: Assets.assetsSvgDoorVin,
//       status: InspectionCaptureStatus.incomplete,
//     ),
//   ];
// }
