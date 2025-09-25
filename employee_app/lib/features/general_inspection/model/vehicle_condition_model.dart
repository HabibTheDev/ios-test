import '../../../core/constants/app_assets.dart';
import '../../../shared/enums/enums.dart';

class VehicleConditionModel {
  final VehicleConditionType type;
  final String svgAsset;
  final StepStatus status;

  VehicleConditionModel({required this.type, required this.svgAsset, required this.status});

  VehicleConditionModel copyWith({
    VehicleConditionType? type,
    String? svgAsset,
    StepStatus? status,
  }) {
    return VehicleConditionModel(
      type: type ?? this.type,
      svgAsset: svgAsset ?? this.svgAsset,
      status: status ?? this.status,
    );
  }

  static final List<VehicleConditionModel> testTypes = [
    VehicleConditionModel(
      type: VehicleConditionType.engine,
      svgAsset: Assets.assetsSvgGeneralEngine,
      status: StepStatus.awaiting,
    ),
    VehicleConditionModel(
      type: VehicleConditionType.brakeSystem,
      svgAsset: Assets.assetsSvgGeneralBrake,
      status: StepStatus.incomplete,
    ),
    VehicleConditionModel(
      type: VehicleConditionType.tiresAndWheels,
      svgAsset: Assets.assetsSvgGeneralBrake,
      status: StepStatus.incomplete,
    ),
  ];
}
