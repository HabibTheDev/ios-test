import 'package:driver_app/features/report_issue/model/anybody_hurt_model.dart';
import 'package:get/get.dart';

import '../model/driver_info_model.dart';

class DriverInfoController extends GetxController {
  // Driver list
  final Rxn<DriverInfoModel> selectedDriver = Rxn();
  // Anybody hurt
  final Rxn<AnybodyHurtModel> selectedAnybodyHurt = Rxn();
}
