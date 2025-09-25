import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/constants/app_assets.dart';
import '../../controller/inspection_capture_controller.dart';
import '../../model/car_side_model.dart';

class CaptureImageInstruction extends StatefulWidget {
  const CaptureImageInstruction({super.key, required this.controller});
  final InspectionCaptureController controller;

  @override
  State<CaptureImageInstruction> createState() => _AnimatedBackArrowState();
}

class _AnimatedBackArrowState extends State<CaptureImageInstruction> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _positionAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    _positionAnimation = Tween<Offset>(
      begin: const Offset(32, 0),
      end: const Offset(-32, 0),
    ).animate(_animationController);
    _animationController.repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          CarSideModel
              .carSides[widget.controller.carExteriorImageFiles.length == 4
                  ? 3
                  : widget.controller.carExteriorImageFiles.length]
              .svgAsset,
        ),
        SizedBox(
          width: 80,
          child: AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) {
              return Transform.translate(
                offset: _positionAnimation.value,
                child: SvgPicture.asset(
                  Assets.assetsSvgLeftArrow,
                  height: 24,
                ),
              );
            },
          ),
        ),
        SvgPicture.asset(
          CarSideModel
              .carSides[widget.controller.carExteriorImageFiles.length == 4
                  ? 3
                  : widget.controller.carExteriorImageFiles.length - 1]
              .svgAsset,
        ),
      ],
    );
  }
}
