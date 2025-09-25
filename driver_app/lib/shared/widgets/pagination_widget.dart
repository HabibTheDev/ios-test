import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../core/constants/app_color.dart';
import 'loading_widget.dart';
import 'text_widget.dart';

class PaginationWidget extends StatelessWidget {
  const PaginationWidget({
    super.key,
    required this.onRefresh,
    required this.onLoading,
    required this.refreshController,
    required this.child,
  });
  final RefreshController refreshController;
  final Function() onRefresh;
  final Function() onLoading;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      controller: refreshController,
      onRefresh: onRefresh,
      onLoading: onLoading,
      enablePullDown: true,
      enablePullUp: true,
      header: const WaterDropHeader(waterDropColor: AppColors.primaryColor),
      footer: CustomFooter(
        builder: (context, mode) {
          final Widget body;
          if (mode == LoadStatus.idle) {
            body = const BodyText(text: "Pull up load");
          } else if (mode == LoadStatus.loading) {
            body = const LoadingWidget();
          } else if (mode == LoadStatus.failed) {
            body = const BodyText(text: "Load failed! Click retry!");
          } else if (mode == LoadStatus.canLoading) {
            body = const BodyText(text: "Release to load more");
          } else {
            body = const BodyText(text: "No more data");
          }
          return SizedBox(height: 45.0, child: Center(child: body));
        },
      ),
      child: child,
    );
  }
}
