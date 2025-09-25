import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../shared/utils/enums.dart';
import '../../../shared/widgets/app_scaffold.dart';
import '../../report_issue/view/screens/report_issue.dart';
import '../../contracts/view/screens/contracts.dart';
import '../../explore_car/view/screens/explore_car.dart';
import '../../get_help/view/screens/get_help.dart';
import '../../more/view/screens/more.dart';
import '../../my_location/view/my_location.dart';
import '../../my_vehicles/view/screens/my_vehicles.dart';
import '../controller/drawer_controller.dart';

class AppDrawerScreen extends StatelessWidget {
  const AppDrawerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AppDrawerController controller = Get.find();
    return Obx(
      () {
        final drawerItemEnum = controller.selectedItem.value.drawerItemEnum;
        return AppScaffold(
          resizeToAvoidBottomInset: drawerItemEnum == DrawerItemEnum.getHelp,
          body: drawerItemEnum == DrawerItemEnum.myVehicles
              ? const MyVehicles()
              : drawerItemEnum == DrawerItemEnum.myLocation
                  ? const MyLocation()
                  : drawerItemEnum == DrawerItemEnum.contracts
                      ? const Contracts()
                      : drawerItemEnum == DrawerItemEnum.reportIssue
                          ? const ReportIssue()
                          : drawerItemEnum == DrawerItemEnum.getHelp
                              ? const GetHelp()
                              : drawerItemEnum == DrawerItemEnum.exploreCar
                                  ? const ExploreCar()
                                  : drawerItemEnum == DrawerItemEnum.more
                                      ? const More()
                                      : const SizedBox.shrink(),
        );
      },
    );
  }
}
