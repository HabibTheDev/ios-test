import 'package:flutter/material.dart';

class RestartButton extends StatelessWidget {
  const RestartButton({super.key, required this.onTap});
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onTap,
      icon: const Icon(Icons.restart_alt, color: Colors.white),
    );
  }
}
