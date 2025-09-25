import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../shared/enums/enums.dart';
import '../../../../shared/utils/utils.dart';
import '../../../../shared/widgets/widget_imports.dart';
import '../../../more/view/screens/widget_imports.dart';
import '../../../my_task/view/screens/my_task.dart';
import '../../../inbox/view/screens/inbox.dart';
import '../../controller/drawer_controller.dart';

class AppDrawerScreen extends StatelessWidget {
  const AppDrawerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AppDrawerController controller = Get.find();
    return GestureDetector(
      onTap: hideKeyboard,
      child: AppScaffold(
        controller: controller,
        body: Obx(
          () => controller.selectedItem.value.drawerItemEnum == DrawerItemEnum.myTask
              ? const MyTask()
              : controller.selectedItem.value.drawerItemEnum == DrawerItemEnum.inbox
                  ? const Inbox()
                  : controller.selectedItem.value.drawerItemEnum == DrawerItemEnum.more
                      ? const More()
                      : const SizedBox.shrink(),
        ),
      ),
    );
  }
}
