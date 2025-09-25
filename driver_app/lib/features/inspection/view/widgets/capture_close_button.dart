import 'package:flutter/material.dart';

class CaptureCloseButton extends StatelessWidget {
  const CaptureCloseButton({super.key, required this.onTap});
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: const CircleAvatar(
        backgroundColor: Colors.white24,
        child: Icon(
          Icons.close,
          color: Colors.white,
        ),
      ),
    );
  }
}
