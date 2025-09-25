import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../core/constants/app_color.dart';
import '../../../../core/router/router_paths.dart';
import '../../../../shared/services/remote/my_vehicles_service.dart';
import '../../../../shared/widgets/loading_widget.dart';
import '../../../../shared/widgets/text_widget.dart';
import '../../controller/my_vehicles_controller.dart';
import '../tiles/my_vehicle_tile.dart';

class MyVehicles extends StatelessWidget {
  const MyVehicles({super.key});

  @override
  Widget build(BuildContext context) {
    final PageController pageController = PageController(viewportFraction: 0.9);
    return GetBuilder<MyVehiclesController>(
        init: MyVehiclesController(MyVehiclesService()),
        autoRemove: false,
        builder: (controller) {
          return Obx(() => controller.isLoading.value
              ? const CenterLoadingWidget()
              : SafeArea(
                  child: Column(
                    children: [
                      // Header
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          //Welcome message
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              BodyText(
                                text: 'Welcome back 👋',
                                fontWeight: FontWeight.w500,
                                textColor: AppColors.lightSecondaryTextColor,
                              ),
                              TitleText(
                                text: 'Ready for your task?',
                                fontWeight: FontWeight.w700,
                                textSize: 24,
                              ),
                            ],
                          ),
                          const Spacer(),
                          //Search Icon
                          InkWell(
                            onTap: () => Get.toNamed(RouterPaths.searchVehicle),
                            child: const Icon(
                              Icons.search,
                              color: AppColors.lightSecondaryTextColor,
                              size: 24,
                            ),
                          )
                        ],
                      ).paddingOnly(left: 16, right: 16, top: 20.h, bottom: 32.h),

                      // Vehicles
                      Expanded(
                        child: PageView.builder(
                          controller: pageController,
                          scrollDirection: Axis.horizontal,
                          pageSnapping: true,
                          itemCount: controller.myVehicles.length,
                          itemBuilder: (context, index) => MyVehicleTile(vehicle: controller.myVehicles[index]),
                        ),
                      ),

                      // Swipe instruction
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.swipe,
                            color: AppColors.lightSecondaryTextColor,
                            size: 16,
                          ),
                          SmallText(
                            text: ' Swipe to change car',
                            textColor: AppColors.lightSecondaryTextColor,
                          )
                        ],
                      ).paddingOnly(left: 16, right: 16, top: 28.h, bottom: 28.h)
                    ],
                  ),
                ));
        });
  }
}

// class MyVehicles extends StatefulWidget {
//   const MyVehicles({super.key});
//   @override
//   State<MyVehicles> createState() => _MyVehiclesState();
// }
// class _MyVehiclesState extends State<MyVehicles> {
//   final ScrollController _scrollController = ScrollController();
//   int _currentIndex = 0;
//   Timer? debounceTimer;
//   @override
//   void initState() {
//     super.initState();
//     _scrollController.addListener(_onScroll);
//   }
//   @override
//   void dispose() {
//     _scrollController.removeListener(_onScroll);
//     _scrollController.dispose();
//     super.dispose();
//   }
//   void _onScroll() {
//     double itemWidth = 300.0; // The width of each item in the ListView
//     double offset = _scrollController.offset;
//     int index = (offset / itemWidth).round();
//     setState(() {
//       _currentIndex = index;
//     });
//   }
//   void _scrollToIndex() {
//     double offset = _currentIndex * 320;
//     _scrollController.animateTo(
//       offset,
//       duration: const Duration(seconds: 1),
//       curve: Curves.easeInOut,
//     );
//   }
//   void debouncing({required Function() fn, int waitForMs = 2000}) {
//     debounceTimer?.cancel();
//     debounceTimer = Timer(Duration(milliseconds: waitForMs), fn);
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Text('Current Index: $_currentIndex'),
//         SizedBox(
//           height: 300,
//           child: NotificationListener<ScrollNotification>(
//             onNotification: (notification) {
//               if (notification is ScrollStartNotification ||
//                   notification is ScrollUpdateNotification) {
//               } else {
//                 debouncing(fn: () {
//                   print(':::::::Animated to index::::::');
//                   _scrollToIndex();
//                 });
//               }
//               return true;
//             },
//             child: ListView.builder(
//               scrollDirection: Axis.horizontal,
//               controller: _scrollController,
//               itemCount: 20,
//               itemBuilder: (context, index) {
//                 return Container(
//                   height: 200,
//                   width: 300.0,
//                   margin: const EdgeInsets.all(10.0),
//                   color: Colors.blue,
//                   child: Center(child: Text('Item $index')),
//                 );
//               },
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
