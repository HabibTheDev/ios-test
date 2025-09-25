import 'package:flutter/material.dart';
import 'package:pull_to_refresh_new/pull_to_refresh.dart';
import 'package:employee_app/core/l10n/app_localizations.dart';

import '../../core/constants/app_color.dart';
import 'widget_imports.dart';

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
    final locale = AppLocalizations.of(context);
    return SmartRefresher(
      controller: refreshController,
      onRefresh: onRefresh,
      onLoading: onLoading,
      enablePullDown: true,
      enablePullUp: true,
      header: const WaterDropHeader(waterDropColor: AppColors.primaryColor, refresh: LoadingWidget()),
      footer: CustomFooter(
        builder: (context, mode) {
          final Widget body;
          if (mode == LoadStatus.idle) {
            body = BodyText(text: "${locale?.pullUpLoad}");
          } else if (mode == LoadStatus.loading) {
            body = const LoadingWidget();
          } else if (mode == LoadStatus.failed) {
            body = BodyText(text: "${locale?.loadFailed}!");
          } else if (mode == LoadStatus.canLoading) {
            body = BodyText(text: "${locale?.releaseToLoadMore}");
          } else {
            body = BodyText(text: "${locale?.noMoreData}");
          }
          return SizedBox(height: 45.0, child: Center(child: body));
        },
      ),
      child: child,
    );
  }
}
