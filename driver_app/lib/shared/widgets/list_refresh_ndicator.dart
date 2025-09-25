import 'package:flutter/material.dart';
import '../../core/constants/app_color.dart';

class ListRefreshIndicator extends StatelessWidget {
  const ListRefreshIndicator(
      {super.key, required this.child, required this.onRefresh});
  final Widget child;
  final Future<void> Function() onRefresh;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      backgroundColor: Colors.white,
      color: AppColors.primaryColor,
      child: child,
    );
  }
}
