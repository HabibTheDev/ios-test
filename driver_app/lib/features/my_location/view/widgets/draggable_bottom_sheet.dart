import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../../core/constants/app_color.dart';

class DraggableBottomSheet extends StatelessWidget {
  const DraggableBottomSheet({
    super.key,
    required this.children,
    this.initialChildSize = 0.35,
    this.minChildSize = 0.35,
    this.maxChildSize = 0.95,
  });
  final List<Widget> children;
  final double initialChildSize;
  final double minChildSize;
  final double maxChildSize;

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
        initialChildSize: initialChildSize,
        minChildSize: minChildSize,
        maxChildSize: maxChildSize,
        builder: (BuildContext context, ScrollController scrollController) {
          return Container(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 12),
              decoration: const BoxDecoration(
                  color: AppColors.lightCardColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(6),
                      topRight: Radius.circular(6))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 48,
                      height: 3,
                      decoration: const BoxDecoration(
                          color: AppColors.primaryColor,
                          borderRadius: BorderRadius.all(Radius.circular(6))),
                    ),
                  ).paddingOnly(bottom: 16),
                  Expanded(
                    child: SingleChildScrollView(
                      controller: scrollController,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: children,
                      ),
                    ),
                  )
                ],
              ));
        });
  }
}
