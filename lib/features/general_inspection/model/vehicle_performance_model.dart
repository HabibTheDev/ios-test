import '../../../core/constants/app_assets.dart';
import '../../../shared/enums/enums.dart';

class VehiclePerformanceModel {
  final VehiclePerformanceType type;
  final String svgAsset;
  final StepStatus status;

  VehiclePerformanceModel({required this.type, required this.svgAsset, required this.status});

  VehiclePerformanceModel copyWith({
    VehiclePerformanceType? type,
    String? svgAsset,
    StepStatus? status,
  }) {
    return VehiclePerformanceModel(
      type: type ?? this.type,
      svgAsset: svgAsset ?? this.svgAsset,
      status: status ?? this.status,
    );
  }

  static final List<VehiclePerformanceModel> testTypes = [
    VehiclePerformanceModel(
      type: VehiclePerformanceType.stationary,
      svgAsset: Assets.assetsSvgGeneralCarStationary,
      status: StepStatus.awaiting,
    ),
    VehiclePerformanceModel(
      type: VehiclePerformanceType.running,
      svgAsset: Assets.assetsSvgGeneralCarRunning,
      status: StepStatus.incomplete,
    ),
  ];
}
