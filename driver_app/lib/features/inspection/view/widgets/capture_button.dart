import 'package:flutter/material.dart';

class CaptureButton extends StatelessWidget {
  const CaptureButton({super.key, required this.onTap});
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
          border: Border.all(width: 2.5, color: Colors.white),
          shape: BoxShape.circle,
        ),
        child: const CircleAvatar(
          backgroundColor: Colors.white,
          radius: 19,
        ),
      ),
    );
  }
}
