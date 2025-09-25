import 'package:flutter/material.dart';
import '../../../../core/constants/app_color.dart';

class NextButton extends StatelessWidget {
  const NextButton({super.key, required this.onTap});
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50,
        width: 50,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppColors.primaryColor,
          border: Border.all(width: 2.5, color: Colors.white),
          shape: BoxShape.circle,
        ),
        child: const Icon(Icons.arrow_forward, color: Colors.white, size: 24),
      ),
    );
  }
}
