import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/constants/app_string.dart';
import '../../core/constants/app_color.dart';

class NoDataFound extends StatelessWidget {
  const NoDataFound({super.key, this.message, this.onRefresh});
  final String? message;
  final Function()? onRefresh;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            message ?? AppString.noDataFound,
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(color: Colors.grey),
          ),
          if (onRefresh != null)
            TextButton(
              onPressed: onRefresh,
              child: Text(
                AppString.refresh,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(color: AppColors.primaryColor),
              ),
            )
        ],
      ),
    ).paddingAll(16);
  }
}
