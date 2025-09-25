import '../../../core/constants/app_assets.dart';
import '../../../shared/enums/enums.dart';

class InspectionTypeModel {
  final InspectionCaptureTypeEnum type;
  final String svgAsset;
  final StepStatus status;

  InspectionTypeModel({required this.type, required this.svgAsset, required this.status});

  InspectionTypeModel copyWith({InspectionCaptureTypeEnum? type, String? svgAsset, StepStatus? status}) {
    return InspectionTypeModel(
      type: type ?? this.type,
      svgAsset: svgAsset ?? this.svgAsset,
      status: status ?? this.status,
    );
  }

  static final List<InspectionTypeModel> inspectionTypes = [
    InspectionTypeModel(
      type: InspectionCaptureTypeEnum.carExterior,
      svgAsset: Assets.assetsSvgCarExterior,
      status: StepStatus.awaiting,
    ),
    InspectionTypeModel(
      type: InspectionCaptureTypeEnum.licensePlate,
      svgAsset: Assets.assetsSvgLicensePlate,
      status: StepStatus.incomplete,
    ),
    InspectionTypeModel(
      type: InspectionCaptureTypeEnum.odometer,
      svgAsset: Assets.assetsSvgOdometer,
      status: StepStatus.incomplete,
    ),
  ];
}
