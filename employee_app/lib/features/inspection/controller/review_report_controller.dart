import 'package:get/get.dart';

import '../../../core/router/router_paths.dart';
import '../../../core/constants/api_endpoint.dart';
import '../../../shared/repository/remote/inspection_repo.dart';
import '../../../shared/utils/app_toast.dart';
import '../../../shared/enums/enums.dart';
import '../../entry_inspection/controller/entry_inspection_controller.dart';
import '../model/inspection_arguments_model.dart';
import '../model/inspection_report_model.dart';

class ReviewReportController extends GetxController {
  ReviewReportController({required this.inspectionRepo});
  final InspectionRepo inspectionRepo;

  final RxBool isLoading = false.obs;
  final RxBool functionLoading = false.obs;
  final Rxn<InspectionReportModel> inspectionReportModel = Rxn();

  Future<void> init({required InspectionArgumentsModel? inspectionArgumentsModel}) async {
    if (inspectionArgumentsModel == null) {
      showToast('Inspection Arguments not found');
      return;
    }
    isLoading(true);
    showToast('Getting report');
    final report = await fetchExteriorInspectionReport(inspectionArgumentsModel: inspectionArgumentsModel);
    if (report != null) inspectionReportModel.value = report;
    isLoading(false);
  }

  Future<InspectionReportModel?> fetchExteriorInspectionReport({
    required InspectionArgumentsModel? inspectionArgumentsModel,
    bool isFinish = false,
  }) async {
    if (inspectionArgumentsModel == null || inspectionArgumentsModel.carID == null) {
      showToast('Car not found');
      return null;
    }

    String endPoint = '';
    if (inspectionArgumentsModel.inspectionType == InspectionTypeEnum.entryInspection) {
      endPoint = ApiEndpoint.getEntryInspection;
    } else if (inspectionArgumentsModel.inspectionType == InspectionTypeEnum.generalInspection) {
      endPoint = ApiEndpoint.generalInspectionReport;
    } else if (inspectionArgumentsModel.inspectionType == InspectionTypeEnum.departureInspection) {
      endPoint = ApiEndpoint.departureInspectionReport;
    } else if (inspectionArgumentsModel.inspectionType == InspectionTypeEnum.returnInspection) {
      endPoint = ApiEndpoint.returnInspectionReport;
    } else if (inspectionArgumentsModel.inspectionType == InspectionTypeEnum.maintenanceInspection) {
      endPoint = ApiEndpoint.maintenanceInspectionReport;
    } else {
      showToast('Invalid operation!');
      return null;
    }

    final result = await inspectionRepo.getExteriorInspectionReport(
      endPoint: endPoint,
      carID: inspectionArgumentsModel.carID!,
      inspectionStatus: InspectionStateEnum.draft.value,
    );
    return result;
  }

  Future<void> submitButtonOnTap({required InspectionArgumentsModel? inspectionArgumentsModel}) async {
    if (inspectionReportModel.value == null) {
      showToast('Report not found');
      return;
    }

    functionLoading(true);
    final Map<String, dynamic> payload = {
      "inspectionId": inspectionReportModel.value?.reportOverview?.id,
      "carId": inspectionArgumentsModel?.carID,
      "status": InspectionStateEnum.completed.value,
    };

    final bool result = await inspectionRepo.completeInspection(payload: payload);
    functionLoading(false);

    if (result == true) {
      if (inspectionArgumentsModel?.returnScreen == RouterPaths.entryInspection) {
        final EntryInspectionController inspectionCaptureController = Get.find();
        inspectionCaptureController.eligibleToFinishLastStep = true;
        Get.until((route) => route.settings.name == inspectionArgumentsModel?.returnScreen);
      } else {
        // Get.until((route) => route.settings.name == inspectionArgumentsModel?.returnScreen);
      }
    }
  }
}
